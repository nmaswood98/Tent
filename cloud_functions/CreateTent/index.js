// Nabhan Maswood
// Google Cloud Function to Create Tent

const functions = require('firebase-functions');
const admin = require('firebase-admin');
const uuid = require('uuid/v4');

const alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789ABCDEFGHIJKLMNOPQRZTUVWXYZ";


admin.initializeApp({
  databaseURL: 'https://tent-cfd6c.firebaseio.com'
});

const db = admin.firestore()

function doTentsOverlap(tent1, tent2) {
  let deltaLat = tent2.lat - tent1.lat;
  let deltaLong = tent2.long - tent1.long;

  let a = Math.sin(deltaLat / 2) * Math.sin(deltaLat / 2) +
    Math.cos(tent1.lat) * Math.cos(tent2.lat) *
    Math.sin(deltaLong / 2) * Math.sin(deltaLong / 2);

  let c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));

  let tentDist = (6371 * c);
  let maxDist = (tent1.radius + tent2.radius);

  return (tentDist <= maxDist);

}

exports.createTent = functions.https.onCall((data, context) => {
  return new Promise(async (resolve, reject) => {
    let newTentLoc = data.newTentLoc;
    let publicTent = data.public;
    let tentName = data.tentName;
    let tentID = uuid();
    let code = ""; let needNewCode = true; let tentReference = null;

    let tentLoginRef = db.collection("TentLogins");

    while (needNewCode) {
      code = Array(4).join().split(',').map(function () { return alphabet.charAt(Math.floor(Math.random() * alphabet.length)); }).join('');

      tentReference = tentLoginRef.doc(code).collection("Tents");

      needNewCode = false;

      await tentReference.get().then(snapshot => {
        snapshot.forEach(function (doc) {
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
        id: tentID
      })
      .then(function (docRef) {

        if (publicTent) {
          db.collection("PublicTents").doc(tentID).set({
            Location: {
              lat: newTentLoc.lat,
              long: newTentLoc.long,
              radius: newTentLoc.radius
            }
          }).then(function (ref) {
            resolve({ code: code, id: tentID, public: true });
          });
        }
        else {
          resolve({ code: code, id: tentID, public: false });
        }
      })
      .catch(function (error) {
        reject("Could not create the tent");
      });
  });
});