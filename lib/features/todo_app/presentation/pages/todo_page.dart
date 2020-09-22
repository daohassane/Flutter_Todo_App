import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/todo_app/presentation/widgets/detail_widget.dart';
import 'package:todo_app/features/todo_app/presentation/widgets/empty_widget.dart';

import '../../../../injection_container.dart';
import '../bloc/todo_bloc.dart';
import '../widgets/loading_widget.dart';

class TodoPage extends StatefulWidget {
  TodoPage({Key key}) : super(key: key);

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  void dispatchList() {
    BlocProvider.of<TodoBloc>(context).dispatch(AllForTodo());
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TodoPageView();
  }
}

class TodoPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo App'),
      ),
      body: buildBlocProvider(),
    );
  }

  BlocProvider<TodoBloc> buildBlocProvider() {
    return BlocProvider(
      builder: (_) => sl<TodoBloc>(),
      child: Container(
        child: BlocBuilder<TodoBloc, TodoState>(
          builder: (context, state) {
            print(state);
            if (state is Empty) {
              return EmptyState();
            } else if (state is Loading) {
              return LoadingWidget();
            } else if (state is Loaded) {
              print(state.todo);
              return DetailView(
                todo: state.todo,
              );
            } else if (state is Error) {
              return Center(
                child: Container(
                  child: Text(state.message),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
