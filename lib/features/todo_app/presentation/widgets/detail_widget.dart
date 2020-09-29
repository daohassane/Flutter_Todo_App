import 'package:flutter/material.dart';
import 'package:todo_app/features/todo_app/data/models/todo_model.dart';

class DetailView extends StatelessWidget {
  final TodoModel todo;

  DetailView({Key key, @required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(todo.title.toString()),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              todo.title.toString(),
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Completed',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              '${todo.completed}',
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Created by',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              '${todo.userId}',
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 16,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                    onPressed: () {},
                    child: Text(
                      'Modifier',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.lightGreen,
                  ),
                  RaisedButton(
                    onPressed: () {},
                    child: Text(
                      'Supprimer',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.red,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
