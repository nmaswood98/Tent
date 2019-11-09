const admin = require('firebase-admin');

var serviceAccount = require("./tentFirebaseAdmin.json");


admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
    databaseURL: 'https://tent-cfd6c.firebaseio.com'
  });

  const db = admin.firestore()

  let tentLoginRef = db.collection('TentLogins').doc("1234").collection("Tents");
  tentLoginRef.get().then(snapshot => {
    snapshot.forEach(function(doc) {
        console.log(doc.data());
      });
  });