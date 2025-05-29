import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:visits_tracker/l10n/arb/app_localizations.dart';
import 'package:visits_tracker/src/features/customers/customers.dart';
import 'package:visits_tracker/src/features/customers/presentation/views/widgets/activities/activities_picker_widget.dart';

class MockActivitiesCubit extends Mock implements ActivitiesCubit {}

class FakeActivity extends Fake implements Activity {}

void main() {
  late ActivitiesCubit mockCubit;

  setUpAll(() {
    registerFallbackValue(FakeActivity());
    registerFallbackValue(
      const ActivitiesState(
        activities: [],
      ),
    );
  });

  setUp(() {
    mockCubit = MockActivitiesCubit();

    when(() => mockCubit.state).thenReturn(
      const ActivitiesState(status: ActivitiesStatus.loading),
    );

    when(() => mockCubit.stream)
        .thenAnswer((_) => const Stream<ActivitiesState>.empty());
  });

  Widget makeTestableWidget(Widget child) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: BlocProvider<ActivitiesCubit>.value(
          value: mockCubit,
          child: child,
        ),
      ),
    );
  }

  testWidgets('renders loading spinner', (tester) async {
    when(() => mockCubit.stream).thenAnswer(
      (_) => Stream.fromIterable([
        const ActivitiesState(status: ActivitiesStatus.loading),
        const ActivitiesState(
          status: ActivitiesStatus.success,
          activities: [Activity(id: 1, description: 'Meeting')],
        ),
      ]),
    );

    await tester.pumpWidget(makeTestableWidget(const ActivitiesPickerWidget()));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
