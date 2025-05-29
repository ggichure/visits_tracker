import 'package:dartz/dartz.dart';
import 'package:visits_tracker/src/core/network/failures.dart';
import 'package:visits_tracker/src/features/customers/customers.dart';

abstract class AbstractActivityRepository {
  Future<Either<Failure, List<Activity>?>> getActivities();
}
