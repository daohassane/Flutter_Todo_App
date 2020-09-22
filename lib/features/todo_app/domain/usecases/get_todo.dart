import 'package:dartz/dartz.dart';
import 'package:todo_app/core/error/faillures.dart';
import 'package:todo_app/core/usecases/usecase.dart';
import 'package:todo_app/features/todo_app/domain/entities/todo.dart';

import '../repositories/todo_repository.dart';

class GetTodo implements UseCase<Todo, Params> {
  final TodoAppRepository repository;

  GetTodo(this.repository);

  @override
  Future<Either<Faillure, Todo>> call(Params params) async {
    return await repository.getTodo(params.id);
  }
}


