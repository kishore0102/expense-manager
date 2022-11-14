import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DbConn {

  Future<Database> init() async {
    print("init database");
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'expense.db');
    var database = await openDatabase(path, version: 1, onCreate: _createDatabase);
    return database;
  }

  Future<void> _createDatabase(Database database, int version) async {
    print("creating database");
    String sql = 
      '''
      CREATE TABLE transactions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        category TEXT NOT NULL,
        note TEXT,
        amount DOUBLE NOT NULL,
        type TEXT NOT NULL,
        activity_time TEXT NOT NULL,
        created_time TEXT NOT NULL,
        modified_time TEXT NOT NULL
      );
      ''';
    await database.execute(sql);
  }

}