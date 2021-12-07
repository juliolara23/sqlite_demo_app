import 'package:flutter_sqlite_todo/data/models/task_model.dart';
import 'package:flutter_sqlite_todo/data/repositories/task_repository.dart';
import 'package:get/state_manager.dart';
import 'package:get/get.dart';

class TaskController extends GetxController {
  final _tasks = <TaskModel>[].obs;
  TaskRepository repository = Get.find();
  //List<TaskModel> get getAllTasks =>

  List<TaskModel> get tasks => _tasks;

  @override
  onInit() {
    super.onInit();
    getAllTasks();
  }

  Future<void> addTask(task) async {
    // TODO metodo para añadir tareas
    try {
      await repository.addTask(task);
      _tasks.add(task);
    } catch (e) {
      print("ha ocurrido un error al guardar la tarea");
    }
  }

  Future<void> getAllTasks() async {
    // TODO metodo para obtener todas las tareas existentes
    try {
      _tasks.addAll(await repository.getAllTasks());
    } catch (e) {
      print("ha ocurrido un error al consultar todas las tareas");
    }
  }

  Future<void> deleteTask(id) async {
    // TODO metodo para eliminar una tarea especifica
    try {
      final index = _tasks.indexWhere((task) => task.id == id);
      await repository.deleteTask(id);
      _tasks.removeAt(index);
    } catch (e) {
      print("ha ocurrido un error al eliminar la tarea");
    }
  }

  Future<void> deleteAll() async {
    // TODO metodo para eliminar todas las tareas
    try {
      await repository.deleteAll();
      _tasks.clear();
    } catch (e) {
      print("ha ocurrido un error al borrar todas las tareas");
    }
  }

  Future<void> updateTask(user) async {
    // TODO metodo para actualizar tareas de un usuario especifico
    try {
      final index = _tasks.indexWhere((task) => task.id == user.id);
      await repository.updateTask(user);
      _tasks[index] = user;
    } catch (e) {
      print("ha ocurrido un error al actualizar la tarea");
    }
  }
}
