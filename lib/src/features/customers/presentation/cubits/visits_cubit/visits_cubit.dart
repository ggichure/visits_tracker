import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:visits_tracker/src/features/customers/customers.dart'
    show GetVisitsUseCase, PostVisitsUseCase, Visit;

part 'visits_state.dart';

@injectable
class VisitsCubit extends Cubit<VisitsState> {
  VisitsCubit({
    required PostVisitsUseCase postVisitsUseCase,
    required GetVisitsUseCase getVisitsUseCase,
  })  : _getVisitsUseCase = getVisitsUseCase,
        _postVisitsUseCase = postVisitsUseCase,
        super(VisitsInitial());

  Future<void> getVisits({int? customerId}) async {
    try {
      emit(VisitsLoading());
      final result = await _getVisitsUseCase.call(customerId);
      result.fold((l) {
        emit(VisitsError(l.errorMessage));
      }, (r) {
        emit((r?.isNotEmpty ?? false) ? VisitsSuccess(r) : VisitsEmpty());
      });
    } catch (e) {
      emit(VisitsError(e.toString()));
    }
  }

  Future<void> postVisit(Visit? visit) async {
    try {
      emit(VisitsLoading());
      final result = await _postVisitsUseCase.call(visit);
      result.fold((l) {
        emit(VisitsError(l.errorMessage));
      }, (r) {
        emit(VisitsCreated());
      });
    } catch (e) {
      emit(VisitsError(e.toString()));
    }
  }

  final GetVisitsUseCase _getVisitsUseCase;
  final PostVisitsUseCase _postVisitsUseCase;
}
