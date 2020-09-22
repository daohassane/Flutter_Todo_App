import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/core/network/network_info.dart';
import 'package:todo_app/features/todo_app/data/datasources/todo_remote_data_source.dart';
import 'package:todo_app/features/todo_app/data/repositories/todo_repository_impl.dart';
import 'package:todo_app/features/todo_app/domain/repositories/todo_repository.dart';
import 'package:http/http.dart' as http;

import 'features/todo_app/data/datasources/todo_local_data.source.dart';
import 'features/todo_app/domain/usecases/create_todo.dart';
import 'features/todo_app/domain/usecases/delete_todo.dart';
import 'features/todo_app/domain/usecases/get_todo.dart';
import 'features/todo_app/domain/usecases/get_todo_list.dart';
import 'features/todo_app/domain/usecases/update_todo.dart';
import 'features/todo_app/presentation/bloc/todo_bloc.dart';
import 'util/id_converter.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Todo
  // Bloc
  sl.registerFactory(
    () => TodoBloc(
      all: sl(),
      show: sl(),
      create: sl(),
      update: sl(),
      delete: sl(),
      idConverter: sl(),
    ),
  );
  // Use cases
  sl.registerLazySingleton(() => GetTodoList(sl()));
  sl.registerLazySingleton(() => GetTodo(sl()));
  sl.registerLazySingleton(() => CreateTodo(sl()));
  sl.registerLazySingleton(() => UpdateTodo(sl()));
  sl.registerLazySingleton(() => DeleteTodo(sl()));

  // Repository
  sl.registerLazySingleton<TodoAppRepository>(
    () => TodoRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<TodoRemoteDataSource>(
    () => TodoRemoteDataSourceImpl(
      client: sl(),
    ),
  );

  sl.registerLazySingleton<TodoLocalDataSource>(
    () => TodoLocalDataSourceImpl(
      sharedPreferences: sl(),
    ),
  );

  //! Core
  sl.registerLazySingleton(() => IdConverter());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
