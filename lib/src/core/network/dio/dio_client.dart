import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:visits_tracker/src/core/network/dio/auth_interceptor.dart';

Dio buildDioClient(String base) {
  final dio = Dio()..options = BaseOptions(baseUrl: base);

  dio.interceptors.addAll([
    AuthInterceptor(),
    if (kDebugMode) PrettyDioLogger(requestBody: true),
  ]);
  return dio;
}
