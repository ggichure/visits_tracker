import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:visits_tracker/src/features/customers/customers.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(initial: true, page: CutsomersRoute.page),
        AutoRoute(page: VisitsRoute.page),
        AutoRoute(page: CreateVisitsRoute.page),
      ];
}
