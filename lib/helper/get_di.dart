import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
///project Files
import '../controllers/auth_controller/auth_controller.dart';
import '../data/api_provider/api_provider.dart';
import '../data/repos/auth_repo/auth_repo.dart';

Future init() async {
  Get.log("int di");
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiProvider());
  Get.lazyPut(() => AuthRepo(apiProvider: Get.find()));

  Get.lazyPut(() => AuthController(sharedPreferences: sharedPreferences, authRepo: Get.find()));
}