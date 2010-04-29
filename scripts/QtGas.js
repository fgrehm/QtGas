.pragma library

var persistence;

var Track, Car, currentCar;

// This method appears to be broken on WM, at least on 6.5
Number.prototype.toFixed = function(n) {
    var factor = Math.pow(10, n);
    return Math.round(this * factor)/factor;
}

function setup(p, callback) {
    persistence = p;

    persistence.connect('qtgasdb', 'Local QtGas data', 5 * 1024 * 1024, "1.0");

    Track = persistence.define('Track', {
        odometer: 'NUMBER',
        date: 'DATE',
        type: 'TEXT',
        cost: 'NUMBER',

        // Fields for fillUps
        units: 'NUMBER',
        costPerUnit: 'NUMBER',
        distancePerUnit: 'NUMBER',

        // Fields for services
        description: 'TEXT'
    });

    Car = persistence.define('Car', {
        odometer: 'NUMBER'
    });

    Car.hasMany('tracks', Track, 'car');

    persistence.schemaSync();

    Car.all().one(null, function(c){
        currentCar = c;
        if (currentCar == null) {
            currentCar = new Car({odometer: 0});
            persistence.add(currentCar);
            persistence.flush(null, callback);
        } else {
            callback();
        }
    });
}

function setCurrentCarOdometer(odometer, flush) {
    currentCar.odometer = odometer;
    persistence.add(currentCar);
    if (flush)
        persistence.flush();
}

function createFillUp(params){
    params.type = 'gas';
    params.date = new Date();
    params.distancePerUnit = ((params.odometer - currentCar.odometer) / params.units).toFixed(3);

    setCurrentCarOdometer(params.odometer, false);

    var track = new Track(params);
    currentCar.tracks.add(track);

    return track;
}
