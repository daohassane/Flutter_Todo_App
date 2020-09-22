import 'package:dartz/dartz.dart';

import '../../../../core/error/faillures.dart';
import '../entities/todo.dart';

abstract class TodoAppRepository {
  Future<Either<Faillure, List<Todo>>> getTodoList();
  //Future<Either<Faillure, List<Todo>>> getCompleteTodoList(bool complete);
  //Future<Either<Faillure, List<Todo>>> getIncompleteTodoList(bool complete);
  // CRUD
  Future<Either<Faillure, Todo>> createTodo();
  Future<Either<Faillure, Todo>> getTodo(int id);
  Future<Either<Faillure, Todo>> updateTodo(int id);
  Future<Either<Faillure, bool>> deleteTodo(int id);
}
