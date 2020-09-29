import 'package:todo_app/features/todo_app/domain/entities/todo.dart';
import 'package:meta/meta.dart';

class TodoModel extends Todo {
  TodoModel({
    @required int id,
    @required int userId,
    @required String title,
    @required bool completed,
  }) : super(id: id, userId: userId, title: title, completed: completed);

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      completed: json['completed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'completed': completed,
    };
  }
}
