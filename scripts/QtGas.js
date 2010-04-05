.pragma library

var persistence;

var Track;

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
                odometer = result[0].odometer;
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
