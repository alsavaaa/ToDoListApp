import 'package:flutter/material.dart';
import '../services/api_service.dart';

class HomeScreen extends StatefulWidget {
  final String username;

  const HomeScreen({Key? key, required this.username}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> tasks = [];
  final _todoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  _loadTasks() async {
    try {
      List<Map<String, dynamic>> fetchedTasks = await ApiService.fetchToDoList();
      setState(() {
        tasks = fetchedTasks;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  _addTask() async {
    String taskText = _todoController.text;
    if (taskText.isNotEmpty) {
      Map<String, dynamic> newTask = {
        'todoText': taskText,
        'isCompleted': false,
      };
      await ApiService.addToDo(newTask);
      _todoController.clear();
      _loadTasks();
    }
  }

  _deleteTask(String id) async {
    try {
      await ApiService.deleteToDo(id);
      _loadTasks();
    } catch (e) {
      print('Error while deleting task: $e');
    }
  }

  _updateTaskStatus(Map<String, dynamic> task) async {
    task['isCompleted'] = !(task['isCompleted'] ?? false);
    await ApiService.updateToDo(task);
    _loadTasks();
  }

  _logout() {
    // Navigate to the login screen
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 225, 182, 193),  // Pink color for AppBar
        actions: [
          // Logout IconButton
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: Container(
        // Gradient background for the HomeScreen
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 146, 168, 211), Color.fromARGB(255, 225, 182, 193)],  // Blue to Pink gradient
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            // Header Section with pink-blue theme
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 225, 182, 193),  // Pink header background
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hai, ${widget.username}!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Apa yang ingin kamu selesaikan hari ini?',
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                ],
              ),
            ),
            // Task List Section
            Expanded(
              child: tasks.isEmpty
                  ? Center(
                      child: Text(
                        'Belum ada tugas. Tambahkan tugas baru!',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ListTile(
                            leading: Checkbox(
                              value: tasks[index]['isCompleted'] ?? false,
                              onChanged: (bool? value) {
                                _updateTaskStatus(tasks[index]);
                              },
                            ),
                            title: Text(
                              tasks[index]['todoText'],
                              style: TextStyle(
                                fontSize: 16,
                                decoration: tasks[index]['isCompleted']
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                String taskId = tasks[index]['id'].toString();
                                _deleteTask(taskId);
                              },
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Profile Button
          FloatingActionButton(
            backgroundColor: Color.fromARGB(255, 225, 182, 193),
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/profile',
                arguments: {'username': widget.username},
              );
            },
            child: Icon(Icons.person),
          ),
          SizedBox(height: 10),
          // Add Task Button
          FloatingActionButton(
            backgroundColor: Colors.blue,  // Blue color for Add Task button
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Add New Task'),
                    content: TextField(
                      controller: _todoController,
                      decoration: InputDecoration(
                        hintText: 'Enter task here',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          _addTask();
                          Navigator.of(context).pop();
                        },
                        child: Text('Add'),
                      ),
                    ],
                  );
                },
              );
            },
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
