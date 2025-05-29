import 'package:dartz/dartz.dart';
import 'package:visits_tracker/src/core/network/failures.dart';
import 'package:visits_tracker/src/features/customers/customers.dart'
    show Customer;

abstract class AbstractCustomerRepository {
  Future<Either<Failure, List<Customer>?>> getCustomers();
}
