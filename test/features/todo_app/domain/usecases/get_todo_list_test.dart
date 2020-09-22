import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_app/core/usecases/usecase.dart';
import 'package:todo_app/features/todo_app/domain/entities/todo.dart';
import 'package:todo_app/features/todo_app/domain/repositories/todo_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/features/todo_app/domain/usecases/get_todo_list.dart';

class MockTodoAppRepository extends Mock implements TodoAppRepository {}

void main() {
  GetTodoList usecase;
  MockTodoAppRepository mockTodoAppRepository;

  setUp(() {
    mockTodoAppRepository = MockTodoAppRepository();
    usecase = GetTodoList(mockTodoAppRepository);
  });

  final todoList = List<Todo>.generate(
    5,
    (index) => Todo(
      id: index,
      userId: 1,
      title: 'task number $index',
      completed: false,
    ),
  );

  test('should get todo list from the repository', () async {
    // arrange
    when(mockTodoAppRepository.getTodoList())
        .thenAnswer((_) async => Right(todoList));
    // act
    final result = await usecase(NoParams());
    // assert
    expect(result, Right(todoList));
    verify(mockTodoAppRepository.getTodoList());
    verifyNoMoreInteractions(mockTodoAppRepository);
  });
}
