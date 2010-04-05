.pragma library

var persistence;

var Track;

// This method appears to be broken on WM, at least on 6.5
Number.prototype.toFixed = function(n) {
    var factor = Math.pow(10, n);
    return Math.round(this * factor)/factor;
}


function setup(p) {
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

    persistence.schemaSync();

    Track.carOdometer = function() {
        var odometer;
        persistence.transaction(function(tx){
            tx.executeSql('SELECT MAX(odometer) AS odometer FROM Track', null, function(result){
                if (result[0].odometer)
                    odometer = parseInt(result[0].odometer);
                else
                    odometer = 0;
            });
        });
        return odometer;
    }
}

function createFillUp(params){
    params.type = 'gas';
    params.date = new Date();
    params.distancePerUnit = ((params.odometer - Track.carOdometer()) / params.units).toFixed(3);

    var track = new Track(params);

    persistence.add(track);
    persistence.flush();

    return track;
}
