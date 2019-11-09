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

exports.createTent = functions.https.onCall((newTentLoc, context) => {
  return new Promise(async (resolve, reject) => {
    let tentName = uuid();
    let code = ""; let needNewCode = true; let tentReference = null;

    let tentLoginRef = db.collection("TentLogins");

    while (needNewCode) {
      code = Math.floor(1000 + Math.random() * 9000) + "";

      tentReference = tentLoginRef.doc(code).collection("Tents");

      needNewCode = false;

      await tentReference.get().then(snapshot => {
        snapshot.forEach(function(doc) {
          let tent = doc.data().Location;
          console.log(tent);
          if (tent && !needNewCode && doTentsOverlap(tent, newTentLoc)) {
            needNewCode = true;
          }
        });
      });
    }

    await tentLoginRef.doc(code).set({ exists: true });

    await tentReference
      .add({
        Location: {
          lat: newTentLoc.lat,
          long: newTentLoc.long,
          radius: newTentLoc.radius
        },
        name: tentName
      })
      .then(function(docRef) {
        resolve({code:code, name: tentName});
      })
      .catch(function(error) {
        reject("Could not create the tent");
      });
  });
});