importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-analytics.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-auth.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-firestore.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-storage.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js");



const firebaseConfig = {
  apiKey: "AIzaSyBamqh9BZBKexIqTWRANhTqet1U0p7-jaI",
  authDomain: "social-app-e5b23.firebaseapp.com",
  projectId: "social-app-e5b23",
  storageBucket: "social-app-e5b23.appspot.com",
  messagingSenderId: "1008606571328",
  appId: "1:1008606571328:web:dd0a019960232625c8e8a5",
  measurementId: "G-RZ3LNSQ6WT"
};
firebase.initializeApp(firebaseConfig);
firebase.analytics();
// Necessary to receive background messages:
const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((m) => {
  console.log("onBackgroundMessage", m);
});