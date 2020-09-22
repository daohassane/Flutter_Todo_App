import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/faillures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/todo.dart';
import '../../domain/repositories/todo_repository.dart';
import '../datasources/todo_local_data.source.dart';
import '../datasources/todo_remote_data_source.dart';

class TodoRepositoryImpl implements TodoAppRepository {
  final TodoRemoteDataSource remoteDataSource;
  final TodoLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  TodoRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Faillure, List<Todo>>> getTodoList() {
    networkInfo.isConnected;
    return null;
  }

  @override
  Future<Either<Faillure, Todo>> getTodo(int id) async {
    if (!await networkInfo.isConnected) {
      try {
        final localTodo = await localDataSource.getLastTodo();
        return Right(localTodo);
      } on CacheException {
        return Left(CacheFaillure());
      }
    }

    try {
      final remoteTodo = await remoteDataSource.getTodo(id);
      localDataSource.cacheTodo(remoteTodo);
      return Right(remoteTodo);
    } on ServerException {
      return Left(ServerFaillure());
    }
  }

  @override
  Future<Either<Faillure, Todo>> createTodo() {
    return null;
  }

  @override
  Future<Either<Faillure, Todo>> updateTodo(int id) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Faillure, bool>> deleteTodo(int id) {
    throw UnimplementedError();
  }
}
