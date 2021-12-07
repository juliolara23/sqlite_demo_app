import 'package:flutter/material.dart';
import 'package:flutter_sqlite_todo/domain/controllers/task_controller.dart';
import 'package:flutter_sqlite_todo/ui/pages/task_list_page.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(TaskController());
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: TaskListPage(),
    );
  }
}
