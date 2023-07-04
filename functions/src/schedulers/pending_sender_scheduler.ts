import * as functions from "firebase-functions";
import * as  admin from "firebase-admin";

export const pendingSenderScheduler = functions.runWith({
    'timeoutSeconds': 540,
    'memory': '2GB',
}).pubsub
    .schedule('0 0 * * *')
    .timeZone('America/Sao_Paulo')
    .onRun(async _ => {
        // Query all documents ready to perform
        const now = Date.now();

        const startDay = new Date(now);
        startDay.setHours(0);
        startDay.setMinutes(0);

        const endDay = new Date(now);
        endDay.setHours(23);
        endDay.setMinutes(59);

        const query = admin.firestore().collection('pendings').where('date', '>=', startDay.getTime()).where('date', '<=', endDay.getTime());
        const tasks = await query.get();

        // Jobs to execute concurrently. 
        const cJobs: Promise<any>[] = [];

        // Loop over documents and push job.
        tasks.forEach((task) => {
            console.log('Sending message to', task.data());
        });

        return await Promise.all(cJobs);
    });
