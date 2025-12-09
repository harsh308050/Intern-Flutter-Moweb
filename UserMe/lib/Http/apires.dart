class ApiResult<T> {
  final T? data;
  final String? error;
  final bool isSuccess;

  ApiResult._({this.data, this.error, required this.isSuccess});

  factory ApiResult.success({required T data}) {
    return ApiResult._(data: data, error: null, isSuccess: true);
  }

  factory ApiResult.failure({required String error}) {
    return ApiResult._(data: null, error: error, isSuccess: false);
  }

  R when<R>({
    required R Function(T data) success,
    required R Function(String error) failure,
  }) {
    if (isSuccess) {
      return success(data as T);
    } else {
      return failure(error ?? "Unknown error");
    }
  }

  bool get isFailure => !isSuccess;

  @override
  String toString() =>
      "ApiResult(isSuccess: $isSuccess, data: $data, error: $error)";
}
