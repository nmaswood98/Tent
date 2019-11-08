// Nabhan Maswood
// Google Cloud Function to Create Tent

const functions = require('firebase-functions');
const admin = require('firebase-admin');
const uuid = require('uuid/v4');


admin.initializeApp({
  databaseURL: 'https://tent-cfd6c.firebaseio.com'
});

const db = admin.firestore()
const ky = 40000 / 360;

function checkTentOverlap(checkPoint, centerPoint, distance) {
  
  var kx = Math.cos(Math.PI * centerPoint.lat / 180.0) * ky;
  var dx = Math.abs(centerPoint.long - checkPoint.long) * kx;
  var dy = Math.abs(centerPoint.lat - checkPoint.lat) * ky;
  return Math.sqrt(dx * dx + dy * dy) <= distance;
}


exports.createTent = async (req, res) => {

    const {lat, long, radius} = req.body;
    let code = Math.floor(1000 + Math.random() * 9000) + "";
    let canCreateTent = false;

    let tentLoginRef = db.collection('TentLogins').doc(code).collection("Tents");
    await tentLoginRef.get().then(snapshot => {
      if(snapshot.exists){
        let codeExists = false;
        let codeDict = {};
        snapshot.forEach(function(doc) {
          codeDict[doc.id] = 1;
          let tentData = doc.data();
          let 
          if (doc.id === code) {
            codeExists = true;
          }
        });
      }



        if (codeExists) {
          do {
            code = Math.floor(1000 + Math.random() * 9000) + "";
          } while (codeDict.hasOwnProperty(code));
        }

        canCreateTent = true;

    });

    if(canCreateTent){

        let tentName = uuid();
        await tentLoginRef.doc(code).set({"exists":true})
        await tentLoginRef.doc(code).collection('Tents')
          .add({
            name: tentName,
            lat: lat,
            long: long
          })
          .then(function(docRef) {
            res.status(200).send(code);
          })
          .catch(function(error) {
            res.status(200).send("False");
          });

    }
    else{
        res.status(200).send("False");
    }
  
	

};