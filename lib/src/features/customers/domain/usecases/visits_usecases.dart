import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:visits_tracker/src/core/network/failures.dart';
import 'package:visits_tracker/src/core/usecases/usecases.dart';
import 'package:visits_tracker/src/features/customers/customers.dart'
    show AbstractVisitsRepository, Visit;

@injectable
class GetVisitsUseCase extends UseCase<List<Visit>?, int?> {
  GetVisitsUseCase(this.repository);
  final AbstractVisitsRepository repository;

  @override
  Future<Either<Failure, List<Visit>?>> call(
    int? params,
  ) async {
    final result = await repository.getVisits(customerId: params);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}

@injectable
class PostVisitsUseCase extends UseCase<void, Visit?> {
  PostVisitsUseCase(this.repository);
  final AbstractVisitsRepository repository;

  @override
  Future<Either<Failure, void>> call(
    Visit? params,
  ) async {
    final result = await repository.postVisits(params);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}
