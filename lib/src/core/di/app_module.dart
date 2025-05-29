import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:visits_tracker/src/core/env/env.dart';
import 'package:visits_tracker/src/core/network/dio/dio_client.dart';
import 'package:visits_tracker/src/core/router/app_router.dart';
import 'package:visits_tracker/src/features/customers/customers.dart';

@module
abstract class AppModule {
  @injectable
  AppRouter get appRouter => AppRouter();

  @lazySingleton
  Dio dio(@Named('BaseUrl') String baseUrl) => buildDioClient(baseUrl);

  @Named('BaseUrl')
  String get baseUrl => Env.baseUrl;

  @lazySingleton
  CustomersApiService provideApiClient(Dio dio) => CustomersApiService(dio);
}
