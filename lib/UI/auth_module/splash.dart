import 'dart:async';
import 'package:enfil_libre/UI/auth_module/onboarding/welcom_screen.dart';
import 'package:enfil_libre/UI/values/constants.dart';
import 'package:enfil_libre/controllers/auth_controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../values/my_colors.dart';
import '../values/my_imgs.dart';
import 'onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {


    WidgetsFlutterBinding.ensureInitialized();

    WidgetsBinding.instance.addObserver(this);
    AuthController authController = Get.find();
    Timer(const Duration(seconds: 2), () async {
      if (authController.sharedPreferences.getBool("isFirstTime") == null) {
        authController.sharedPreferences.setBool("isFirstTime", false);
        Get.offAll(() => const WalkThroughScreen());
      } else {
        if (authController.sharedPreferences.getString(Constants.accessToken) ==
            null) {
          Get.offAll(() => const WelcomeScreen());
        } else {
          authController.sessionCheck();
        }
      }
    });
    super.initState();
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
