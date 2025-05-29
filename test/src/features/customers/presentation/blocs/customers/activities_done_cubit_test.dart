import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:visits_tracker/src/features/customers/customers.dart'
    show Activity;
import 'package:visits_tracker/src/features/customers/presentation/cubits/activities_done_cubit/activities_done_cubit.dart';

void main() {
  group('ActivitiesDoneCubit', () {
    late ActivitiesDoneCubit cubit;

    setUp(() {
      cubit = ActivitiesDoneCubit();
    });

    tearDown(() {
      cubit.close();
    });

    test('initial state is ActivitiesDoneState with empty activities', () {
      expect(cubit.state.activities, isNull);
      expect(cubit.state.status, ActivitiesDoneStatus.initial);
    });

    blocTest<ActivitiesDoneCubit, ActivitiesDoneState>(
      'remove activity with non-existing id does not change activities',
      build: () => cubit,
      seed: () => const ActivitiesDoneState(
        activities: [Activity(id: 1, description: 'Test Activity')],
      ),
      act: (cubit) => cubit.removeActivityDone(99),
      expect: () => [
        cubit.state.copyWith(status: ActivitiesDoneStatus.loading),
        cubit.state.copyWith(
          status: ActivitiesDoneStatus.success,
          activities: [const Activity(id: 1, description: 'Test Activity')],
        ),
      ],
    );
  });
}
