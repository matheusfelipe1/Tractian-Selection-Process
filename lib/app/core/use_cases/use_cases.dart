import 'dart:async';

abstract class UseCases<Type, Params> {
  FutureOr<Type> call(Params params);
}

class NoParams extends Params {}

abstract class Params {}