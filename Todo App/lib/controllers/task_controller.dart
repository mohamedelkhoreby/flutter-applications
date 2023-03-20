import 'dart:convert';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo/models/task.dart';

import '../db/db_helper.dart';

class TaskController extends GetxController {
  final taskList = <Task>[].obs;
  
  Future<int> addTask({required Task task}){
return DBHelper.insert(task);
  }
  Future<void>getTask()async {
final List <Map<String , dynamic>> task =await DBHelper.query();
taskList.assignAll(task.map((data) => Task.fromJson(data)).toList());
  }
 void deleteTasks(Task task) async {
    await DBHelper.delete(task);
    getTask();
  }
void deleteAllTasks() async {
    await DBHelper.deleteAll();
    getTask();
  }
  // update data int table
void  markTaskCompleted(int id) async {
    await DBHelper.update(id);
    getTask();
  }
}
