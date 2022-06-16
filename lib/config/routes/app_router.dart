import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes_app/core/utils/app_strings.dart';
import 'package:quotes_app/features/quotes/presentation/cubit/quotes_cubit.dart';
import 'package:quotes_app/features/quotes/presentation/screens/quotes_screen.dart';
import 'package:quotes_app/features/splash/presentation/screens/splash_screen.dart';
import 'package:quotes_app/injector.dart';

class Routes {
  static const String splashRoute = "/";
  static const String homeRoute = "/home";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.homeRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => QuotesCubit(getIt()),
                  child: const QuotesScreen(),
                ));
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text(
                  AppStrings.noRouteFound,
                ),
              ),
              body: const Center(
                child: Text(
                  AppStrings.noRouteFound,
                ),
              ),
            ));
  }
}
