import 'package:dartz/dartz.dart';

import '../../../../core/error/faillures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/todo.dart';
import '../repositories/todo_repository.dart';

class GetTodoList implements UseCase<List<Todo>, NoParams> {
  final TodoAppRepository repository;

  GetTodoList(this.repository);

  @override
  Future<Either<Faillure, List<Todo>>> call(NoParams params) async {
    return await repository.getTodoList();
  }
}
