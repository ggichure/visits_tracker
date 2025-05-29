import 'package:dio/dio.dart';
import 'package:visits_tracker/src/core/env/env.dart';

class AuthInterceptor extends Interceptor {
  @override
  Future<dynamic> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers['apikey'] = Env.apiKey;

    return super.onRequest(options, handler);
  }
}
