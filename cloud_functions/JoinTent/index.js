// Nabhan Maswood
// This cloud function is for when a user wants to join a tent. 
// It will verify the tent exists and if the user can join the tent

const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp({
  databaseURL: 'https://tent-cfd6c.firebaseio.com'
});

let name = "NOPE";
const db = admin.firestore()

//req.body.code is a string
// returns the code if sucessfully joined
// returns "False" if you did not join
exports.enterTent = async (req, res) => {

    let code = req.body.code;
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
  
	res.status(200).send(enteredTent ? code : "False");

};