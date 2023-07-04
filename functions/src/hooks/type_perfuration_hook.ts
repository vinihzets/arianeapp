import * as functions from "firebase-functions";
import * as  admin from "firebase-admin";

export const onTypePerfurationUpdated = functions.firestore.document('/type_perfurations/{typePerfurationId}')
    .onUpdate(async (snap, _) => {

        if (snap.before.data() == snap.after.data()) {
            return;
        }

        const afterData = snap.after.data();

        const cJobs: Promise<any>[] = [];
        const perfurations = await admin.firestore().collection('perfurations').where('type_perfuration.id', '==', snap.before.id).get();

        perfurations.forEach((element) => {
            cJobs.push(element.ref.set({ 'type_perfuration': afterData }, { merge: true }));
        })

        return Promise.all(cJobs);
    });