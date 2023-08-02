import * as functions from "firebase-functions";
import * as  admin from "firebase-admin";

export const onPerfurationCreated = functions.firestore.document('/perfurations/{perfurationId}')
    .onCreate(async (snap, _) => {
        const perfurationData = snap.data();

        if (perfurationData == undefined) {
            return null;
        }

        const cJobs: Promise<any>[] = [];

        const clientId = perfurationData['clientId'];
        const clientName = perfurationData['clientName'];

        const typePerfuration = perfurationData['type_perfuration'] as {
            id: string;
            name: string;
            periods: Array<{
                id: string;
                day: number;
                month: number;
                year: number;
                message: string;
            }>
        };

        const createdAt = perfurationData['createdAt'];
        const createdDate = new Date(createdAt);

        const periods = typePerfuration.periods;

        periods.forEach((element) => {
            const day = element.day;
            const month = element.month;
            const year = element.year;
            const message = element.message;

            const notifyDate = new Date(createdDate);
            notifyDate.setDate(notifyDate.getDate() + day);
            notifyDate.setMonth(notifyDate.getMonth() + month);
            notifyDate.setFullYear(notifyDate.getFullYear() + year);

            const doc = admin.firestore().collection('pendings').doc();

            cJobs.push(doc.set({
                'id': doc.id,
                'clientId': clientId,
                'clientName': clientName,
                'perfurationId': snap.id,
                'typePerfuration': typePerfuration,
                'period': element,
                'date': notifyDate.getTime(),
                'message': message,
                'sent': false,
            }))
        })

        return Promise.all(cJobs);
    });


export const onPerfurationDeleted = functions.firestore.document('/perfurations/{perfurationId}')
    .onDelete(async (snap, _) => {
        const cJobs: Promise<any>[] = [];

        const clientId = snap.data()['clientId'];
        const pendings = await admin.firestore().collection('pendings').where('clientId', '==', clientId).get();

        pendings.forEach((element) => {
            cJobs.push(element.ref.delete());
        })

        return Promise.all(cJobs);
    });


export const onPerfurationUpdated = functions.firestore.document('/perfurations/{perfurationId}')
    .onUpdate(async (snap, _) => {

        if (snap.before.data() == snap.after.data()) {
            return;
        }


        const perfurationData = snap.after.data();
        const cJobs: Promise<any>[] = [];

        const existentPendings = await admin.firestore().collection('pendings').where('perfurationId', '==', snap.before.id).get();
        existentPendings.forEach((pending) => {
            cJobs.push(pending.ref.delete());
        })

        const clientId = perfurationData['clientId'];
        const clientName = perfurationData['clientName'];

        const typePerfuration = perfurationData['type_perfuration'] as {
            id: string;
            name: string;
            periods: Array<{
                id: string;
                day: number;
                month: number;
                year: number;
                message: string;
            }>
        };

        const createdAt = perfurationData['createdAt'];
        const createdDate = new Date(createdAt);

        const periods = typePerfuration.periods;

        periods.forEach((element) => {
            const day = element.day;
            const month = element.month;
            const year = element.year;
            const message = element.message;

            const notifyDate = new Date(createdDate);
            notifyDate.setDate(notifyDate.getDate() + day);
            notifyDate.setMonth(notifyDate.getMonth() + month);
            notifyDate.setFullYear(notifyDate.getFullYear() + year);

            const doc = admin.firestore().collection('pendings').doc();

            cJobs.push(doc.set({
                'id': doc.id,
                'clientId': clientId,
                'clientName': clientName,
                'perfurationId': snap.after.id,
                'typePerfuration': typePerfuration,
                'period': element,
                'date': notifyDate.getTime(),
                'message': message,
                'sent': false,
            }, { merge: true }))
        })

        return Promise.all(cJobs);
    });
