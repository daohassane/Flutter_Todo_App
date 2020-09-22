import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/features/todo_app/data/models/todo_model.dart';
import 'package:todo_app/features/todo_app/domain/entities/todo.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final todoModel = TodoModel(
    id: 1,
    userId: 1,
    title: 'delectus aut autem',
    completed: false,
  );

  test('Shoulb be a subclass of Todo entity', () async {
    // assert
    expect(todoModel, isA<Todo>());
  });

  group('fromJson', () {
    test('Should return a valide model when the JSON id is an integer',
        () async {
      // arrange
      final Map<String, dynamic> jsonMap = json.decode(fixture('todo.json'));
      // act
      final result = TodoModel.fromJson(jsonMap);
      // expert
      expect(result, todoModel);
    });
  });

  group('toJson', () {
    test('Should return a json map contain the proper data', () async {
      // act
      final result = todoModel.toJson();
      // expert
      final exceptedMap = {
        "id": 1,
        "userId": 1,
        "title": 'delectus aut autem',
        "completed": false,
      };
      expect(result, exceptedMap);
    });
  });
}
