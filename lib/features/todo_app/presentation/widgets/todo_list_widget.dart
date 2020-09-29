import 'package:flutter/material.dart';
import 'package:todo_app/features/todo_app/data/models/todo_model.dart';
import 'package:todo_app/features/todo_app/presentation/widgets/detail_widget.dart';

class TodoListWidget extends StatelessWidget {
  final List<TodoModel> todos;

  const TodoListWidget({Key key, @required this.todos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: Container(
            padding: EdgeInsets.all(20),
            child: ListTile(
              title: Text(
                '${todos[index].title}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Text('completed : ${todos[index].completed}'),
              dense: true,
              trailing: Icon(Icons.arrow_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailView(
                      todo: todos[index],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
