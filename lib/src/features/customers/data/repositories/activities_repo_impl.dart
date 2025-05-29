import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:visits_tracker/src/core/network/exceptions.dart';
import 'package:visits_tracker/src/core/network/failures.dart';
import 'package:visits_tracker/src/features/customers/customers.dart'
    show AbstractActivityRepository, Activity, CustomersApiService;

@Injectable(as: AbstractActivityRepository)
class ActivitiesRepoImpl implements AbstractActivityRepository {
  ActivitiesRepoImpl(this.customersApiService);

  final CustomersApiService customersApiService;
  @override
  Future<Either<Failure, List<Activity>?>> getActivities() async {
    try {
      final result = await customersApiService.getActivities();
      final activities = result.map((model) => model.toEntity()).toList();
      return Right(activities);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } catch (e) {
      return Left(GeneralException(e.toString()));
    }
  }
}
