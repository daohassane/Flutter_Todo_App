import 'package:flutter/material.dart';
import 'package:todo_app/features/todo_app/domain/entities/todo.dart';

class DetailView extends StatelessWidget {
  final Todo todo;
  DetailView({Key key, this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(todo.title),
    );
  }
}
