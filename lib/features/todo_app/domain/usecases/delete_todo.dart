import 'package:dartz/dartz.dart';

import '../../../../core/error/faillures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/todo_repository.dart';

class DeleteTodo implements UseCase<bool, Params> {
  final TodoAppRepository repository;

  DeleteTodo(this.repository);

  @override
  Future<Either<Faillure, bool>> call(Params params) async {
    return await repository.deleteTodo(params.id);
  }
}
