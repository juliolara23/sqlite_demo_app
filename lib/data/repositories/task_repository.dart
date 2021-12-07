import 'package:flutter_sqlite_todo/data/datasources/local/database.dart';
import 'package:flutter_sqlite_todo/data/models/task_model.dart';

class TaskRepository {
  late TaskLocalDataSource localDataSource;

  TaskRepository() {
    //print("Starting UserRepository");
    localDataSource = TaskLocalDataSource();
  }

  Future<List<TaskModel>> getAllTasks() async =>
      await localDataSource.getAllTasks();

  Future<void> addTask(task) async => await localDataSource.addTask(task);

  Future<void> deleteTask(id) async => await localDataSource.deleteTask(id);

  Future<void> deleteAll() async => await localDataSource.deleteAll();

  Future<void> updateTask(task) async => await localDataSource.updateTask(task);
}
