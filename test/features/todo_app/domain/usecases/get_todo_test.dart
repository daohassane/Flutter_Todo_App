import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_app/core/usecases/usecase.dart';
import 'package:todo_app/features/todo_app/domain/entities/todo.dart';
import 'package:todo_app/features/todo_app/domain/repositories/todo_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/features/todo_app/domain/usecases/get_todo.dart';

class MockTodoAppRepository extends Mock implements TodoAppRepository {}

void main() {
  GetTodo usecase;
  MockTodoAppRepository mockTodoAppRepository;

  setUp(() {
    mockTodoAppRepository = MockTodoAppRepository();
    usecase = GetTodo(mockTodoAppRepository);
  });

  final tId = 1;
  final tTodo = Todo(
    id: 1,
    userId: 1,
    title: 'new task',
    completed: false,
  );

  test('should get todo from the repository', () async {
    // arrange
    when(mockTodoAppRepository.getTodo(any))
        .thenAnswer((_) async => Right(tTodo));
    // act
    final result = await usecase(Params(id: tId));
    // assert
    expect(result, Right(tTodo));
    verify(mockTodoAppRepository.getTodo(tId));
    verifyNoMoreInteractions(mockTodoAppRepository);
  });
}
