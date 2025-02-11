import 'api_result.dart';

Future<ApiResult<T>> executeApi<T>(
    {required Future<T> Function() apiCall}) async {
  try {
    final result = await apiCall();
    return Success(data: result);
  } catch (e) {
    print('API call failed: $e'); // Log the error for debugging

    return Failures(
      exception: e is Exception ? e : Exception("Unknown error occurred: $e"),
    );
  }
}
