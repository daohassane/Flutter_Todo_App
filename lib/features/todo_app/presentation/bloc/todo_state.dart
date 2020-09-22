part of 'todo_bloc.dart';

@immutable
abstract class TodoState extends Equatable {
  TodoState([List props = const <dynamic>[]]) : super(props);
}

class Empty extends TodoState {}

class Loading extends TodoState {}

class Loaded extends TodoState {
  final Todo todo;

  Loaded({@required this.todo}) : super([todo]);
}

class TodosLoaded extends TodoState {
  final List<Todo> todos;

  TodosLoaded([this.todos = const []]) : super([todos]);
}

class Error extends TodoState {
  final String message;

  Error({@required this.message}) : super([message]);
}
