import 'package:traction_selection_proccess/src/core/utils/result.dart';

abstract class BaseRepository {

  Result<T, E> handleSuccess<T, E>(dynamic data) => Result.success(data);
  Result<T, E> handleFailure<T, E>(dynamic error) => Result.failure(error);
}