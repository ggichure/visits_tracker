part of 'activities_cubit.dart';

class ActivitiesState extends Equatable {
  const ActivitiesState({
    this.activities,
    this.errorMessage,
    this.status = ActivitiesStatus.initial,
  });

  final List<Activity>? activities;
  final String? errorMessage;
  final ActivitiesStatus status;

  @override
  List<dynamic> get props => [activities, errorMessage, status];

  ActivitiesState copyWith({
    required ActivitiesStatus status,
    List<Activity>? activities,
    String? errorMessage,
  }) {
    return ActivitiesState(
      status: status,
      errorMessage: errorMessage ?? this.errorMessage,
      activities: activities ?? this.activities,
    );
  }
}

enum ActivitiesStatus {
  loading,
  error,
  initial,
  success,
  empty,
}
