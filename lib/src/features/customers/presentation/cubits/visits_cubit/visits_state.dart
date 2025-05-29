part of 'visits_cubit.dart';

sealed class VisitsState extends Equatable {
  const VisitsState();

  @override
  List<Object> get props => [];
}

final class VisitsInitial extends VisitsState {}

final class VisitsLoading extends VisitsState {}

final class VisitsSuccess extends VisitsState {
  const VisitsSuccess(this.visits);

  final List<Visit>? visits;
}

final class VisitsEmpty extends VisitsState {}

final class VisitsCreated extends VisitsState {}

final class VisitsError extends VisitsState {
  const VisitsError(this.errorMessage);

  final String? errorMessage;
}
