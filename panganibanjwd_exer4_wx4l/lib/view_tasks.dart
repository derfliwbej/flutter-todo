import 'package:flutter/material.dart';
import 'dbhandler.dart';
import 'TaskModel.dart';

class TaskList extends StatefulWidget {

  const TaskList({ Key? key }) : super(key: key);

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
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