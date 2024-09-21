abstract class UseCases<T, NoParams> {
  Future<T> call();
}

abstract class NoParams {}