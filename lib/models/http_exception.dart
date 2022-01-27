//comment  1 : use Exception to return error message as string
class HttpException implements Exception {
  final String massage;
  HttpException(this.massage);
  @override
  String toString() {
    return massage;
  }
}
