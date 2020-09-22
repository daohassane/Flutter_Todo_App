import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/core/error/exceptions.dart';
import 'package:todo_app/features/todo_app/data/datasources/todo_local_data.source.dart';
import 'package:todo_app/features/todo_app/data/models/todo_model.dart';
import 'package:matcher/matcher.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  TodoLocalDataSourceImpl localDataSource;
  MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    localDataSource =
        TodoLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  group('getLastestTodo', () {
    final tTodoModel = TodoModel.fromJson(json.decode(fixture('todo.json')));
    test(
        'should return todo from SharedPreferences when there is one in the cache',
        () async {
      // arrange
      when(mockSharedPreferences.getString(any))
          .thenReturn(fixture('todo.json'));
      // act
      final result = await localDataSource.getLastTodo();
      // assert
      verify(mockSharedPreferences.getString(CACHED_TODO));
      expect(result, equals(tTodoModel));
    });

    test('should throw a CacheException where there is not a cached value',
        () async {
      // arrange
      when(mockSharedPreferences.getString(any)).thenReturn(null);
      // act
      final call = localDataSource.getLastTodo;
      // assert
      expect(() => call(), throwsA(TypeMatcher<CacheException>()));
    });
  });

  group('cacheTodo', () {
    final tTodoModel = TodoModel(
      id: 1,
      userId: 1,
      title: 'New task',
      completed: false,
    );
    test('should call SharedPreferences to cache  the data', () async {
      // act
      localDataSource.cacheTodo(tTodoModel);
      // assert
      final exceptedJsonString = json.encode(tTodoModel);
      verify(mockSharedPreferences.setString(CACHED_TODO, exceptedJsonString));
    });
  });
}
