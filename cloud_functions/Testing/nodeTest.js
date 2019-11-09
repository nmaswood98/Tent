const admin = require('firebase-admin');

var serviceAccount = require("./tentFirebaseAdmin.json");


admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
    databaseURL: 'https://tent-cfd6c.firebaseio.com'
  });

  const performance = require('perf_hooks').performance;


  const db = admin.firestore();

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

  async function test(){
    
     tentReference = db
        .collection("Tents")
        .where('code','==','1234')

        let a = performance.now();
        await tentReference.get().then(snapshot => {
          snapshot.forEach(function(doc) {
            let tent = doc.data().Location;
            console.log(tent);
          });
        });
        let b = performance.now();

        console.log("Call to doSomething took " + (b - a) + " milliseconds.");


        tentReference2 = db
        .collection("TentLogins")
        .doc('1234')
        .collection('Tents');


        a = performance.now();
        await tentReference2.get().then(snapshot => {
          snapshot.forEach(function(doc) {
            let tent = doc.data().Location;
            console.log(tent);
          });
        });
        b = performance.now();
        console.log("Call to doSomething took " + (b - a) + " milliseconds.");


      

    
  }

  async function hello() {
    let testTent = { lat: 0.71246300071, long: -1.2753712511, radius: 50 };
    let tentName = "TENTY";
    let code = "-404";
    let needNewCode = true;
    let tentReference = null;

    let tentLoginRef = db
    .collection("TentLogins")

    while (needNewCode) {
      code = Math.floor(1000 + Math.random() * 9000) + "";

      tentReference = tentLoginRef
        .doc(code)
        .collection("Tents");

      needNewCode = false;

      await tentReference.get().then(snapshot => {
        snapshot.forEach(function(doc) {
          let tent = doc.data().Location;
          console.log(tent);
          if (tent && !needNewCode && doTentsOverlap(tent, testTent)) {
            needNewCode = true;
          }
        });
      });

    }

    await tentLoginRef.doc(code).set({ exists: true });

    await tentReference
      .add({
        "Location": {lat: testTent.lat, long: testTent.long, radius: testTent.radius},
        name: tentName
      })
      .then(function(docRef) {
        console.log(code);
      })
      .catch(function(error) {
        console.log("False");
      });

  }

  hello();

  
