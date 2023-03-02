const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp(functions.config().firebase);

// // Create and deploy your first functions
// // https://firebase.google.com/docs/functions/get-started
//
//exports.firestoreToNotification = functions
//    .firestore
//    .document('chat/{message}')
//    .onCreate((snapshot, context) => {
//        functions.logger.info('Logging snapshot', snapshot);
//        return admin.messaging().send('chat', {
//            notification: {
//                title: snapshot.data().username.stringValue,
//                body: snapshot.data().text.stringValue,
//                clickAction: 'FLUTTER_NOTIFICATION_CLICK',
//            },
//        });
//    });


