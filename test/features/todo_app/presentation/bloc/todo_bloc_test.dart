import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_app/core/error/faillures.dart';
import 'package:todo_app/core/usecases/usecase.dart';
import 'package:todo_app/features/todo_app/domain/entities/todo.dart';
import 'package:todo_app/features/todo_app/domain/usecases/create_todo.dart';
import 'package:todo_app/features/todo_app/domain/usecases/delete_todo.dart';
import 'package:todo_app/features/todo_app/domain/usecases/get_todo.dart';
import 'package:todo_app/features/todo_app/domain/usecases/get_todo_list.dart';
import 'package:todo_app/features/todo_app/domain/usecases/update_todo.dart';
import 'package:todo_app/features/todo_app/presentation/bloc/todo_bloc.dart';
import 'package:todo_app/util/id_converter.dart';

class MockGetTodo extends Mock implements GetTodo {}

class MockGetTodoList extends Mock implements GetTodoList {}

class MockCreateTodo extends Mock implements CreateTodo {}

class MockDeleteTodo extends Mock implements DeleteTodo {}

class MockUpdateTodo extends Mock implements UpdateTodo {}

class MockIdConverter extends Mock implements IdConverter {}

void main() {
  TodoBloc bloc;
  MockGetTodo mockGetTodo;
  MockGetTodoList mockGetTodoList;
  MockCreateTodo mockCreateTodo;
  MockDeleteTodo mockDeleteTodo;
  MockUpdateTodo mockUpdateTodo;
  MockIdConverter mockIdConverter;

  setUp(() {
    mockGetTodoList = MockGetTodoList();
    mockGetTodo = MockGetTodo();
    mockCreateTodo = MockCreateTodo();
    mockUpdateTodo = MockUpdateTodo();
    mockDeleteTodo = MockDeleteTodo();
    mockIdConverter = MockIdConverter();

    bloc = TodoBloc(
      all: mockGetTodoList,
      show: mockGetTodo,
      create: mockCreateTodo,
      update: mockUpdateTodo,
      delete: mockDeleteTodo,
      idConverter: mockIdConverter,
    );
  });

  test('initialState should be empty', () async {
    // assert
    expect(bloc.initialState, equals(Empty()));
  });

  group('ShowForTodo', () {
    final tIdString = '1';
    final tIdParsed = 1;
    final tTodo = Todo(id: 1, userId: 1, title: 'New task', completed: false);

    void setMockIdConvertSuccess() =>
        when(mockIdConverter.stringToUnsignedInteger(any))
            .thenReturn(Right(tIdParsed));

    test(
        'should call the IdConverter to validate and converte the string to an unsigned integer',
        () async {
      // arrange
      setMockIdConvertSuccess();
      // act
      bloc.dispatch(ShowForTodo(tIdString));
      await untilCalled(mockIdConverter.stringToUnsignedInteger(any));
      // assert
      verify(mockIdConverter.stringToUnsignedInteger(tIdString));
    });

    test('should emit [error] then the id is invalid', () async {
      // arrange
      when(mockIdConverter.stringToUnsignedInteger(any))
          .thenReturn(Left(InvalidIdFailure()));
      // assert
      final expected = [
        Empty(),
        Error(message: INVALID_ID_FAILLURE_MESSAGE),
      ];
      expectLater(bloc.state, emitsInOrder(expected));
      // act
      bloc.dispatch(ShowForTodo(tIdString));
    });

    test('should get data from the all use case', () async {
      // arrange
      setMockIdConvertSuccess();
      when(mockGetTodo(any)).thenAnswer((_) async => Right(tTodo));
      // assert
      bloc.dispatch(ShowForTodo(tIdString));
      await untilCalled(mockGetTodo(any));
      // act
      verify(mockGetTodo(Params(id: tIdParsed)));
    });

    test('should emit [Loading, Loaded] when data is gotten successfully',
        () async {
      // arrange
      setMockIdConvertSuccess();
      when(mockGetTodo(any)).thenAnswer((_) async => Right(tTodo));
      // assert later
      final expected = [
        Empty(),
        Loading(),
        Loaded(todo: tTodo),
      ];
      expectLater(bloc.state, emitsInOrder(expected));
      // act
      bloc.dispatch(ShowForTodo(tIdString));
    });

    test('should emit [Loading, Error] when data fails', () async {
      // arrange
      setMockIdConvertSuccess();
      when(mockGetTodo(any)).thenAnswer((_) async => Left(ServerFaillure()));
      // assert later
      final expected = [
        Empty(),
        Loading(),
        Error(message: SERVER_FAILLURE_MESSAGE),
      ];
      expectLater(bloc.state, emitsInOrder(expected));
      // act
      bloc.dispatch(ShowForTodo(tIdString));
    });

    test(
        'should emit [Loading, Error] whith a proper message for the error when getting data fails',
        () async {
      // arrange
      setMockIdConvertSuccess();
      when(mockGetTodo(any)).thenAnswer((_) async => Left(CacheFaillure()));
      // assert later
      final expected = [
        Empty(),
        Loading(),
        Error(message: CACHE_FAILLURE_MESSAGE),
      ];
      expectLater(bloc.state, emitsInOrder(expected));
      // act
      bloc.dispatch(ShowForTodo(tIdString));
    });
  });
}
