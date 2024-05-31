import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '/helper/get_di.dart' as di;
import 'UI/auth_module/splash.dart';
import 'UI/values/styles.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAwqgeDIJdDdlX8Vd3De7YjDThvPKlCCms",
          appId: "1:928695052505:android:7fceaf70e197e7b99076c8",
          messagingSenderId: "928695052505",
          projectId: "enfillibre"));
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      // Size(MediaQuery.of(context).size.width,
      //     MediaQuery.of(context).size.height),
      builder: (context, widget) => GetMaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,

        theme: Styles.appTheme,
        getPages: [
          GetPage<void>(page: () => SplashScreen(), name: '/'),
        ],
        // home: BuySubscriptions(),
      ),
    );
    // });
  }
}
