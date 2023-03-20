import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import '../models/task.dart';
class DBHelper {
  static Database? database;
  static const int version =1;
  static const String tableName ='task';
  static Future <void> initDb()async{
    if(database!= null){
      debugPrint('not nual database');
      return;}
    else{
      try{
        String path = '${await getDatabasesPath()}task.database';
        database = await openDatabase( path , version: 1 ,
            onCreate: (Database db, int version) async {
              debugPrint('creating a new one');
              await db.execute(
                  'CREATE TABLE $tableName ('
                      'id INTEGER PRIMARY KEY AUTOINCREMENT, '
                      'title STRING, note TEXT, date STRING, '
                      'startTime STRING, endTime STRING, '
                      'remind INTEGER, repeat STRING, '
                      'color INTEGER, '
                      'isCompleted INTEGER)'
              );});}
      catch(e){
        if (kDebugMode) {
          print(e);
        }
      }
    }
  }
  static Future<int>insert (Task task)async{
    return await database!.insert(tableName, task.toJson());
  }
  static Future<int>delete (Task task)async{
    return await database!.delete(tableName , where: 'id = ?', whereArgs:[task.id]);
  }
    static Future<int> deleteAll() async {
    return await database!.delete(tableName);
  }

  static Future<int>update(int id)async{
    return await database!.rawUpdate('''
  UPDATE tasks 
  SET isComplated = ?
  WHERE id =?
''',[1,id]);
  }
  static Future<List<Map<String,dynamic>>> query()async{
    return await database!.query(tableName);
  }
}
