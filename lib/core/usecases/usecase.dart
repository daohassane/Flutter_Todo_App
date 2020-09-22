import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../error/faillures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Faillure, Type>> call(Params params);
}

class NoParams extends Equatable {}

class Params extends Equatable {
  final int id;

  Params({@required this.id});

  @override
  List<Object> get props => [id];
}
