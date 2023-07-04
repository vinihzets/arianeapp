import * as functions from "firebase-functions";
import * as  admin from "firebase-admin";

export const onPeriodUpdated = functions.firestore.document('/periods/{periodsId}')
    .onUpdate(async (snap, _) => {

        if (snap.before.data() == snap.after.data()) {
            return;
        }

        const afterData = snap.after.data();

        const cJobs: Promise<any>[] = [];
        const types = await admin.firestore().collection('type_perfurations').get();

        types.forEach((element) => {
            const data = element.data();
            const periods = data['periods'] as Array<{ id: string }>;
            const editedPeriods = periods.map((e) => e.id !== snap.before.id ? e : afterData);
            cJobs.push(element.ref.set({ 'periods': editedPeriods }, { merge: true }));
        })

        return Promise.all(cJobs);
    });
