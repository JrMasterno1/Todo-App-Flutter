import 'package:todo_app/models/task.dart';

class Plan {
  List<Task> tasks = [];
  String name = '';
  int get completeCount => tasks.where((element) => element.complete).length;
  String get completenessMessage => '$completeCount out of ${tasks.length} tasks';
}