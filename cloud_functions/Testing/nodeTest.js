const admin = require('firebase-admin');

var serviceAccount = require("./tentFirebaseAdmin.json");


admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
    databaseURL: 'https://tent-cfd6c.firebaseio.com'
  });

  const performance = require('perf_hooks').performance;


  const db = admin.firestore();


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



  async function hello() {
      let data  = {lat: 0.7111082238, long: -1.2832674697, code:"2175"};
      let code = data.code;
      let tentName = "";
      let foundTent = false;
      
      let tentLoginRef = db.collection('TentLogins').doc(code).collection('Tents');
      await tentLoginRef.get().then(snapshot =>{
            snapshot.forEach(doc => {
                if (!foundTent) {
                  let tentData = doc.data();
                  if (isUserInTent(data,tentData.Location)){
                    tentName = tentData.name;
                    foundTent = true;
                  }
                }
            });
      });

      if(foundTent){
        console.log(tentName);
      }
      else {
        console.log("Couldn't Find");
      }
    
     

  }

  let tentTest = {lat: 0.7111100868758237, long: -1.2832668076375022, radius: 0.3}
  let data  = {lat: 0.7111082238, long: -1.2832674697, code:"2175"};

  console.log(isUserInTent(data,tentTest));


hello();
  //hello();

  
