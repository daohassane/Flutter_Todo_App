import 'package:flutter/material.dart';

class AddTodoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Add todo'),
      ),
      body: Container(
          padding: EdgeInsets.all(20),
          child: Form(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Add task title', labelText: 'Title'),
                ),
                Container(
                  width: screenSize.width,
                  padding: EdgeInsets.only(top: 30),
                  child: RaisedButton(
                    child: Text('Save task'),
                    onPressed: () {},
                    color: Colors.amber,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
