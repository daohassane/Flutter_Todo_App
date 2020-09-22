import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_app/core/usecases/usecase.dart';
import 'package:todo_app/features/todo_app/domain/repositories/todo_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/features/todo_app/domain/usecases/delete_todo.dart';

class MockTodoAppRepository extends Mock implements TodoAppRepository {}

void main() {
  DeleteTodo usecase;
  MockTodoAppRepository mockTodoAppRepository;

  setUp(() {
    mockTodoAppRepository = MockTodoAppRepository();
    usecase = DeleteTodo(mockTodoAppRepository);
  });

  final tId = 1;
  final deleted = true;

  test('should delete todo from the repository', () async {
    // arrange
    when(mockTodoAppRepository.deleteTodo(any))
        .thenAnswer((_) async => Right(deleted));
    // act
    final result = await usecase(Params(id: tId));
    // assert
    expect(result, Right(deleted));
    verify(mockTodoAppRepository.deleteTodo(tId));
    verifyNoMoreInteractions(mockTodoAppRepository);
  });
}
