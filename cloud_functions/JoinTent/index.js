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
    let tentName = "False";
    let tentLoginRef = db.collection('TentLogins').doc(code).collection('Tents');
    await tentLoginRef.get().then(snapshot =>{
        	snapshot.forEach(doc => {
             	let docName = doc.data().name;
              	if(docName){
                	tentName = docName;
                }
   	 		});
    });
  
    resolve(tentName)
    })

});