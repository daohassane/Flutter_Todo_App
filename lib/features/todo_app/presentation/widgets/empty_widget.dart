import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/todo_app/presentation/bloc/todo_bloc.dart';

class EmptyState extends StatefulWidget {
  EmptyState({Key key}) : super(key: key);

  @override
  _EmptyStateState createState() => _EmptyStateState();
}

class _EmptyStateState extends State<EmptyState> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Task not found'),
          RaisedButton(
            onPressed: dispatchTasks,
            child: Text('Get tasks'),
          ),
        ],
      ),
    );
  }

  void dispatchTasks() {
    BlocProvider.of<TodoBloc>(context).dispatch(ShowForTodo('2'));
  }
}
