import * as functions from "firebase-functions";
import * as  admin from "firebase-admin";


export const onClientCreated = functions.firestore.document('/clients/{clientId}')
    .onCreate(async (snap, _) => {
        const data = snap.data();
        const firstName = data['firstName'] as string;
        const lastName = data['lastName'] as string;

        let completeSearchName = firstName;

        if (lastName.length > 0) {
            completeSearchName = completeSearchName.concat(' ').concat(lastName);
        }

        return snap.ref.set({
            'completeSearchName': completeSearchName.normalize().toLowerCase(),
        }, { merge: true });
    });


export const onClientUpdated = functions.firestore.document('/clients/{clientId}')
    .onUpdate(async (snap, _) => {

        if (snap.before.data() == snap.after.data()) {
            return;
        }

        const beforeData = snap.before.data();
        const afterData = snap.after.data();

        if (beforeData['firstName'] == afterData['firstName']) {
            return;
        }

        const cJobs: Promise<any>[] = [];
        const pendings = await admin.firestore().collection('pendings').where('clientId', '==', snap.after.id).get();

        pendings.forEach((element) => {
            cJobs.push(element.ref.set({
                'clientName': afterData['firstName'],
                'clientNumber': afterData['number'],
            }, { merge: true }));
        })

        return Promise.all(cJobs);
    });


export const onClientDeleted = functions.firestore.document('/clients/{clientId}')
    .onDelete(async (snap, _) => {
        const cJobs: Promise<any>[] = [];
        const perfurations = await admin.firestore().collection('perfurations').where('clientId', '==', snap.id).get();

        perfurations.forEach((element) => {
            cJobs.push(element.ref.delete());
        })

        return Promise.all(cJobs);
    });
