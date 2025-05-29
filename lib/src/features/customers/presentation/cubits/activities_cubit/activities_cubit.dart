import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:visits_tracker/src/features/customers/customers.dart'
    show Activity, GetActivitiesUseCase;

part 'activities_state.dart';

@injectable
class ActivitiesCubit extends Cubit<ActivitiesState> {
  ActivitiesCubit({required GetActivitiesUseCase getActivitiesUseCase})
      : _getActivitiesUseCase = getActivitiesUseCase,
        super(const ActivitiesState());

  Future<void> getActivities() async {
    try {
      emit(state.copyWith(status: ActivitiesStatus.loading));
      final result = await _getActivitiesUseCase.call('');
      result.fold((l) {
        emit(
          state.copyWith(
            status: ActivitiesStatus.error,
            errorMessage: l.errorMessage,
          ),
        );
      }, (r) {
        emit(
          state.copyWith(
            status: (r?.isNotEmpty ?? false)
                ? ActivitiesStatus.success
                : ActivitiesStatus.empty,
            activities: r,
          ),
        );
      });
    } catch (e) {
      // TODO(griffins): proper error parsing
      emit(
        state.copyWith(
          status: ActivitiesStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  final GetActivitiesUseCase _getActivitiesUseCase;
}
