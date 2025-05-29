import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:visits_tracker/src/core/network/failures.dart';
import 'package:visits_tracker/src/core/usecases/usecases.dart';
import 'package:visits_tracker/src/features/customers/customers.dart'
    show AbstractCustomerRepository, Customer;

@injectable
class GetCustomersUseCase extends UseCase<List<Customer>?, dynamic> {
  GetCustomersUseCase(this.repository);
  final AbstractCustomerRepository repository;

  @override
  Future<Either<Failure, List<Customer>?>> call(
    dynamic params,
  ) async {
    final result = await repository.getCustomers();
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}
