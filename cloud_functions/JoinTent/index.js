const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp({
  databaseURL: 'https://tent-cfd6c.firebaseio.com'
});

let name = "NOPE";
const db = admin.firestore()

function isUserInTent(userLoc, tent){
    
  let deltaLat = tent.lat - userLoc.lat;
  let deltaLong = tent.long - userLoc.long;

  let a = Math.sin(deltaLat/2) * Math.sin(deltaLat/2) +
      Math.cos(userLoc.lat) * Math.cos(tent.lat) *
      Math.sin(deltaLong/2) * Math.sin(deltaLong/2);

  let c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));

  let tentDist = (6371 * c);

  return (tentDist <= tent.radius);

}

exports.enterTent = functions.https.onCall((data, context) => {
  return new Promise(async (resolve, reject) => {

    let code = data.code;
    let tentLocationData = {};
    let foundTent = false;
    let foundTentData = {};
    let tentLoginRef = db.collection('TentLogins').doc(code).collection('Tents');
    await tentLoginRef.get().then(snapshot =>{
          snapshot.forEach(doc => {
              if (!foundTent) {
                let tentData = doc.data();
                if (isUserInTent(data,tentData.Location)){
                  tentLocationData = tentData.Location;
                  foundTent = true;
                  foundTentData = tentData;
                }
              }
          });
    });

    if(foundTent){
      let isGooglePhotos = foundTentData.googlePhotos;
      let tentName = foundTentData.name;
      let shareToken = foundTentData.shareToken;
      if(isGooglePhotos){
        if(tentName != null && shareToken != null){
          resolve({id:foundTentData.id,Location:tentLocationData, name: tentName, shareToken: shareToken, googlePhotos: true});
        }
        else{
          reject("Error in google photos tent");
        }
        
      }else{
        resolve({id:foundTentData.id,Location:tentLocationData, googlePhotos: false});
      }
      
    }
    else {
      reject("Couldn't Find Tent");
    }

    });
});