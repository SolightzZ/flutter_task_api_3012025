import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'prefix_url.dart';
import 'task.dart';
import 'package:http/http.dart';

class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  late Future<List<Task>> task;
  final TaskListKey = GlobalKey<_TaskListState>();

  @override
  void initState() {
    super.initState();
    task = getTaskList();
  }

  Future<List<Task>> getTaskList() async {
    var url = Uri.parse(
        "https://hosting.udru.ac.th/its66040233122/PHP-30-1-2025/all_task.php");
    final response = await http.get(url);
    final items = json.decode(response.body).cast<Map<String, dynamic>>();
    List<Task> tasks = items.map<Task>((json) {
      return Task.fromJson(json);
    }).toList();
    return tasks;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Management'),
      ),
      body: Center(
        child: FutureBuilder(
            future: task,
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) return CircularProgressIndicator();
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    var data = snapshot.data[index];
                    return Card(
                      child: ListTile(
                        leading: Icon(Icons.task),
                        trailing: Icon(Icons.view_list),
                        title: Text(
                          data.title,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    );
                  });
            }),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: null,
      ),
    );
  }
}
