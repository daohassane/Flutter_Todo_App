import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Todo extends Equatable {
  final int id;
  final int userId;
  final String title;
  final bool completed;

  Todo({
    @required this.id,
    this.userId,
    @required this.title,
    @required this.completed,
  }) : super([id, userId, title, completed]);
}
