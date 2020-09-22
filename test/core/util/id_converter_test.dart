import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/util/id_converter.dart';

void main() {
  IdConverter idConverter;

  setUp(() {
    idConverter = IdConverter();
  });

  group('StringToUnsignedInt', () {
    test(
        'should return an integer when the string represents an unsigned integer',
        () async {
      // arrange
      final str = '123';
      // act
      final result = idConverter.stringToUnsignedInteger(str);
      // assert
      expect(result, Right(123));
    });

    test('should return a faillure when the string is not an integer',
        () async {
      // arrange
      final str = 'abc';
      // act
      final result = idConverter.stringToUnsignedInteger(str);
      // assert
      expect(result, Left(InvalidIdFailure()));
    });

    test('should return a faillure when the string is not an negative integer',
        () async {
      // arrange
      final str = '-123';
      // act
      final result = idConverter.stringToUnsignedInteger(str);
      // assert
      expect(result, Left(InvalidIdFailure()));
    });
  });
}
