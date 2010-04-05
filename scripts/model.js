.pragma library

var Track;
var FillUp;
var Service;

function setup(persistence) {
    persistence.connect('qtgasdb', 'Local QtGas data', 5 * 1024 * 1024, "1.0");

    Track = persistence.define('Track', {
        odometer: 'NUMBER',
        date: 'DATE',        type: 'TEXT',
        cost: 'NUMBER',

        // Fields for fillUps
        units: 'NUMBER',
        perUnit: 'NUMBER',

        // Fields for services
        description: 'TEXT'
    });

    persistence.schemaSync();
}

//AR.persistence.schemaSync(function (tx) {
//    var t = new Track( {
//        odometer: 10,
//        date: new Date()
//    });
//    var f = new FillUp( {
//        units: 10
//    });
//    t.fillUp = f;
//    AR.persistence.add(f);
//    AR.persistence.add(t);
////
//    AR.persistence.flush(tx);
//    Track.all().prefetch('fillUp').prefetch('service').list(tx, function (results) {
//        console.log('query executed OK')
//        results.forEach(function (t) {
//            if (t.fillUp)
//                console.log(t.date.toString());
//          });
//      });
//    //AR.persistence.reset(tx);
//});
