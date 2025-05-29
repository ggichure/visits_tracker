// ignore_for_file: lines_longer_than_80_chars

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:visits_tracker/src/core/network/failures.dart';
import 'package:visits_tracker/src/features/customers/customers.dart';

class MockGetCustomersUseCase extends Mock implements GetCustomersUseCase {}

void main() {
  late CustomersCubit cubit;
  late MockGetCustomersUseCase mockGetCustomersUseCase;

  setUp(() {
    mockGetCustomersUseCase = MockGetCustomersUseCase();
    cubit = CustomersCubit(getCustomersUseCase: mockGetCustomersUseCase);
  });

  tearDown(() {
    cubit.close();
  });

  const testCustomers = [
    Customer(id: 1, name: 'Micheal Scott'),
    Customer(id: 2, name: 'Jim Halpert'),
  ];

  test('initial state is CustomersInitial', () {
    expect(cubit.state, CustomersInitial());
  });

  blocTest<CustomersCubit, CustomersState>(
    'emits [CustomersLoading, CustomersSuccess] when getCustomers returns non-empty list',
    build: () {
      when(() => mockGetCustomersUseCase.call(''))
          .thenAnswer((_) async => const Right(testCustomers));
      return cubit;
    },
    act: (cubit) => cubit.getCustomers(),
    expect: () => [
      CustomersLoading(),
      const CustomersSuccess(testCustomers),
    ],
  );

  blocTest<CustomersCubit, CustomersState>(
    'emits [CustomersLoading, CustomersEmpty] when getCustomers returns empty list',
    build: () {
      when(() => mockGetCustomersUseCase.call(''))
          .thenAnswer((_) async => const Right([]));
      return cubit;
    },
    act: (cubit) => cubit.getCustomers(),
    expect: () => [
      CustomersLoading(),
      CustomersEmpty(),
    ],
  );

  blocTest<CustomersCubit, CustomersState>(
    'emits [CustomersLoading, CustomersError] when getCustomers returns failure',
    build: () {
      when(() => mockGetCustomersUseCase.call('')).thenAnswer(
        (_) async => const Left(GeneralException('Failed to fetch customers')),
      );
      return cubit;
    },
    act: (cubit) => cubit.getCustomers(),
    expect: () => [
      CustomersLoading(),
      const CustomersError('Failed to fetch customers'),
    ],
  );

  blocTest<CustomersCubit, CustomersState>(
    'emits [CustomersLoading, CustomersError] on exception',
    build: () {
      when(() => mockGetCustomersUseCase.call(''))
          .thenThrow(Exception('Unexpected error'));
      return cubit;
    },
    act: (cubit) => cubit.getCustomers(),
    expect: () => [
      CustomersLoading(),
      const CustomersError('Exception: Unexpected error'),
    ],
  );
}
