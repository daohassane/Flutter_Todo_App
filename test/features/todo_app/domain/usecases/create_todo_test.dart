import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_app/core/usecases/usecase.dart';
import 'package:todo_app/features/todo_app/domain/entities/todo.dart';
import 'package:todo_app/features/todo_app/domain/repositories/todo_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/features/todo_app/domain/usecases/create_todo.dart';

class MockTodoAppRepository extends Mock implements TodoAppRepository {}

void main() {
  CreateTodo usecase;
  MockTodoAppRepository mockTodoAppRepository;

  setUp(() {
    mockTodoAppRepository = MockTodoAppRepository();
    usecase = CreateTodo(mockTodoAppRepository);
  });

  final tTodo = Todo(
    id: 1,
    userId: 1,
    title: 'new task',
    completed: false,
  );

  test('should create todo from the repository', () async {
    // arrange
    when(mockTodoAppRepository.createTodo())
        .thenAnswer((_) async => Right(tTodo));
    // act
    final result = await usecase(NoParams());
    // assert
    expect(result, Right(tTodo));
    verify(mockTodoAppRepository.createTodo());
    verifyNoMoreInteractions(mockTodoAppRepository);
  });
}
