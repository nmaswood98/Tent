const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp({
  databaseURL: 'https://tent-cfd6c.firebaseio.com'
});

let name = "NOPE";
const db = admin.firestore()

exports.enterTent = functions.https.onCall((data, context) => {
  return new Promise(async (resolve, reject) => {
    
  
    let code = data.code;
    let enteredTent = false;
    let tentLoginRef = db.collection('TentLogins').doc(code);
    await tentLoginRef.get().then(snapshot =>{
      if (snapshot.exists) {
        enteredTent = true;
        // Need to check location also
      } else {
        enteredTent = false;
      }
    });
  
	
    resolve(enteredTent ? code : "False")
    });

});