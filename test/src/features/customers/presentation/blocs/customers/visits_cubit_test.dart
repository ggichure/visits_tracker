import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:visits_tracker/src/core/network/failures.dart';
import 'package:visits_tracker/src/features/customers/customers.dart'
    show GetVisitsUseCase, PostVisitsUseCase, Visit;
import 'package:visits_tracker/src/features/customers/presentation/cubits/visits_cubit/visits_cubit.dart';

class MockGetVisitsUseCase extends Mock implements GetVisitsUseCase {}

class MockPostVisitsUseCase extends Mock implements PostVisitsUseCase {}

class MockVisit extends Mock implements Visit {}

class MockFailure extends Equatable implements Exception {

  const MockFailure(this.errorMessage);
  final String errorMessage;

  @override
  List<Object?> get props => [errorMessage];
}

void main() {
  setUpAll(() {
    registerFallbackValue(const Right<MockFailure, List<Visit>?>([]));
    registerFallbackValue(
        const Left<MockFailure, List<Visit>?>(MockFailure('error')),);
    registerFallbackValue(const Right<MockFailure, void>(null));
    registerFallbackValue(const Left<MockFailure, void>(MockFailure('error')));
  });

  group('VisitsCubit', () {
    late MockGetVisitsUseCase mockGetVisitsUseCase;
    late MockPostVisitsUseCase mockPostVisitsUseCase;
    late VisitsCubit visitsCubit;
    late Visit tVisit;
    late List<Visit> tVisitsList;

    setUp(() {
      mockGetVisitsUseCase = MockGetVisitsUseCase();
      mockPostVisitsUseCase = MockPostVisitsUseCase();
      visitsCubit = VisitsCubit(
        getVisitsUseCase: mockGetVisitsUseCase,
        postVisitsUseCase: mockPostVisitsUseCase,
      );

      tVisit = MockVisit();
      tVisitsList = [tVisit];
    });

    tearDown(() {
      visitsCubit.close();
    });

    test('initial state is VisitsInitial', () {
      expect(visitsCubit.state, VisitsInitial());
    });

    // --- Tests for getVisits ---
    group('getVisits', () {
      const tCustomerId = 1;

      blocTest<VisitsCubit, VisitsState>(
        'emits [VisitsLoading, VisitsSuccess] when GetVisitsUseCase returns a list of visits.',
        build: () {
          when(() => mockGetVisitsUseCase.call(any()))
              .thenAnswer((_) async => Right(tVisitsList));
          return visitsCubit;
        },
        act: (cubit) => cubit.getVisits(customerId: tCustomerId),
        expect: () => [
          VisitsLoading(),
          VisitsSuccess(tVisitsList),
        ],
        verify: (_) {
          verify(() => mockGetVisitsUseCase.call(tCustomerId)).called(1);
        },
      );

      blocTest<VisitsCubit, VisitsState>(
        'emits [VisitsLoading, VisitsSuccess] when GetVisitsUseCase returns a list of visits (no customerId).',
        build: () {
          when(() => mockGetVisitsUseCase.call(null))
              .thenAnswer((_) async => Right(tVisitsList));
          return visitsCubit;
        },
        act: (cubit) => cubit.getVisits(),
        expect: () => [
          VisitsLoading(),
          VisitsSuccess(tVisitsList),
        ],
        verify: (_) {
          verify(() => mockGetVisitsUseCase.call(null)).called(1);
        },
      );

      blocTest<VisitsCubit, VisitsState>(
        'emits [VisitsLoading, VisitsEmpty] when GetVisitsUseCase returns an empty list.',
        build: () {
          when(() => mockGetVisitsUseCase.call(any()))
              .thenAnswer((_) async => const Right([])); // Empty list
          return visitsCubit;
        },
        act: (cubit) => cubit.getVisits(customerId: tCustomerId),
        expect: () => [
          VisitsLoading(),
          VisitsEmpty(),
        ],
      );

      blocTest<VisitsCubit, VisitsState>(
        'emits [VisitsLoading, VisitsEmpty] when GetVisitsUseCase returns null.',
        build: () {
          when(() => mockGetVisitsUseCase.call(any()))
              .thenAnswer((_) async => const Right(null)); // Null list
          return visitsCubit;
        },
        act: (cubit) => cubit.getVisits(customerId: tCustomerId),
        expect: () => [
          VisitsLoading(),
          VisitsEmpty(),
        ],
      );

      blocTest<VisitsCubit, VisitsState>(
        'emits [VisitsLoading, VisitsError] when GetVisitsUseCase returns a Failure.',
        build: () {
          when(() => mockGetVisitsUseCase.call(any())).thenAnswer((_) async =>
              const Left(GeneralException('Failed to fetch visits')),);
          return visitsCubit;
        },
        act: (cubit) => cubit.getVisits(customerId: tCustomerId),
        expect: () => [
          VisitsLoading(),
          const VisitsError('Failed to fetch visits'),
        ],
      );

      blocTest<VisitsCubit, VisitsState>(
        'emits [VisitsLoading, VisitsError] when GetVisitsUseCase throws an exception.',
        build: () {
          when(() => mockGetVisitsUseCase.call(any()))
              .thenThrow(Exception('Something went wrong'));
          return visitsCubit;
        },
        act: (cubit) => cubit.getVisits(customerId: tCustomerId),
        expect: () => [
          VisitsLoading(),
          const VisitsError('Exception: Something went wrong'),
        ],
      );
    });

    // --- Tests for postVisit ---
    group('postVisit', () {
      final tConcreteVisit = MockVisit();

      blocTest<VisitsCubit, VisitsState>(
        'emits [VisitsLoading, VisitsCreated] when PostVisitsUseCase succeeds.',
        build: () {
          when(() => mockPostVisitsUseCase.call(any()))
              .thenAnswer((_) async => const Right(null));
          return visitsCubit;
        },
        act: (cubit) => cubit.postVisit(tConcreteVisit),
        expect: () => [
          VisitsLoading(),
          VisitsCreated(),
        ],
        verify: (_) {
          verify(() => mockPostVisitsUseCase.call(tConcreteVisit)).called(1);
        },
      );

      blocTest<VisitsCubit, VisitsState>(
        'emits [VisitsLoading, VisitsError] when PostVisitsUseCase returns a Failure.',
        build: () {
          when(() => mockPostVisitsUseCase.call(any())).thenAnswer((_) async =>
              const Left(GeneralException('Failed to post visit')),);
          return visitsCubit;
        },
        act: (cubit) => cubit.postVisit(tConcreteVisit),
        expect: () => [
          VisitsLoading(),
          const VisitsError('Failed to post visit'),
        ],
      );

      blocTest<VisitsCubit, VisitsState>(
        'emits [VisitsLoading, VisitsError] when PostVisitsUseCase throws an exception.',
        build: () {
          when(() => mockPostVisitsUseCase.call(any()))
              .thenThrow(Exception('Network error'));
          return visitsCubit;
        },
        act: (cubit) => cubit.postVisit(tConcreteVisit),
        expect: () => [
          VisitsLoading(),
          const VisitsError('Exception: Network error'),
        ],
      );

      blocTest<VisitsCubit, VisitsState>(
          'emits [VisitsLoading, VisitsError] when postVisit is called with null visit and use case throws (edge case).',
          build: () {
            when(() => mockPostVisitsUseCase.call(null))
                .thenThrow(Exception('Null visit not allowed by use case'));
            return visitsCubit;
          },
          act: (cubit) => cubit.postVisit(null),
          expect: () => [
                VisitsLoading(),
                const VisitsError(
                    'Exception: Null visit not allowed by use case',),
              ],
          verify: (_) {
            verify(() => mockPostVisitsUseCase.call(null)).called(1);
          },);
    });
  });
}
