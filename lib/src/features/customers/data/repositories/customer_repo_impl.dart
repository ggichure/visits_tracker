import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:visits_tracker/src/core/network/exceptions.dart';
import 'package:visits_tracker/src/core/network/failures.dart';
import 'package:visits_tracker/src/features/customers/customers.dart'
    show AbstractCustomerRepository, Customer, CustomersApiService;

@Injectable(as: AbstractCustomerRepository)
class CustomerRepoImpl implements AbstractCustomerRepository {
  CustomerRepoImpl(this.customersApiService);

  final CustomersApiService customersApiService;
  @override
  Future<Either<Failure, List<Customer>?>> getCustomers() async {
    try {
      final result = await customersApiService.getCustomer();
      final customers = result.map((model) => model.toEntity()).toList();
      return Right(customers);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } catch (e) {
      return Left(GeneralException(e.toString()));
    }
  }
}
