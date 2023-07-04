import * as functions from "firebase-functions";
import * as  admin from "firebase-admin";

export const pendingCleanerScheduler = functions.runWith({
    'timeoutSeconds': 540,
    'memory': '2GB',
}).pubsub
    .schedule('1 0 * * *')
    .timeZone('America/Sao_Paulo')
    .onRun(async _ => {
        // Query all documents ready to perform
        const now = new Date(Date.now());

        const query = admin.firestore().collection('pendings').where('date', '<', now.getTime());
        const tasks = await query.get();

        // Jobs to execute concurrently. 
        const cJobs: Promise<any>[] = [];

        // Loop over documents and push job.
        tasks.forEach((task) => {
            cJobs.push(task.ref.delete());
        });

        return await Promise.all(cJobs);
    });
