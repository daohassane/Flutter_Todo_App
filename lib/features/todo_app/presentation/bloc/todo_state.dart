part of 'todo_bloc.dart';

@immutable
abstract class TodoState extends Equatable {
  TodoState([List props = const <dynamic>[]]) : super(props);
}

class Empty extends TodoState {}

class Loading extends TodoState {}

class Loaded extends TodoState {
  final Todo todo;

  Loaded({@required this.todo});

  @override
  List<Object> get props => [todo];
}

class TodosLoaded extends TodoState {
  final List<Todo> todos;

  TodosLoaded(this.todos) : super([todos]);

  @override
  List<Object> get props => [todos];
}

class Error extends TodoState {
  final String message;

  Error({@required this.message}) : super([message]);
}
