import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../sql_tables/tables.dart' as tables;
class Services {



  static Database? _database;


  Future<Database?> conn() async{
    if(_database == null ){
      return _database = await initDatabase();
    }
    return _database;
  }

  initDatabase() async{
    // get path
    Directory  databasePath =  await getApplicationDocumentsDirectory();
    String  path =  join(databasePath.path , 'task_manager.db');
    // open database and executing queries
    var db =  await openDatabase(path ,version:1 , onCreate:onCreate , onUpgrade: onUpgrade);
    return db;
  }

  onCreate(Database database , int version){
    // create sql tables;
    database.execute(tables.createNodeTable);
    database.execute(tables.createUserTable);
    print('tables has been created');
  }

  onUpgrade(Database database ,  oldVersion  , newVersion){
    if(oldVersion > 1){
      onCreate;
      print(' has been upgraded ');
    }

  }




}
