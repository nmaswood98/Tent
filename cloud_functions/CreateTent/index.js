// Nabhan Maswood
// Google Cloud Function to Create Tent

const functions = require('firebase-functions');
const admin = require('firebase-admin');
const uuid = require('uuid/v4');


admin.initializeApp({
  databaseURL: 'https://tent-cfd6c.firebaseio.com'
});

const db = admin.firestore()

function doTentsOverlap(tent1, tent2){
  let deltaLat = tent2.lat - tent1.lat;
  let deltaLong = tent2.long - tent1.long;

  let a = Math.sin(deltaLat/2) * Math.sin(deltaLat/2) +
      Math.cos(tent1.lat) * Math.cos(tent2.lat) *
      Math.sin(deltaLong/2) * Math.sin(deltaLong/2);

  let c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));

  let tentDist = (6371 * c);
  let maxDist = (tent1.radius + tent2.radius); 

  return (tentDist <= maxDist);

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