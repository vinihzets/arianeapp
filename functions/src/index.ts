import * as functions from "firebase-functions";
import * as  admin from "firebase-admin";
admin.initializeApp(functions.config().firebase);

/**
 * Hooks
 */
export { onPerfurationCreated, onPerfurationUpdated, onPerfurationDeleted } from './hooks/perfuration_hook';
export { onClientUpdated, onClientDeleted } from './hooks/client_hook';

export { onPeriodUpdated } from './hooks/period_hook';
export { onTypePerfurationUpdated } from './hooks/type_perfuration_hook';

/**
 *  Schedulers
 */

export { pendingCleanerScheduler } from './schedulers/pending_cleaner_scheduler';
export { pendingSenderScheduler } from './schedulers/pending_sender_scheduler';

