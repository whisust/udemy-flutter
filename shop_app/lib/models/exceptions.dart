class HttpException implements Exception {
  late String _message;

  HttpException({required String message}){
    _message = message;
  }

  @override
  String toString() {
    return _message;
  }
}