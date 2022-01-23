
import 'package:flutter/material.dart';
import 'package:todo_app/PlanProvider.dart';
import 'package:todo_app/models/data_layer.dart';

import 'PlanScreen.dart';

class PlanCreatorScreen extends StatefulWidget {
  const PlanCreatorScreen({Key? key}) : super(key: key);

  @override
  _PlanCreatorScreenState createState() => _PlanCreatorScreenState();
}

class _PlanCreatorScreenState extends State<PlanCreatorScreen> {
  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Plan Manager'),),
      body: Column(
        children: [
          _buildListCreator(),
          Expanded(child: _buildManagePlan())
        ],
      ),
    );
  }
  Widget _buildListCreator(){
    return Padding(
      padding: EdgeInsets.all(20),
      child: Material(
        color: Theme.of(context).cardColor,
        elevation: 10,
        child: TextField(
          controller: textController,
          decoration: InputDecoration(
            labelText: 'Add a plan',
            contentPadding: EdgeInsets.all(20),
          ),
          onEditingComplete: addPlan,
        ),
      ),
    );
  }
  void addPlan(){
    final text = textController.text;
    if(text.isEmpty) return;
    final plan = Plan()..name = text;
    PlanProvider.of(context).add(plan);
    textController.clear();
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {

    });
  }
  Widget _buildManagePlan(){
    final plans = PlanProvider.of(context);
    if(plans.isEmpty){
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.note, size: 100, color: Colors.grey,)
        ],
      );
    }
    return ListView.builder(
      itemCount: plans.length,
      itemBuilder: (context, index) {
        final plan = plans[index];
        return ListTile(
          title: Text(plan.name),
          subtitle: Text(plan.completenessMessage),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => PlanScreen(plan: plan)
            ));
          },
        );
      },
    );
  }
}
