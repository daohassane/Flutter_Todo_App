import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/core/error/exceptions.dart';
import 'package:todo_app/features/todo_app/data/models/todo_model.dart';
import 'package:meta/meta.dart';

abstract class TodoLocalDataSource {
  /// Gets the cached [TodoModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<TodoModel> getLastTodo();
  Future<List<TodoModel>> getLastTodoList();

  Future<void> cacheTodo(TodoModel todoCache);

  Future<void> cacheTodoList(List<TodoModel> remoteTodoList);
}

const CACHED_TODO = 'CACHED_TODO';
const CACHED_TODO_LIST = 'CACHED_TODO_LIST';

class TodoLocalDataSourceImpl implements TodoLocalDataSource {
  final SharedPreferences sharedPreferences;

  TodoLocalDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<TodoModel> getLastTodo() {
    final jsonString = sharedPreferences.getString(CACHED_TODO);
    if (jsonString == null) {
      throw CacheException();
    }

    return Future.value(TodoModel.fromJson(json.decode(jsonString)));
  }

  @override
  Future<void> cacheTodo(TodoModel todoCache) {
    return sharedPreferences.setString(
      CACHED_TODO,
      json.encode(todoCache.toJson()),
    );
  }

  @override
  Future<List<TodoModel>> getLastTodoList() {
    final jsonString = sharedPreferences.getString(CACHED_TODO_LIST);
    if (jsonString == null) {
      throw CacheException();
    }

    return Future.value(json.decode(jsonString));
  }

  @override
  Future<void> cacheTodoList(List<TodoModel> todoCacheList) {
    return sharedPreferences.setString(
      CACHED_TODO_LIST,
      json.encode(todoCacheList.toString()),
    );
  }
}
