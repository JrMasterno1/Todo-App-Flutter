import 'package:flutter/material.dart';
import 'package:todo_app/controllers/plan_controller.dart';
import 'package:todo_app/models/data_layer.dart';

class PlanProvider extends InheritedWidget {
  final _controller = PlanController();

  PlanProvider({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  static PlanController of(BuildContext context) {
    final PlanProvider? result =
        context.dependOnInheritedWidgetOfExactType<PlanProvider>();
    assert(result != null, 'No PlanProvider found in context');
    return result!._controller;
  }

  @override
  bool updateShouldNotify(PlanProvider old) {
    return false;
  }
}
