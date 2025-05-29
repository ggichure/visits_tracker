import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:visits_tracker/src/core/network/failures.dart';
import 'package:visits_tracker/src/core/usecases/usecases.dart';
import 'package:visits_tracker/src/features/customers/customers.dart'
    show AbstractActivityRepository, Activity;

@injectable
class GetActivitiesUseCase extends UseCase<List<Activity>?, dynamic> {
  GetActivitiesUseCase(this.repository);
  final AbstractActivityRepository repository;

  @override
  Future<Either<Failure, List<Activity>?>> call(
    dynamic params,
  ) async {
    final result = await repository.getActivities();
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}
