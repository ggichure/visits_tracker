// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/customers/customers.dart' as _i1068;
import '../../features/customers/data/repositories/activities_repo_impl.dart'
    as _i785;
import '../../features/customers/data/repositories/customer_repo_impl.dart'
    as _i554;
import '../../features/customers/data/repositories/visits_repo_impl.dart'
    as _i589;
import '../../features/customers/domain/usecases/activities_usecases.dart'
    as _i158;
import '../../features/customers/domain/usecases/customer_usecases.dart'
    as _i449;
import '../../features/customers/domain/usecases/visits_usecases.dart' as _i114;
import '../../features/customers/presentation/cubits/activities_cubit/activities_cubit.dart'
    as _i464;
import '../../features/customers/presentation/cubits/activities_done_cubit/activities_done_cubit.dart'
    as _i580;
import '../../features/customers/presentation/cubits/customers_cubit/customers_cubit.dart'
    as _i54;
import '../../features/customers/presentation/cubits/visits_cubit/visits_cubit.dart'
    as _i443;
import '../router/app_router.dart' as _i81;
import 'app_module.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    gh.factory<_i81.AppRouter>(() => appModule.appRouter);
    gh.factory<_i580.ActivitiesDoneCubit>(() => _i580.ActivitiesDoneCubit());
    gh.factory<String>(
      () => appModule.baseUrl,
      instanceName: 'BaseUrl',
    );
    gh.lazySingleton<_i361.Dio>(
        () => appModule.dio(gh<String>(instanceName: 'BaseUrl')));
    gh.lazySingleton<_i1068.CustomersApiService>(
        () => appModule.provideApiClient(gh<_i361.Dio>()));
    gh.factory<_i1068.AbstractCustomerRepository>(
        () => _i554.CustomerRepoImpl(gh<_i1068.CustomersApiService>()));
    gh.factory<_i1068.AbstractVisitsRepository>(
        () => _i589.VisitsRepoImpl(gh<_i1068.CustomersApiService>()));
    gh.factory<_i1068.AbstractActivityRepository>(
        () => _i785.ActivitiesRepoImpl(gh<_i1068.CustomersApiService>()));
    gh.factory<_i158.GetActivitiesUseCase>(() =>
        _i158.GetActivitiesUseCase(gh<_i1068.AbstractActivityRepository>()));
    gh.factory<_i449.GetCustomersUseCase>(() =>
        _i449.GetCustomersUseCase(gh<_i1068.AbstractCustomerRepository>()));
    gh.factory<_i114.GetVisitsUseCase>(
        () => _i114.GetVisitsUseCase(gh<_i1068.AbstractVisitsRepository>()));
    gh.factory<_i114.PostVisitsUseCase>(
        () => _i114.PostVisitsUseCase(gh<_i1068.AbstractVisitsRepository>()));
    gh.factory<_i54.CustomersCubit>(() => _i54.CustomersCubit(
        getCustomersUseCase: gh<_i1068.GetCustomersUseCase>()));
    gh.factory<_i464.ActivitiesCubit>(() => _i464.ActivitiesCubit(
        getActivitiesUseCase: gh<_i1068.GetActivitiesUseCase>()));
    gh.factory<_i443.VisitsCubit>(() => _i443.VisitsCubit(
          postVisitsUseCase: gh<_i1068.PostVisitsUseCase>(),
          getVisitsUseCase: gh<_i1068.GetVisitsUseCase>(),
        ));
    return this;
  }
}

class _$AppModule extends _i460.AppModule {}
