part of 'activities_done_cubit.dart';

class ActivitiesDoneState extends Equatable {
  const ActivitiesDoneState({
    this.activities,
    this.errorMessage,
    this.status = ActivitiesDoneStatus.initial,
  });

  final List<Activity?>? activities;
  final String? errorMessage;
  final ActivitiesDoneStatus status;

  @override
  List<dynamic> get props => [activities, errorMessage, status];

  ActivitiesDoneState copyWith({
    required ActivitiesDoneStatus status,
    List<Activity?>? activities,
    String? errorMessage,
  }) {
    return ActivitiesDoneState(
      status: status,
      errorMessage: errorMessage ?? this.errorMessage,
      activities: activities ?? this.activities,
    );
  }
}

enum ActivitiesDoneStatus {
  loading,
  error,
  initial,
  success,
  empty,
}
