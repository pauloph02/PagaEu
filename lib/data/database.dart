

import 'package:paga_eu/data/people_dao.dart';
import 'package:paga_eu/data/task_dao.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB {
  DB._();
  static final DB instance = DB._();
  static Database? _database;

  get database async{
    if(_database != null) return _database;
  }
}

Future<Database> getDatabase() async{
  final String path =  join(await getDatabasesPath(), 'service.db');
  

  return openDatabase(path, onCreate: (db, version)async{
    await db.execute(TaskDao.tableSql);
    await db.execute(PeopleDao.tableSql);

  }, version: 1);
}


