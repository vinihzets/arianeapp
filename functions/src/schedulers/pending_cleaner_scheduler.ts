import * as functions from "firebase-functions";
import * as  admin from "firebase-admin";

export const fixClientId = functions.runWith({
    'timeoutSeconds': 540,
    'memory': '2GB',
}).pubsub
    .schedule('* * 1 * *')
    .timeZone('America/Sao_Paulo')
    .onRun(async _ => {
        // Jobs to execute concurrently. 
        const cJobs: Promise<any>[] = [];

        const periods = await admin.firestore().collection('periods').get();
        const clients = await admin.firestore().collection('clients').get();
        const scheduling_messages = await admin.firestore().collection('scheduling_messages').get();
        const type_perfurations = await admin.firestore().collection('type_perfurations').get();
        const perfurations = await admin.firestore().collection('perfurations').get();
        const pendings = await admin.firestore().collection('pendings').get();

        periods.forEach((doc) => cJobs.push(doc.ref.update({ 'userId': 'FoMBZFAFIhOps0yPXAuK6xmWHvn1' })))
        clients.forEach((doc) => cJobs.push(doc.ref.update({ 'userId': 'FoMBZFAFIhOps0yPXAuK6xmWHvn1' })))
        scheduling_messages.forEach((doc) => cJobs.push(doc.ref.update({ 'userId': 'FoMBZFAFIhOps0yPXAuK6xmWHvn1' })))
        type_perfurations.forEach((doc) => cJobs.push(doc.ref.update({ 'userId': 'FoMBZFAFIhOps0yPXAuK6xmWHvn1' })))
        perfurations.forEach((doc) => cJobs.push(doc.ref.update({ 'userId': 'FoMBZFAFIhOps0yPXAuK6xmWHvn1' })))
        pendings.forEach((doc) => cJobs.push(doc.ref.update({ 'userId': 'FoMBZFAFIhOps0yPXAuK6xmWHvn1' })))

        return await Promise.all(cJobs);
    });
