import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:visits_tracker/src/features/customers/customers.dart'
    show Customer, GetCustomersUseCase;

part 'customers_state.dart';

@injectable
class CustomersCubit extends Cubit<CustomersState> {
  CustomersCubit({required GetCustomersUseCase getCustomersUseCase})
      : _getCustomersUseCase = getCustomersUseCase,
        super(CustomersInitial());

  Future<void> getCustomers() async {
    try {
      emit(CustomersLoading());
      final result = await _getCustomersUseCase.call('');
      result.fold((l) {
        emit(CustomersError(l.errorMessage));
      }, (r) {
        emit(
          (r?.isNotEmpty ?? false) ? CustomersSuccess(r) : CustomersEmpty(),
        );
      });
    } catch (e) {
      // TODO(griffins): proper error parsing
      emit(CustomersError(e.toString()));
    }
  }

  final GetCustomersUseCase _getCustomersUseCase;
}
