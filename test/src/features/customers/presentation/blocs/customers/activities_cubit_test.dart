import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:visits_tracker/src/core/network/failures.dart';
import 'package:visits_tracker/src/features/customers/customers.dart'
    show Activity;
import 'package:visits_tracker/src/features/customers/domain/usecases/activities_usecases.dart';
import 'package:visits_tracker/src/features/customers/presentation/cubits/activities_cubit/activities_cubit.dart';

class MockGetActivitiesUseCase extends Mock implements GetActivitiesUseCase {}

void main() {
  late ActivitiesCubit cubit;
  late MockGetActivitiesUseCase mockGetActivitiesUseCase;

  setUp(() {
    mockGetActivitiesUseCase = MockGetActivitiesUseCase();
    cubit = ActivitiesCubit(getActivitiesUseCase: mockGetActivitiesUseCase);
  });

  tearDown(() {
    cubit.close();
  });

  const activities = [
    Activity(id: 1, description: 'Corporate Dinner'),
    Activity(id: 1, description: 'Conference call'),
  ];

  test('initial state is ActivitiesInitial', () {
    expect(cubit.state, const ActivitiesState());
  });

  blocTest<ActivitiesCubit, ActivitiesState>(
    // ignore: lines_longer_than_80_chars
    'emits [ActivitiesLoading, ActivitiesSuccess] when getActivities is  called.',
    build: () {
      when(() => mockGetActivitiesUseCase.call(''))
          .thenAnswer((_) async => const Right(activities));
      return cubit;
    },
    act: (bloc) => cubit.getActivities(),
    expect: () => const [
      ActivitiesState(status: ActivitiesStatus.loading),
      ActivitiesState(status: ActivitiesStatus.success, activities: activities),
    ],
  );

  blocTest<ActivitiesCubit, ActivitiesState>(
    'emits [ActivitiesLoading, ActivitiesEmpty] when getActivities is  called.',
    build: () {
      when(() => mockGetActivitiesUseCase.call(''))
          .thenAnswer((_) async => const Right(null));
      return cubit;
    },
    act: (bloc) => cubit.getActivities(),
    expect: () => const [
      ActivitiesState(status: ActivitiesStatus.loading),
      ActivitiesState(status: ActivitiesStatus.empty),
    ],
  );

  blocTest<ActivitiesCubit, ActivitiesState>(
    'emits [ActivitiesLoading, ActivitiesError] when getActivities is called.',
    build: () {
      when(() => mockGetActivitiesUseCase.call('')).thenAnswer(
        (_) async => const Left(GeneralException('Falied to get activities')),
      );
      return cubit;
    },
    act: (bloc) => cubit.getActivities(),
    expect: () => const [
      ActivitiesState(status: ActivitiesStatus.loading),
      ActivitiesState(
        status: ActivitiesStatus.error,
        errorMessage: 'Falied to get activities',
      ),
    ],
  );

  blocTest<ActivitiesCubit, ActivitiesState>(
    'emits [ActivitiesLoading, ActivitiesError] when getActivities is called.',
    build: () {
      when(() => mockGetActivitiesUseCase.call(''))
          .thenThrow(Exception('Falied to get activities'));
      return cubit;
    },
    act: (bloc) => cubit.getActivities(),
    expect: () => [
      const ActivitiesState(status: ActivitiesStatus.loading),
      const ActivitiesState(
        status: ActivitiesStatus.error,
        errorMessage: 'Exception: Falied to get activities',
      ),
    ],
  );
}
