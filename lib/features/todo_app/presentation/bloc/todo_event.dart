part of 'todo_bloc.dart';

@immutable
abstract class TodoEvent extends Equatable {
  TodoEvent([List props = const <dynamic>[]]) : super(props);
}

class AllForTodo extends TodoEvent {}

class ShowForTodo extends TodoEvent {
  final String id;

  ShowForTodo(this.id);
}

class CreateForTodo extends TodoEvent {}

class UpdateForTodo extends TodoEvent {
  final String id;

  UpdateForTodo(this.id);
}

class DeleteForTodo extends TodoEvent {
  final String id;

  DeleteForTodo(this.id);
}
