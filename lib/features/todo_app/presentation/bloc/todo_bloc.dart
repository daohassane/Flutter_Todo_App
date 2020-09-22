import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/core/usecases/usecase.dart';

import '../../../../core/error/faillures.dart';
import '../../../../util/id_converter.dart';
import '../../domain/entities/todo.dart';
import '../../domain/usecases/create_todo.dart';
import '../../domain/usecases/delete_todo.dart';
import '../../domain/usecases/get_todo.dart';
import '../../domain/usecases/get_todo_list.dart';
import '../../domain/usecases/update_todo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

const String SERVER_FAILLURE_MESSAGE = 'Server Faillure';
const String CACHE_FAILLURE_MESSAGE = 'Cache Faillure';
const String INVALID_ID_FAILLURE_MESSAGE =
    'Invalid Id - The id must be a positive integer';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final GetTodoList getTodoList;
  final GetTodo getTodo;
  final CreateTodo createTodo;
  final UpdateTodo updateTodo;
  final DeleteTodo deleteTodo;
  final IdConverter idConverter;

  TodoBloc({
    @required GetTodoList all,
    @required GetTodo show,
    @required CreateTodo create,
    @required UpdateTodo update,
    @required DeleteTodo delete,
    this.idConverter,
  })  : assert(show != null),
        assert(create != null),
        assert(update != null),
        assert(delete != null),
        assert(idConverter != null),
        getTodoList = all,
        getTodo = show,
        createTodo = create,
        updateTodo = update,
        deleteTodo = delete;

  @override
  TodoState get initialState => Empty();

  @override
  Stream<TodoState> mapEventToState(
    TodoEvent event,
  ) async* {
    if (event is ShowForTodo) {
      final inputEither = idConverter.stringToUnsignedInteger(event.id);

      yield* inputEither.fold(
        (failure) async* {
          yield Error(message: INVALID_ID_FAILLURE_MESSAGE);
        },
        (integer) async* {
          yield Loading();
          final failureOrTodo = await getTodo(Params(id: integer));
          yield* _eitherLoadedOrErrorState(failureOrTodo);
        },
      );
    } else if (event is AllForTodo) {
      yield Loading();
      final failureOrTodo = await getTodoList(NoParams());
      yield* _eitherNoParamsLoadedOrErrorState(failureOrTodo);
    }
  }

  Stream<TodoState> _eitherLoadedOrErrorState(
      Either<Faillure, Todo> failureOrTodo) async* {
    yield failureOrTodo.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (todo) => Loaded(todo: todo),
    );
  }

  Stream<TodoState> _eitherNoParamsLoadedOrErrorState(
      Either<Faillure, List<Todo>> failureOrTodo) async* {
    yield failureOrTodo.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (todos) => TodosLoaded(todos),
    );
  }

  String _mapFailureToMessage(Faillure faillure) {
    switch (faillure.runtimeType) {
      case ServerFaillure:
        return SERVER_FAILLURE_MESSAGE;
        break;
      case CacheFaillure:
        return CACHE_FAILLURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
