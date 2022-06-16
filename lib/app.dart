import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:quotes_app/config/routes/app_router.dart';
import 'package:quotes_app/config/themes/app_theme.dart';
import 'package:quotes_app/core/locale/app_localizations_setup.dart';
import 'package:quotes_app/features/splash/presentation/cubit/language_cubit.dart';
import 'package:quotes_app/injector.dart';

class QuotesApp extends StatelessWidget {
  const QuotesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LanguageCubit>(
            create: (context) => getIt<LanguageCubit>()),
      ],
      child: BlocBuilder<LanguageCubit, LanguageState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: appTheme(),
            initialRoute: Routes.splashRoute,
            onGenerateRoute: RouteGenerator.getRoute,
            locale: state.locale,
            supportedLocales: AppLocalizationsSetup.supportedLocales,
            localeResolutionCallback:
                AppLocalizationsSetup.localeResolutionCallback,
            localizationsDelegates:
                AppLocalizationsSetup.localizationsDelegates,
          );
        },
      ),
    );
  }
}
