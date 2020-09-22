import 'package:dartz/dartz.dart';
import 'package:todo_app/core/error/faillures.dart';

class IdConverter {
  Either<Faillure, int> stringToUnsignedInteger(String str) {
    try {
      final integer = int.parse(str);
      if (integer < 0) throw FormatException();
      return Right(integer);
    } on FormatException {
      return Left(InvalidIdFailure());
    }
  }
}

class InvalidIdFailure extends Faillure {}
