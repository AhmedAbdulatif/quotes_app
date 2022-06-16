import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:quotes_app/core/api/api_client.dart';
import 'package:quotes_app/core/api/app_interceptor.dart';
import 'package:quotes_app/core/api/dio_consumer.dart';
import 'package:quotes_app/core/network/network_info.dart';
import 'package:quotes_app/core/network/network_info_imp.dart';
import 'package:quotes_app/features/quotes/data/datasources/local_data_source.dart';
import 'package:quotes_app/features/quotes/data/datasources/remote_data_source.dart';
import 'package:quotes_app/features/quotes/data/repositories/quote_repository_imp.dart';
import 'package:quotes_app/features/quotes/domain/repositories/quote_repository.dart';
import 'package:quotes_app/features/quotes/domain/usecases/random_quote_usecase.dart';
import 'package:quotes_app/features/quotes/presentation/cubit/quotes_cubit.dart';
import 'package:quotes_app/features/splash/data/datasources/lang_local_data_source.dart';
import 'package:quotes_app/features/splash/data/repositories/lang_repository_impl.dart';
import 'package:quotes_app/features/splash/domain/repositories/lang_repository.dart';
import 'package:quotes_app/features/splash/domain/usecases/change_language.dart';
import 'package:quotes_app/features/splash/domain/usecases/get_saved_language.dart';
import 'package:quotes_app/features/splash/presentation/cubit/language_cubit.dart';

final getIt = GetIt.instance;
Future<void> init() async {
  /// features
  // blocs
  getIt.registerFactory<QuotesCubit>(() => QuotesCubit(getIt()));
  getIt.registerFactory<LanguageCubit>(() => LanguageCubit(
      changeLanguageUseCase: getIt<ChangeLanguageUseCase>(),
      getLanguageUseCase: getIt<GetLanguageUseCase>()));

  // usecases
  getIt.registerLazySingleton<RandomQuoteUsecase>(
      () => RandomQuoteUsecase(getIt()));
  getIt.registerLazySingleton<ChangeLanguageUseCase>(
      () => ChangeLanguageUseCase(getIt()));
  getIt.registerLazySingleton<GetLanguageUseCase>(
      () => GetLanguageUseCase(getIt()));

  // repository
  getIt.registerLazySingleton<QuoteRepository>(
      () => QuoteRepositoryImpl(getIt(), getIt(), getIt()));

  getIt.registerLazySingleton<LanuageRepository>(
      () => LangRepositoryImpl(getIt<LangLocalDataSource>()));

  // datasources
  getIt.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(getIt()));
  getIt.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImp(getIt()));
  getIt.registerLazySingleton<LangLocalDataSource>(
      () => LangLocalDataSourceImpl(getIt<SharedPreferences>()));

  /// core
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImp(getIt()));
  getIt.registerLazySingleton<ApiClient>(() => DioConsumer(dio: getIt()));

  /// external
  final sharedPrefrences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPrefrences);
  getIt.registerLazySingleton(() => AppInterceptor());
  getIt.registerLazySingleton(() => LogInterceptor(
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
        error: true,
      ));
  getIt.registerLazySingleton(() => http.Client());
  getIt.registerLazySingleton(() => InternetConnectionChecker());
  getIt.registerLazySingleton(() => Dio());
}
