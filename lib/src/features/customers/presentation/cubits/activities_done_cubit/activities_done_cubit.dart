import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:visits_tracker/src/features/customers/customers.dart'
    show Activity;

part 'activities_done_state.dart';

@injectable
class ActivitiesDoneCubit extends Cubit<ActivitiesDoneState> {
  ActivitiesDoneCubit() : super(const ActivitiesDoneState());

  Future<void> addActivityDone(Activity? activity) async {
    if (activity == null) return;
    emit(state.copyWith(status: ActivitiesDoneStatus.loading));

    final currentActivities = state.activities;

    // Prevent duplicates by checking ID
    final exists = currentActivities?.any((a) => a?.id == activity.id);
    if (exists ?? false) return;

    final updatedActivities = List<Activity>.from(currentActivities ?? [])
      ..add(activity);

    emit(
      state.copyWith(
        activities: updatedActivities,
        status: ActivitiesDoneStatus.success,
      ),
    );
  }

  Future<void> removeActivityDone(int activityId) async {
    emit(state.copyWith(status: ActivitiesDoneStatus.loading));

    final currentActivities = state.activities ?? [];

    final updatedActivities =
        currentActivities.where((a) => a?.id != activityId).toList();

    emit(
      state.copyWith(
        activities: updatedActivities,
        status: ActivitiesDoneStatus.success,
      ),
    );
  }
}
