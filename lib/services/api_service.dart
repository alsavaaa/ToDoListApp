// services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String apiUrl = 'http://192.168.21.209:3000/todos';

  // Fetch tasks from the server
  static Future<List<Map<String, dynamic>>> fetchToDoList() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return List<Map<String, dynamic>>.from(jsonData);
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  // Add a new task to the server
  static Future<void> addToDo(Map<String, dynamic> newTask) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(newTask),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add task');
    }
  }

  // Delete a task from the server
  static Future<void> deleteToDo(String id) async {
    final response = await http.delete(Uri.parse('$apiUrl/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete task');
    }
  }

  // Update task status (mark as done or undone)
  static Future<void> updateToDo(Map<String, dynamic> task) async {
    final response = await http.put(
      Uri.parse('$apiUrl/${task['id']}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(task),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update task');
    }
  }
}
