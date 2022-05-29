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

Future<http.Response> deleteTask(int id) {
  return http.delete(
    Uri.parse('https://jsonplaceholder.typicode.com/todos/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
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
            body: FutureBuilder(
                future: futureTasks,
                builder: (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                              key: ValueKey<int>(snapshot.data![index].id!),
                              title: Text(snapshot.data![index].title.toString()),
                              trailing: Wrap(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.create_outlined),
                                    onPressed: () async {
                                      setState(() {});
                                    }
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete_outlined),
                                    onPressed: () async {
                                      http.Response res;
                                      res = await deleteTask(snapshot.data![index].id!);

                                      if(res.statusCode == 200) {
                                        print('Successfully sent a DELETE request to /todos with id ${snapshot.data![index].id!}');
                                      }
                                    }
                                  )
                                ]
                              )
                          );
                        }
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }
            )
        )
    );
  }
}