import 'package:dio/dio.dart';

import 'package:retrofit/retrofit.dart';
import 'package:visits_tracker/src/features/customers/customers.dart'
    show Activity, Customer, Visit;
part 'customers_api_service.g.dart';

@RestApi()
abstract class CustomersApiService {
  factory CustomersApiService(Dio dio, {String baseUrl}) = _CustomersApiService;
  @GET('customers')
  Future<List<Customer>> getCustomer();

  @GET('activities')
  Future<List<Activity>> getActivities();

  @GET('visits')
  Future<List<Visit>> getVisits(
    @Query('customer_id') String filter, {
    @Query('order') String? orderBy,
  });

  @POST('visits')
  Future<void> postVisit(@Body() Visit? visit);
}
