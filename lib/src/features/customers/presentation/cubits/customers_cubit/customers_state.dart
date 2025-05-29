part of 'customers_cubit.dart';

sealed class CustomersState extends Equatable {
  const CustomersState();

  @override
  List<Object> get props => [];
}

final class CustomersInitial extends CustomersState {}

final class CustomersLoading extends CustomersState {}

final class CustomersSuccess extends CustomersState {
  const CustomersSuccess(this.customers);

  final List<Customer>? customers;
}

final class CustomersEmpty extends CustomersState {}

final class CustomersError extends CustomersState {
  const CustomersError(this.errorMessage);

  final String? errorMessage;
}
