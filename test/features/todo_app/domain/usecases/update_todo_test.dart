import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_app/core/usecases/usecase.dart';
import 'package:todo_app/features/todo_app/domain/entities/todo.dart';
import 'package:todo_app/features/todo_app/domain/repositories/todo_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/features/todo_app/domain/usecases/update_todo.dart';

class MockTodoAppRepository extends Mock implements TodoAppRepository {}

void main() {
  UpdateTodo usecase;
  MockTodoAppRepository mockTodoAppRepository;

  setUp(() {
    mockTodoAppRepository = MockTodoAppRepository();
    usecase = UpdateTodo(mockTodoAppRepository);
  });

  final tId = 1;
  final tTodo = Todo(
    id: 1,
    userId: 1,
    title: 'new task',
    completed: false,
  );

  test('should update todo from the repository', () async {
    // arrange
    when(mockTodoAppRepository.updateTodo(any))
        .thenAnswer((_) async => Right(tTodo));
    // act
    final result = await usecase(Params(id: tId));
    // assert
    expect(result, Right(tTodo));
    verify(mockTodoAppRepository.updateTodo(tId));
    verifyNoMoreInteractions(mockTodoAppRepository);
  });
}
