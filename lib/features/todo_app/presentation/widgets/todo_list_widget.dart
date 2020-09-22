import 'package:flutter/material.dart';
import 'package:todo_app/features/todo_app/domain/entities/todo.dart';

class TodoListWidget extends StatelessWidget {
  final List<Todo> todos;

  const TodoListWidget({Key key, @required this.todos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final item = todos[index];

        return ListTile(
          title: Text(item.title),
        );
      },
    );
  }
}
