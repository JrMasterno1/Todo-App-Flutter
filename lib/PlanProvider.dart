import 'package:flutter/material.dart';
import 'package:todo_app/models/data_layer.dart';

class PlanProvider extends InheritedWidget {
  final _plan = Plan();

  PlanProvider({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  static Plan of(BuildContext context) {
    final PlanProvider? result =
        context.dependOnInheritedWidgetOfExactType<PlanProvider>();
    assert(result != null, 'No PlanProvider found in context');
    return result!._plan;
  }

  @override
  bool updateShouldNotify(PlanProvider old) {
    return false;
  }
}
