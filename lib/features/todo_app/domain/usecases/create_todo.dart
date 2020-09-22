import 'package:dartz/dartz.dart';

import '../../../../core/error/faillures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/todo.dart';
import '../repositories/todo_repository.dart';

class CreateTodo implements UseCase<Todo, NoParams> {
  final TodoAppRepository repository;

  CreateTodo(this.repository);

  @override
  Future<Either<Faillure, Todo>> call(NoParams params) async {
    return await repository.createTodo();
  }
}
