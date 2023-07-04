import * as functions from "firebase-functions";
import * as  admin from "firebase-admin";

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
            cJobs.push(element.ref.set({ 'clientName': afterData['firstName'] }, { merge: true }));
        })

        return Promise.all(cJobs);
    });

