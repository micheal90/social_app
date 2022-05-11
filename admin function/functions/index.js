const functions = require("firebase-functions");


const admin = require('firebase-admin');
const { messaging } = require("firebase-admin");
admin.initializeApp(functions.config().functions);


exports.postTrigger = functions.firestore.document('posts/{postId}').onCreate(async (snapshot, context) => {
    var payLoad = {
        Notification: {
            title: 'New Post',
            body: snapshot.data.name,
            sound: "default"
        }, data: {
            click_action: "FLUTTER_NOTIFIGATION_CLICK",
        }
    }
    admin.messaging().sendAll(messaging)
});