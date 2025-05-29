import 'package:dio/dio.dart';

import 'package:retrofit/retrofit.dart';
import 'package:visits_tracker/src/features/customers/data/models/activity/activity_model.dart';
import 'package:visits_tracker/src/features/customers/data/models/cutsomer/customer_model.dart';
import 'package:visits_tracker/src/features/customers/data/models/visit/visit_model.dart';
part 'customers_api_service.g.dart';

@RestApi()
abstract class CustomersApiService {
  factory CustomersApiService(Dio dio, {String baseUrl}) = _CustomersApiService;
  @GET('customers')
  Future<List<CustomerModel>> getCustomer();

  @GET('activities')
  Future<List<ActivityModel>> getActivities();

  @GET('visits')
  Future<List<VisitModel>> getVisits(
    @Query('customer_id') String filter, {
    @Query('order') String? orderBy,
  });

  @POST('visits')
  Future<void> postVisit(@Body() VisitModel? visit);
}
