import 'package:expense/db_conn.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';
import 'package:expense/DateUtils.dart';

class TransactionsRepo {

  DbConn? _databaseConnection;
  TransactionsRepo() {
    _databaseConnection = DbConn();
  }

  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _databaseConnection?.init();
      return _database;
    }
  }

  //Read All Record
  readAllData(table) async {
    var connection = await database;
    return await connection?.query(table);
  }

  //Insert User
  insertData(table, data) async {
    var connection = await database;
    String currentDate = DateUtils.currentDateToString();
    data['created_time'] = currentDate;
    data['modified_time'] = currentDate;
    print('inserting - ' + data.toString());
    return await connection?.insert(table, data);
  }

  //Read a Single Record By ID
  readDataById(table, id) async {
    var connection = await database;
    return await connection?.query(table, where: 'id=?', whereArgs: [id]);
  }

  //calculate sum of amount for given month
  Future<double> calculateAmountSumForMonth(table, yyyy_mm, type) async {
    var connection = await database;
    var output = await connection?.rawQuery(
      '''
      SELECT sum(amount) as out FROM transactions 
      WHERE strftime('%Y-%m', activity_time) = ?
      and type = ?
      ''', 
      [yyyy_mm, type]);
    double value = 0;
    if (output != null && output.isNotEmpty) {
      if (output[0]['out'] != null) {
        value = double.parse(output[0]["out"].toString());
      }
    }
    return value;
  }

  //Read for a given month
  readDataByMonth(table, yyyy_mm) async {
    var connection = await database;
    return await connection?.rawQuery('SELECT * FROM transactions WHERE strftime(\'%Y-%m\', activity_time) = ?', [yyyy_mm]);
  }
  
  //Update User
  updateData(table, data) async {
    var connection = await database;
    if (readDataById(table, data['id']) != null) {
      data['modified_time'] = DateUtils.currentDateToString();
      return await connection?.update(table, data, where: 'id=?', whereArgs: [data['id']]);
    }
  }

  //Delete User
  deleteDataById(table, id) async {
    var connection = await database;
    if (readDataById(table, id) != null) {
      return await connection?.rawDelete("delete from $table where id=$id");
    }
  }

}