import 'package:flutter/material.dart';
import 'package:visits_tracker/app/app.dart';
import 'package:visits_tracker/bootstrap.dart';
import 'package:visits_tracker/src/core/di/service_locator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  configureDependencies();
  bootstrap(() => const App());
}
