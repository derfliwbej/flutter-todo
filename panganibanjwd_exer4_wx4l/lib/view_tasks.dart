import 'package:flutter/material.dart';
import 'TaskModel.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Task>> fetchTasks() async {
  final res = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));
  final tasks;

  if(res.statusCode == 200) {
    tasks = jsonDecode(res.body).cast<Map<String, dynamic>>();
    return tasks.map<Task>((task) => Task.fromMap(task)).toList();
  } else {
    throw Exception('Failed to load task');
  }
}

class TaskList extends StatefulWidget {

  const TaskList({ Key? key }) : super(key: key);

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  late Future<List<Task>> futureTasks;

  @override
  void initState() {
    super.initState();
    futureTasks = fetchTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
            appBar: AppBar(
                title: const Text('To Do List')
            ),
            body: const Text('This contains the To Do List')
        )
    );
  }
}