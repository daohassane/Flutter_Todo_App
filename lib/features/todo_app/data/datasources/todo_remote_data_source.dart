import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:todo_app/core/error/exceptions.dart';

import '../models/todo_model.dart';

abstract class TodoRemoteDataSource {
  /// Calls the https://jsonplaceholder.typicode.com/todos endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<Map> getTodoList();

  /// Calls the https://jsonplaceholder.typicode.com/todos endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<TodoModel> createTodo(TodoModel todo);

  /// Calls the https://jsonplaceholder.typicode.com/todos/{id} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<TodoModel> getTodo(int id);

  /// Calls the https://jsonplaceholder.typicode.com/todos/{id} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<TodoModel> updateTodo(int id);
  //Future<Either<Faillure, bool>> deleteTodo(int id);

  /// Calls the https://jsonplaceholder.typicode.com/todos/{id} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<TodoModel> deleteTodo(int id);
  //Future<Either<Faillure, bool>> deleteTodo(int id);
}

class TodoRemoteDataSourceImpl implements TodoRemoteDataSource {
  final http.Client client;

  TodoRemoteDataSourceImpl({@required this.client});

  @override
  Future<Map<String, dynamic>> getTodoList() async {
    final response = await client.get(
      'https://jsonplaceholder.typicode.com/todos',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw ServerException();
    }

    return json.decode(response.body);
  }

  @override
  Future<TodoModel> getTodo(int id) async {
    final response = await client.get(
      'https://jsonplaceholder.typicode.com/todos/$id',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw ServerException();
    }

    return TodoModel.fromJson(json.decode(response.body));
  }

  @override
  Future<TodoModel> createTodo(TodoModel todo) async {
    final response = await client.post(
      'https://jsonplaceholder.typicode.com/todos',
      body: todo.toJson(),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );

    print(todo);

    if (response.statusCode != 201) {
      throw ServerException();
    }

    return TodoModel.fromJson(json.decode(response.body));
  }

  @override
  Future<TodoModel> updateTodo(int id) {
    return null;
  }

  @override
  Future<TodoModel> deleteTodo(int id) {
    return null;
  }
}
