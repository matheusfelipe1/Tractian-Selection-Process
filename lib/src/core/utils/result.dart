class Result<T, E> {

  final T? data;
  final E? error;

  Result({this.data, this.error});

  bool get isSuccess => data != null;

  factory Result.success(T data) => Result<T, E>(data: data);
  factory Result.failure(E error) => Result<T, E>(error: error);


  void proccessResult({
    required Function(T) onSuccess, 
    required Function(E) onFailure,
    }) {
    if (isSuccess) {
      onSuccess(data as T);
    } else {
      onFailure(error as E);
    }
  }
}