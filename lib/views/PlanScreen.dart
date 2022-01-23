
import 'package:flutter/material.dart';
import 'package:todo_app/PlanProvider.dart';
import 'package:todo_app/controllers/plan_controller.dart';
import 'package:todo_app/models/data_layer.dart';

class PlanScreen extends StatefulWidget {
  final Plan plan;
  const PlanScreen({Key? key, required this.plan }) : super(key: key);

  @override
  _PlanScreenState createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  Plan get plan => widget.plan;

  final itemHeight = 50.0;
  late ScrollController scrollController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController = ScrollController();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Todo App'),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: _buildList()
      ),
      floatingActionButton: _buildAddTaskButton(),
    );
  }
  Widget _buildAddTaskButton(){
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        setState(() {
          final controller = PlanController();
          controller.createNewTask(plan);
        });
        scrollController.animateTo(
          itemHeight * plan.tasks.length,
          duration: Duration(microseconds: 500),
          curve: Curves.ease
        );
      },
    );
  }
  Widget _buildList(){
    return Scrollbar(
      child: ListView.builder(
        controller: scrollController,
        itemCount: plan.tasks.length,
        itemBuilder: (context, index) => _buildTaskTile(plan.tasks[index]),
      ),
    );
  }
  Widget _buildTaskTile(Task task){
    return Dismissible(
      key: ValueKey(task),
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        final controller = PlanController();
        controller.deleteTask(plan, task);
        setState(() {

        });
      },
      child: ListTile(
        leading: Builder(
          builder: (context) {
            return Checkbox(
              value: task.complete,
              onChanged: (selected) {
                setState(() {
                  task.complete = selected!;
                });
                final controller = showBottomSheet(context: context, builder: _buildBottomSheet);
                Future.delayed(Duration(seconds: 3)).then((value) {
                  controller.close();
                });
              },
            );
          }
        ),
        title: TextFormField(
          initialValue: task.description,

          onFieldSubmitted: (text) {
            setState(() {
              task.description = text;
            });
          },
        ),
      ),
    );
  }
  Widget _buildBottomSheet(BuildContext buildContext){
    return SafeArea(
      child: Container(
        color: Theme.of(context).cardColor,
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 30),
          child: Text(plan.completenessMessage),
        ),
      ),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    scrollController.dispose();
    super.dispose();
  }
}
