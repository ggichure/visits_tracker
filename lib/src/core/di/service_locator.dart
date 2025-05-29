import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:visits_tracker/src/core/di/service_locator.config.dart';

final getIt = GetIt.instance;

@InjectableInit(preferRelativeImports: true)
void configureDependencies() => getIt.init();
