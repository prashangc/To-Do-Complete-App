class APIResponse<T> {
  final data;
  bool error;
  final errorMessage;

  APIResponse({this.data, this.errorMessage, this.error = false});
}
