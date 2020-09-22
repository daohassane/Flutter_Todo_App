import 'package:equatable/equatable.dart';

abstract class Faillure extends Equatable {
  Faillure([List properties = const <dynamic>[]]) : super(properties);
}

// General faillure

class ServerFaillure extends Faillure {}

class CacheFaillure extends Faillure {}
