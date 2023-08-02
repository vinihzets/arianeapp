import 'package:ariane_app/core/services/auth_service.dart';
import 'package:ariane_app/core/services/database_service.dart';
import 'package:ariane_app/core/utils/const_routes.dart';
import 'package:ariane_app/features/clients/data/datasources/client_datasources.dart';
import 'package:ariane_app/features/clients/data/datasources/remote/client_datasources_remote_impl.dart';
import 'package:ariane_app/features/clients/data/mappers/client_mapper.dart';
import 'package:ariane_app/features/clients/data/repositories/client_repository_impl.dart';
import 'package:ariane_app/features/clients/domain/repositories/client_repository.dart';
import 'package:ariane_app/features/clients/domain/usecases/create_client_usecase_impl.dart';
import 'package:ariane_app/features/clients/domain/usecases/delete_client_usecase_impl.dart';
import 'package:ariane_app/features/clients/domain/usecases/read_client_usecase_impl.dart';
import 'package:ariane_app/features/clients/domain/usecases/search_client_usecase_impl.dart';
import 'package:ariane_app/features/clients/domain/usecases/update_client_usecase_impl.dart';
import 'package:ariane_app/features/clients/presentation/bloc/client_bloc.dart';
import 'package:ariane_app/features/home/data/datasources/home_datasources.dart';
import 'package:ariane_app/features/home/data/datasources/remote/home_datasources_remote_impl.dart';
import 'package:ariane_app/features/home/data/repositories/home_repository_impl.dart';
import 'package:ariane_app/features/home/domain/repositories/home_repository.dart';
import 'package:ariane_app/features/home/domain/usecases/sign_out_usecase_impl.dart';
import 'package:ariane_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:ariane_app/features/login/data/datasources/login_datasources.dart';
import 'package:ariane_app/features/login/data/datasources/remote/login_datasources_remote_impl.dart';
import 'package:ariane_app/features/login/data/repositories/login_repository_impl.dart';

import 'package:ariane_app/features/login/domain/repositories/login_repository.dart';
import 'package:ariane_app/features/login/domain/usecases/sign_in_usecase_impl.dart';
import 'package:ariane_app/features/login/presentation/bloc/login_bloc.dart';
import 'package:ariane_app/features/pending/pending.dart';
import 'package:ariane_app/features/perfuration/domain/usecases/read_type_perfuration_usecase_impl.dart';
import 'package:ariane_app/features/perfuration/perfurations.dart';
import 'package:ariane_app/features/periods/periods.dart';
import 'package:ariane_app/features/register/data/datasources/register_datasources.dart';
import 'package:ariane_app/features/register/data/datasources/remote/register_datasources_remote_impl.dart';
import 'package:ariane_app/features/register/data/repositories/register_repository_impl.dart';
import 'package:ariane_app/features/register/domain/repositories/register_repository.dart';
import 'package:ariane_app/features/register/domain/usecases/sign_up_usecase_impl.dart';
import 'package:ariane_app/features/register/presentation/bloc/register_bloc.dart';
import 'package:ariane_app/features/scheduling_message/data/datasources/remote/scheduling_message_datasources_remote_impl.dart';
import 'package:ariane_app/features/scheduling_message/data/datasources/scheduling_message_datasources.dart';
import 'package:ariane_app/features/scheduling_message/data/mappers/scheduling_message_mapper.dart';
import 'package:ariane_app/features/scheduling_message/data/repositories/scheduling_message_repository_impl.dart';
import 'package:ariane_app/features/scheduling_message/domain/repositories/scheduling_message_repository.dart';
import 'package:ariane_app/features/scheduling_message/domain/usecases/create_scheduling_message_usecase_impl.dart';
import 'package:ariane_app/features/scheduling_message/domain/usecases/delete_scheduling_message_usecase_impl.dart';
import 'package:ariane_app/features/scheduling_message/domain/usecases/scheduling_message_read_clients_usecase_impl.dart';
import 'package:ariane_app/features/scheduling_message/domain/usecases/read_scheduling_messages_usecase_impl.dart';
import 'package:ariane_app/features/scheduling_message/domain/usecases/scheduling_message_search_clients_usecase_imppl.dart';
import 'package:ariane_app/features/scheduling_message/domain/usecases/update_scheduling_message_usecase_impl.dart';
import 'package:ariane_app/features/scheduling_message/presentation/bloc/scheduling_message_bloc.dart';
import 'package:ariane_app/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:ariane_app/features/type_perfurations/domain/usecases/read_periods_usecase_impl.dart';
import 'package:ariane_app/features/type_perfurations/type_perfurations.dart';
import 'package:get_it/get_it.dart';

