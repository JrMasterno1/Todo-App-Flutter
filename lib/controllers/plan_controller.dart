
import 'package:todo_app/models/data_layer.dart';

class PlanController {
  final _plans = <Plan>[];
  List<Plan> get plans => List.unmodifiable(_plans);

  void addNewPlan(String name){
    if(name.isEmpty) return;

    final plan = Plan()..name = name;
    _plans.add(plan);
  }
  void deletePlan(Plan plan){
    _plans.remove(plan);
  }
  void createNewTask(Plan plan, [String? desc]){
    if(desc == null) desc = 'New task';
    final task = Task()..description = desc;
    plan.tasks.add(task);
  }
  void deleteTask(Plan plan, Task task){
    plan.tasks.remove(task);
  }
}