import 'package:dartz/dartz.dart';
import 'package:visits_tracker/src/core/network/failures.dart';
import 'package:visits_tracker/src/features/customers/customers.dart'
    show Visit;

abstract class AbstractVisitsRepository {
  Future<Either<Failure, List<Visit>?>> getVisits({int? customerId});
  Future<Either<Failure, void>> postVisits(Visit? visit);
}
