import 'package:flutter/material.dart';

class ToDoItem extends StatelessWidget {
  final Map<String, dynamic> todo;
  final Function(int) onDeleteItem;

  ToDoItem({
    required this.todo,
    required this.onDeleteItem,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        todo['todoText'],
        style: TextStyle(
          fontSize: 18,
          decoration: todo['isCompleted'] ? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete, color: Colors.red),
        onPressed: () {
          onDeleteItem(todo['id']);
        },
      ),
    );
  }
}
