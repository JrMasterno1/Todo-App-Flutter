
import 'package:flutter/material.dart';
import 'package:todo_app/models/data_layer.dart';

class PlanScreen extends StatefulWidget {
  const PlanScreen({Key? key}) : super(key: key);

  @override
  _PlanScreenState createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  final plan = Plan();
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
          plan.tasks.add(Task());
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
    return ListTile(
      leading: Checkbox(
        value: task.complete,
        onChanged: (selected) {
          setState(() {
            task.complete = selected!;
          });
        },
      ),
      title: TextField(
        onChanged: (text) {
          setState(() {
            task.description = text;
          });
        },
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
