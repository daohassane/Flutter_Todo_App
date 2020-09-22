import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app/core/error/exceptions.dart';
import 'package:todo_app/features/todo_app/data/datasources/todo_remote_data_source.dart';
import 'package:todo_app/features/todo_app/data/models/todo_model.dart';
import 'package:matcher/matcher.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  TodoRemoteDataSourceImpl remoteDataSource;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    remoteDataSource = TodoRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpClientSucess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('todo.json'), 200));
  }

  void setUpMockHttpClientFaillure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('something went wrong', 404));
  }

  group('getTodo', () {
    final tId = 1;
    final tTodoModel = TodoModel.fromJson(json.decode(fixture('todo.json')));
    test('should perfom a GET request on a URL with id being the endpoint',
        () async {
      // arrange
      setUpMockHttpClientSucess200();
      // act
      remoteDataSource.getTodo(tId);
      // assert
      verify(
        mockHttpClient.get(
          'https://jsonplaceholder.typicode.com/todos/$tId',
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
      );
    });

    test('should return Todo when the response code is 200 (success)',
        () async {
      // arrange
      setUpMockHttpClientSucess200();
      // act
      final result = await remoteDataSource.getTodo(tId);
      // assert
      expect(result, equals(tTodoModel));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      setUpMockHttpClientFaillure404();
      // act
      final call = remoteDataSource.getTodo;
      // assert
      expect(() => call(tId), throwsA(TypeMatcher<ServerException>()));
    });
  });

  group('getAllTodo', () {
    //final tId = 1;
    //final tTodoModel = TodoModel.fromJson(json.decode(fixture('todo.json')));
    test('should perfom a GET request on a URL being the endpoint', () async {
      // arrange
      setUpMockHttpClientSucess200();
      // act
      remoteDataSource.getTodoList();
      // assert
      verify(
        mockHttpClient.get(
          'https://jsonplaceholder.typicode.com/todos',
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
      );
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      setUpMockHttpClientFaillure404();
      // act
      final call = remoteDataSource.getTodoList;
      // assert
      expect(() => call(), throwsA(TypeMatcher<ServerException>()));
    });
  });
}
