abstract class UseCases<Type, Params> {
  Future<Type> call(Params params);
}

class NoParams extends Params {}

abstract class Params {}