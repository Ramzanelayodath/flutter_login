import 'package:flutter_login/User.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io' as io;

class DBHelper
{
  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }
  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "test.db");
    var theDb = await openDatabase(path, version: 3, onCreate: _onCreate);
    return theDb;
  }
  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute("CREATE TABLE USER(id INTEGER PRIMARY KEY, username TEXT, password TEXT, name TEXT )");
    print("Created tables");
  }
  void saveUser(User user) async
  {
    var dbClient = await db;
    await dbClient.transaction((txn) async
    {
      return await txn.rawInsert('INSERT INTO USER (username,password,name) VALUES (\'${user.username}\', \'${user.password}\',\'${user.name}\')');
    });
  }
  Future<List<User>> getUser(String username) async {
    var dbClient = await db;
    List<Map> list = await dbClient.query("USER",columns: ['username','password','name'],where: 'username = ?',whereArgs: [username]);
    List<User> employees = new List();
    for (int i = 0; i < list.length; i++) {
      employees.add(new User(list[i]["username"],list[i]["password"],list[i]["name"]));
      print("data "+employees[i].password);
    }
    print(employees.length);
    return employees;
  }

}