import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes_app/app.dart';
import 'package:quotes_app/bloc_observer.dart';
import 'package:quotes_app/injector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  BlocOverrides.runZoned(
    () {
      runApp(const QuotesApp());
    },
    blocObserver: MyBlocObserver(),
  );
}
