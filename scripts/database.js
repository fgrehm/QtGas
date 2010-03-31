var db = openDatabaseSync("QtGas", "1.0", "Local QtGas data", 100);

function setup() {
    db.transaction(
        function(tx) {
            // TODO: Record is not a good table name
            tx.executeSql('CREATE TABLE IF NOT EXISTS Record(id INTEGER PRIMARY KEY AUTOINCREMENT, date DATETIME, cost NUMBER)');
            tx.executeSql('CREATE TABLE IF NOT EXISTS FillUp(id INTEGER PRIMARY KEY, amount NUMBER, perunit NUMBER)');
            tx.executeSql('CREATE TABLE IF NOT EXISTS Service(id INTEGER PRIMARY KEY, description TEXT)');
        }
    );
}

function reloadData() {
    db.transaction(
        function(tx) {
            myModel.clear();
            var rs = tx.executeSql('SELECT *, (CASE WHEN f.id ISNULL THEN \'service\' ELSE \'gas\' END) AS type FROM Record r LEFT JOIN FillUp f ON r.id = f.id LEFT JOIN Service s ON s.id = r.id ORDER BY r.id DESC');
            for(var i = 0; i < rs.rows.length; i++){
                myModel.append(rs.rows.item(i));
            }
        }
    );
}

function insertRecord(tx, date, cost) {
    tx.executeSql(
        "INSERT INTO Record (date, cost) VALUES(?, ?)",
        [date, cost]
    );

    var rs = tx.executeSql('SELECT last_insert_rowid() AS id');
    return rs.rows.item(0).id;
}


function insertGas() {
    var date = new Date();
    // TODO: should store dates as dates, not string
    date = Qt.formatDateTime(date, 'MMM d, yyyy');

    var amount = Math.floor(Math.random() * 50.0);
    var cost = Math.floor(Math.random() * 100.0);
    var perunit = Math.floor(Math.random() * 6) + 8;

    db.transaction(
        function(tx) {
            var id = insertRecord(tx, date, cost);
            tx.executeSql(
                    "INSERT INTO FillUp (id, amount, perunit) VALUES(?, ?, ?)",
                    [id, amount, perunit]
            );
        }
    );

    reloadData();
}

function insertService() {
    var date = new Date();
    // TODO: should store dates as dates, not string
    date = Qt.formatDateTime(date, 'MMM d, yyyy');

    var cost = Math.floor(Math.random() * 100.0);
    var description = 'Oil Change';

    db.transaction(
        function(tx) {
            var id = insertRecord(tx, date, cost);
            tx.executeSql(
                    "INSERT INTO Service (id, description) VALUES(?, ?)",
                    [id, description]
            );
        }
    );

    reloadData();
}
