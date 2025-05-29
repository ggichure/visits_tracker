import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visits_tracker/l10n/arb/app_localizations.dart';
import 'package:visits_tracker/src/core/di/service_locator.dart';
import 'package:visits_tracker/src/core/router/app_router.dart';
import 'package:visits_tracker/src/features/customers/customers.dart'
    show CustomersCubit;

final appRouter = getIt<AppRouter>();

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<CustomersCubit>()..getCustomers(),
        ),
      ],
      child: MaterialApp.router(
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          ),
          useMaterial3: true,
        ),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: appRouter.config(),
      ),
    );
  }
}
