import 'package:flutter/material.dart';
import 'package:flutter_sqlite_todo/domain/controllers/task_controller.dart';
import 'package:flutter_sqlite_todo/ui/pages/task_detail_page.dart';
import 'package:flutter_sqlite_todo/ui/widgets/list_item.dart';
import 'package:get/get.dart';

class TaskListPage extends StatelessWidget {
  const TaskListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //HomeController controller = Get.find();
    TaskController taskController = Get.find();
    return Scaffold(
      appBar: AppBar(title: const Text("Task list"), actions: <Widget>[
        IconButton(
            key: const Key('deleteAllButton'),
            onPressed: () {
              String title = 'error';
              String message = "";
              bool showError = false;
              // TODO realiza el llamado al metodo para eliminar una tarea
              try {
                taskController.deleteAll();
              } catch (e) {
                showError = true;
                e.printError();
                message = "Ha ocurrido un error";
              }
              if (showError) {
                Get.snackbar(title, message,
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.green[400],
                    duration: const Duration(milliseconds: 1500),
                    colorText: Colors.white,
                    icon: const Icon(Icons.update),
                    barBlur: 0.5);
              } else {
                Get.back();
              }
              // TODO realiza el llamado al metodo para eliminar todas las tareas
            },
            icon: const Icon(Icons.delete))
      ]),
      floatingActionButton: FloatingActionButton(
        key: const Key('addTaskButton'),
        child: const Icon(Icons.add),
        onPressed: () async {
          Get.to(() => const TaskDetailPage(),
              arguments: [false, "Create new Task"]);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _getXlistView(),
      ),
    );
  }

  Widget _getXlistView() {
    TaskController taskController = Get.find();
    return Obx(
      () => ListView.builder(
        itemCount: taskController.tasks.length,
        itemBuilder: (context, index) {
          final task = taskController.tasks[index];
          return ListItem(task);
        },
      ),
    );
  }
}
