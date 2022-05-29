import 'package:flutter/material.dart';
import 'view_tasks.dart';

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

Future<http.Response> createTask(String title) {
  return http.post(
    Uri.parse('https://jsonplaceholder.typicode.com/todos'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'title': title,
    }),
  );
}

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  late TextEditingController _titleController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void saveTask() async {
    if (_titleController.text.length != 0) {
      _titleController.clear();
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
          ButtonsWidget(saveTask: saveTask),
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

  const ButtonsWidget({Key? key, required this.saveTask }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(child: Text('Save'), onPressed: saveTask),
          ElevatedButton(child: Text('View'), onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => TaskList()));
          })
        ]
      )
    );
  }
}
