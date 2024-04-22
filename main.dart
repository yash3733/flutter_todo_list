import 'package:flutter/material.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List',
      home: TodoList(),
    );
  }
}

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<String> _tasks = [];

  TextEditingController _taskController = TextEditingController();
  TextEditingController _editTaskController = TextEditingController();

  void _addTask() {
    setState(() {
      String newTask = _taskController.text;
      if (newTask.isNotEmpty) {
        _tasks.add(newTask);
        _taskController.clear();
      }
    });
  }

  void _updateTask(int index, String updatedTask) {
    setState(() {
      _tasks[index] = updatedTask;
    });
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    decoration: InputDecoration(
                      labelText: 'Add Task',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _addTask,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(_tasks[index]),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          _editTaskModalBottomSheet(context, index);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _deleteTask(index);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _editTaskModalBottomSheet(BuildContext context, int index) {
    String updatedTask = _tasks[index];
    _editTaskController.text = updatedTask;

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: _editTaskController,
                decoration: InputDecoration(
                  labelText: 'Update Task',
                ),
              ),
              SizedBox(height: 10.0),
              ElevatedButton(
                child: Text('Update'),
                onPressed: () {
                  updatedTask = _editTaskController.text;
                  _updateTask(index, updatedTask);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
