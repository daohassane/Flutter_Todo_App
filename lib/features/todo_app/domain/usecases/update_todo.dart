import 'package:dartz/dartz.dart';
import 'package:todo_app/features/todo_app/domain/entities/todo.dart';

import '../../../../core/error/faillures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/todo_repository.dart';

class UpdateTodo implements UseCase<Todo, Params> {
  final TodoAppRepository repository;

  UpdateTodo(this.repository);

  @override
  Future<Either<Faillure, Todo>> call(Params params) async {
    return await repository.updateTodo(params.id);
  }
}
