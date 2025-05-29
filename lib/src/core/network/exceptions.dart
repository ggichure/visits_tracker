import 'package:dio/dio.dart';

class ServerException implements Exception {
  ServerException(this.message, this.statusCode);
  final String message;
  final int? statusCode;

  @override
  // ignore: hash_and_equals, avoid_equals_and_hash_code_on_mutable_classes
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    if (other is ServerException) {
      return other.message == message && other.statusCode == statusCode;
    }

    return false;
  }
}

class ForbiddenException extends DioException {
  ForbiddenException(
    RequestOptions r,
  ) : super(
          requestOptions: r,
        );

  @override
  String toString() {
    return 'Unauthorized';
  }
}