class Injector {
  static build() {
    GetIt getIt = GetIt.instance;

    //CORE
    getIt.registerLazySingleton(() => ConstRoutes());
    getIt.registerLazySingleton(() => AuthService());
    getIt.registerLazySingleton(() => DatabaseService());

    // Mappers
    getIt.registerLazySingleton(() => ClientMapper());
    getIt.registerLazySingleton(() => TypePerfurationMapper(getIt()));
    getIt.registerLazySingleton(() => PeriodMapper());
    getIt.registerLazySingleton(() => PerfurationMapper(getIt()));
    getIt.registerLazySingleton(() => PendingMapper(getIt(), getIt()));
    getIt.registerLazySingleton(() => SchedulingMessageMapper(getIt()));

    // DATASOURCES

    getIt.registerLazySingleton<SchedulingMessageDataSources>(() =>
        SchedulingMessageDataSourcesRemoteImpl(getIt(), getIt(), getIt()));
    getIt.registerLazySingleton<PerfurationDataSources>(
        () => PerfurationDataSourcesRemoteImpl(getIt(), getIt(), getIt()));
    getIt.registerLazySingleton<PeriodDataSources>(
        () => PeriodDataSourcesRemoteImpl(getIt(), getIt()));
    getIt.registerLazySingleton<TypePerfurationDataSources>(
        () => TypePerfurationDataSourcesRemoteImpl(getIt(), getIt(), getIt()));
    getIt.registerLazySingleton<ClientDataSources>(
        () => ClientDataSourcesRemoteImpl(getIt(), getIt()));
    getIt.registerLazySingleton<HomeDataSources>(
        () => HomeDataSourcesRemoteImpl(getIt()));
    getIt.registerLazySingleton<RegisterDataSources>(
        () => RegisterDataSourcesRemoteImpl(getIt(), getIt()));
    getIt.registerLazySingleton<LoginDataSources>(
        () => LoginDataSourcesRemoteImpl(getIt(), getIt()));
    getIt.registerLazySingleton<PendingDataSource>(
        () => PendingDataSourceRemoteImpl(getIt(), getIt()));

    //REPOSITORIES

    getIt.registerLazySingleton<SchedulingMessageRepository>(
        () => SchedulingMessageRepositoryImpl(getIt()));
    getIt.registerLazySingleton<PerfurationRepository>(
        () => PerfurationRepositoryImpl(getIt()));
    getIt.registerLazySingleton<PeriodRepository>(
        () => PeriodRepositoryImpl(getIt()));
    getIt.registerLazySingleton<TypePerfurationRepository>(
        () => TypePerfurationRepositoryImpl(getIt()));
    getIt.registerLazySingleton<ClientRepository>(
        () => ClientRepositoryImpl(getIt()));
    getIt.registerLazySingleton<HomeRepository>(
        () => HomeRepositoryImpl(getIt()));
    getIt.registerLazySingleton<RegisterRepository>(
        () => RegisterRepositoryImpl(getIt()));
    getIt.registerLazySingleton<LoginRepository>(
        () => LoginRepositoryImpl(getIt()));
    getIt.registerLazySingleton<PendingRepository>(
        () => PendingRepositoryImpl(getIt()));

    // USECASES

    getIt.registerLazySingleton(
        () => SchedulingMessageSearchClientsUseCaseImpl(getIt()));
    getIt.registerLazySingleton(
        () => SchedulingMessageReadClientsUseCaseImpl(getIt()));
    getIt.registerLazySingleton(
        () => ReadSchedulingMessagesUseCaseImpl(getIt()));
    getIt.registerLazySingleton(
        () => DeleteSchedulingMessageUseCaseImpl(getIt()));
    getIt.registerLazySingleton(
        () => UpdateSchedulingMessageUseCaseImpl(getIt()));
    getIt.registerLazySingleton(
        () => CreateSchedulingMessageUseCaseImpl(getIt()));
    getIt.registerLazySingleton(() => SearchClientUseCaseImpl(getIt()));
    getIt.registerLazySingleton(() => ReadTypesPerfurationUseCaseImpl(getIt()));
    getIt.registerLazySingleton(() => DeletePerfurationUseCaseImpl(getIt()));
    getIt.registerLazySingleton(() => CreatePerfurationUseCaseImpl(getIt()));
    getIt.registerLazySingleton(() => ReadPerfurationsUseCaseImpl(getIt()));
    getIt.registerLazySingleton(() => ReadPeriodsUseCaseImpl(getIt()));
    getIt.registerLazySingleton(() => CreatePeriodUseCaseImpl(getIt()));
    getIt.registerLazySingleton(() => UpdatePeriodUseCaseImpl(getIt()));
    getIt.registerLazySingleton(() => DeletePeriodUseCaseImpl(getIt()));
    getIt.registerLazySingleton(() => ReadPeriodUseCaseImpl(getIt()));
    getIt.registerLazySingleton(
        () => UpdateTypePerfurationsUseCaseImpl(getIt()));
    getIt
        .registerLazySingleton(() => DeleteTypePerfurationUseCaseImpl(getIt()));
    getIt.registerLazySingleton(() => ReadTypePerfurationsUseCaseImpl(getIt()));
    getIt
        .registerLazySingleton(() => CreateTypePerfurationUseCaseImpl(getIt()));
    getIt.registerLazySingleton(() => UpdateClientUseCaseImpl(getIt()));
    getIt.registerLazySingleton(() => DeleteClientUseCaseImpl(getIt()));
    getIt.registerLazySingleton(() => ReadClientUseCaseImpl(getIt()));
    getIt.registerLazySingleton(() => CreateClientUseCaseImpl(getIt()));
    getIt.registerLazySingleton(() => SignOutUseCaseImpl(getIt()));
    getIt.registerLazySingleton(() => SignUpUseCaseImpl(getIt()));
    getIt.registerLazySingleton(() => SignInUseCaseImpl(getIt()));
    getIt.registerLazySingleton(() => GetPendingUseCaseImpl(getIt()));

    //BLOC

    getIt.registerFactory(() => SchedulingMessageBloc(
        getIt(), getIt(), getIt(), getIt(), getIt(), getIt()));
    getIt.registerFactory(
        () => PerfurationsBloc(getIt(), getIt(), getIt(), getIt()));
    getIt
        .registerFactory(() => PeriodsBloc(getIt(), getIt(), getIt(), getIt()));
    getIt.registerFactory(() =>
        TypePerfurationsBloc(getIt(), getIt(), getIt(), getIt(), getIt()));
    getIt.registerFactory(
        () => ClientBloc(getIt(), getIt(), getIt(), getIt(), getIt(), getIt()));
    getIt.registerFactory(() => HomeBloc(getIt(), getIt()));
    getIt.registerFactory(() => RegisterBloc(getIt()));
    getIt.registerFactory(() => LoginBloc(getIt(), getIt()));
    getIt.registerFactory(() => SplashBloc(getIt(), getIt()));
    getIt.registerFactory(() => PendingBloc(getIt(), getIt()));
  }
}
