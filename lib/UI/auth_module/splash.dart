import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../values/my_colors.dart';
import '../values/my_imgs.dart';
import 'onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();

    WidgetsFlutterBinding.ensureInitialized();

    WidgetsBinding.instance.addObserver(this);
    Timer(const Duration(seconds: 2), () async {
      Get.offAll(()=> const WalkThroughScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarIconBrightness:
          Brightness.dark, // this will change the brightness of the icons
      statusBarColor: MyColors.splashColor, // or any color you want
    ));

    return Scaffold(
        backgroundColor: MyColors.splashColor,
        body: Center(
          child: Image.asset(
            MyImgs.logo,
            scale: 3,
          ),
        ));
  }
}
