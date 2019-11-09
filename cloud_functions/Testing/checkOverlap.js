 // metres

 function toRadians(degrees)
 {
   var pi = Math.PI;
   return degrees * (pi/180);
 }


let radiusKM = 5;
let tent1 = {lat:toRadians(40.706901), long:toRadians(-73.626782), radius:7}
let tent2 = {lat:toRadians(40.766213), long: toRadians(-73.435895), radius:10}



// Both Tents are assumed to have lat long and radius
// Lat and Long in radians
// radius in KM 
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


    if(doTentsOverlap(tent1,tent2)){
        console.log("Overlap");
    }
    else{
        console.log("No Overlap");
    }


