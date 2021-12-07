import 'package:flutter/material.dart';
import 'package:flutter_sqlite_todo/ui/home.dart';
import 'package:get/get.dart';

import 'data/repositories/task_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(TaskRepository());
  runApp(const Home());
}
