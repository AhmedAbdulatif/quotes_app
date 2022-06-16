import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quotes_app/config/routes/app_router.dart';
import 'package:quotes_app/core/utils/assets_manager.dart';
import 'package:quotes_app/core/utils/hex_color.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? timer;

  _startDelay() {
    timer = Timer(const Duration(seconds: 3), _goNext);
  }

  _goNext() {
    Navigator.pushReplacementNamed(context, Routes.homeRoute);
  }

  @override
  void initState() {
    _startDelay();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("37E2D5"),
      body: Center(
        child: Image.asset(AppImages.quotes),
      ),
    );
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }
}
