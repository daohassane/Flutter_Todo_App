import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_app/core/error/exceptions.dart';
import 'package:todo_app/core/error/faillures.dart';
import 'package:todo_app/core/network/network_info.dart';
import 'package:todo_app/features/todo_app/data/datasources/todo_local_data.source.dart';
import 'package:todo_app/features/todo_app/data/datasources/todo_remote_data_source.dart';
import 'package:todo_app/features/todo_app/data/models/todo_model.dart';
import 'package:todo_app/features/todo_app/data/repositories/todo_repository_impl.dart';
import 'package:todo_app/features/todo_app/domain/entities/todo.dart';

class MockRemoteDataSource extends Mock implements TodoRemoteDataSource {}

class MockLocalDataSource extends Mock implements TodoLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  TodoRepositoryImpl repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = TodoRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('getTodo', () {
    final tId = 1;
    final tTodoModel = TodoModel(
      id: 1,
      userId: 1,
      title: 'lorem ipsum',
      completed: false,
    );
    final Todo tTodo = tTodoModel;

    test('Should check if the device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // act
      repository.getTodo(tId);
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    void runTestsOnline(Function body) {
      group('device is online', () {
        setUp(() {
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        });
        body();
      });
    }

    void runTestsOffline(Function body) {
      group('device is offline', () {
        setUp(() {
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
        });
        body();
      });
    }

    runTestsOnline(() {
      test(
          'should remote data when the call to remote data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.getTodo(any)).thenAnswer((_) async => tTodo);
        // act
        final result = await repository.getTodo(tId);
        // assert
        verify(mockRemoteDataSource.getTodo(tId));
        expect(result, equals(Right(tTodo)));
      });

      test(
          'should cache data locally when the call to remote data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.getTodo(any))
            .thenAnswer((_) async => tTodoModel);
        // act
        await repository.getTodo(tId);
        // assert
        verify(mockRemoteDataSource.getTodo(tId));
        verify(mockLocalDataSource.cacheTodo(tTodoModel));
      });

      test(
          'should return server faillure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getTodo(any)).thenThrow(ServerException());
        // act
        final result = await repository.getTodo(tId);
        // assert
        verify(mockRemoteDataSource.getTodo(tId));
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, equals(Left(ServerFaillure())));
      });
    });

    runTestsOffline(() {
      test(
          'should return last locally cached data when the cached data is present',
          () async {
        // arrange
        when(mockLocalDataSource.getLastTodo())
            .thenAnswer((_) async => tTodoModel);
        //act
        final result = await repository.getTodo(tId);
        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastTodo());
        expect(result, equals(Right(tTodo)));
      });

      test('should return CacheFaillure when there is no cached data present',
          () async {
        // arrange
        when(mockLocalDataSource.getLastTodo()).thenThrow(CacheException());
        //act
        final result = await repository.getTodo(tId);
        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastTodo());
        expect(result, equals(Left(CacheFaillure())));
      });
    });
  });
}
