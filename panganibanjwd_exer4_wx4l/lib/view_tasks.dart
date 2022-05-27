import 'package:flutter/material.dart';
import 'dbhandler.dart';
import 'TaskModel.dart';

class TaskList extends StatefulWidget {
  final DatabaseHandler dbHandler;

  const TaskList({Key? key, required this.dbHandler }) : super(key: key);

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
            body: FutureBuilder(
                future: widget.dbHandler.retrieveTasks(),
                builder: (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                              key: ValueKey<int>(snapshot.data![index].id!),
                              title: Text(snapshot.data![index].title.toString()),
                              subtitle: Text(snapshot.data![index].details.toString()),
                              trailing: IconButton(
                                  icon: Icon(Icons.delete_outline),
                                  onPressed: () async {
                                    await widget.dbHandler.deleteTask(snapshot.data![index].id!);
                                    setState(() {});
                                  }
                              )
                          );
                        }
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }
            )
        )
    );
  }
}