import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:visits_tracker/src/core/network/exceptions.dart';
import 'package:visits_tracker/src/core/network/failures.dart';
import 'package:visits_tracker/src/features/customers/customers.dart'
    show AbstractVisitsRepository, CustomersApiService;
import 'package:visits_tracker/src/features/customers/domain/entities/visit/visit.dart';

@Injectable(as: AbstractVisitsRepository)
class VisitsRepoImpl implements AbstractVisitsRepository {
  VisitsRepoImpl(this.customersApiService);

  final CustomersApiService customersApiService;
  @override
  Future<Either<Failure, List<Visit>?>> getVisits({int? customerId}) async {
    try {
      // TODO(griffins): 'created_at.desc' from params
      final result = await customersApiService.getVisits(
        customerId != null ? 'eq.$customerId' : '',
        orderBy: 'visit_date.desc',
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } catch (e) {
      return Left(GeneralException(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> postVisits(Visit? visit) async {
    try {
      final result = await customersApiService.postVisit(visit);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } catch (e) {
      return Left(GeneralException(e.toString()));
    }
  }
}
