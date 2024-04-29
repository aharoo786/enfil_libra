import 'package:enfil_libre/data/models/habit_module/get_catergories_model.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../UI/values/constants.dart';
import '../../UI/widgets/toasts.dart';
import '../../data/GetServices/CheckConnectionService.dart';
import '../../data/models/get_user_profile.dart';
import '../../data/repos/habit_repo/home_repo.dart';

class HabitController extends GetxController implements GetxService {
  SharedPreferences sharedPreferences;
  HabitRepo habitRepo;

  HabitController({required this.sharedPreferences, required this.habitRepo});

  CheckConnectionService connectionService = CheckConnectionService();

  ///variables
  var isCategoriesLoad = false.obs;
  var selectedFrequency = 0.obs;
  var selectedFrequencyDay = 0.obs;
  var selectedHabitColor = 0.obs;
  var selectedSlot = 0.obs;


  ///Models
  CategoriesModel? categoriesModel;

  getCategoriesScreen() async {
    isCategoriesLoad.value = false;

    await connectionService.checkConnection().then((internet) async {
      if (!internet) {
        CustomToast.noInternetToast();
      } else {
        await habitRepo
            .getCategoriesRepo(
                accessToken:
                    sharedPreferences.getString(Constants.accessToken) ?? "")
            .then((response) async {
          if (response.statusCode == 200) {
            if (response.body["status"] == Constants.failure) {
              CustomToast.failToast(msg: response.body["message"]);
            } else if (response.body["status"] == Constants.success) {
              CategoriesModel model = CategoriesModel.fromJson(response.body);
              if (model.status == Constants.success) {
                categoriesModel = model;
                isCategoriesLoad.value = true;
              }
            } else {
              CustomToast.failToast(
                  msg: "Some Error has occurred, Try Again Later");
            }
          } else {
            CustomToast.failToast(msg: response.body["message"]);
          }
        });
      }
    });
  }

}
