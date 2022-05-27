import 'package:flutter/material.dart';
import 'view_tasks.dart';
import 'TaskModel.dart';
import 'dbhandler.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  late TextEditingController _titleController;
  late TextEditingController _detailsController;
  late DatabaseHandler _dbHandler;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _detailsController = TextEditingController();
    _dbHandler = DatabaseHandler();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _detailsController.dispose();
    super.dispose();
  }

  void saveTask() async {
    if (_titleController.text.length != 0 && _detailsController.text.length != 0) {
      await _dbHandler.addTask(Task(title: _titleController.text, details: _detailsController.text));
      _titleController.clear();
      _detailsController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TaskInputField(controller: _titleController, label: 'Enter task title'),
          TaskInputField(controller: _detailsController, label: 'Enter details'),
          ButtonsWidget(saveTask: saveTask, dbHandler: _dbHandler),
        ]
      )
    );
  }
}

class TaskInputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;

  const TaskInputField({Key? key, required this.controller, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            labelText: label,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.blue
                )
            ),
            enabledBorder: OutlineInputBorder()
        )
      )
    );
  }
}

class ButtonsWidget extends StatelessWidget {
  final Function() saveTask;
  final DatabaseHandler dbHandler;

  const ButtonsWidget({Key? key, required this.saveTask, required this.dbHandler }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(child: Text('Save'), onPressed: saveTask),
          ElevatedButton(child: Text('View'), onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => TaskList(dbHandler: dbHandler)));
          })
        ]
      )
    );
  }
}
