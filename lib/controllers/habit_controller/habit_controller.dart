import 'package:enfil_libre/data/models/get_user_habit/get_user_habit.dart';
import 'package:enfil_libre/data/models/get_user_habit_details/get_user_habit_details.dart';
import 'package:enfil_libre/data/models/habit_module/get_catergories_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../UI/dashboard_module/dashboard_screen/dashboard_screen.dart';
import '../../UI/values/constants.dart';
import '../../UI/widgets/toasts.dart';
import '../../data/GetServices/CheckConnectionService.dart';
import '../../data/models/get_user_profile.dart';
import '../../data/repos/habit_repo/home_repo.dart';
import '../auth_controller/auth_controller.dart';

class HabitController extends GetxController implements GetxService {
  SharedPreferences sharedPreferences;
  HabitRepo habitRepo;

  HabitController({required this.sharedPreferences, required this.habitRepo});

  CheckConnectionService connectionService = CheckConnectionService();

  ///variables
  var isCategoriesLoad = false.obs;
  var isHabitsLoad = false.obs;
  var isHabitsDetailsLoad = false.obs;
  var selectedFrequency = 0.obs;
  var selectedFrequencyDay = 0.obs;
  var selectedHabitColor = 0.obs;
  var selectedSlot = 0.obs;
  String time = DateFormat('hh:mm a').format(DateTime.now());
  String reminderTime = DateFormat('hh:mm a').format(DateTime.now());
  var counterNumberIndex = 0;
  var counterTypeIndex = 0;
  var counterHourIndex = 0;
  var showReminder = true.obs;
  var showCounter = true.obs;
  var showMinutes = true.obs;

  ///Models
  CategoriesModel? categoriesModel;
  GetUserHabits? getUserHabitUser;
  GetUserHabitDetails? getUserHabitDetails;

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

  List<UserHabit> morningHabits = [];
  List<UserHabit> eveningHabits = [];
  List<UserHabit> nightHabits = [];
  List<UserHabit> evertTimeHabits = [];

  Future getUserHabits() async {
    isHabitsLoad.value = false;

    await connectionService.checkConnection().then((internet) async {
      if (!internet) {
        CustomToast.noInternetToast();
      } else {
        await habitRepo
            .getHabitsRepo(
                accessToken:
                    sharedPreferences.getString(Constants.accessToken) ?? "")
            .then((response) async {
          if (response.statusCode == 200) {
            if (response.body["status"] == Constants.failure) {
              CustomToast.failToast(msg: response.body["message"]);
            } else if (response.body["status"] == Constants.success) {
              GetUserHabits model = GetUserHabits.fromJson(response.body);
              if (model.status == Constants.success) {
                getUserHabitUser = model;
                nightHabits.clear();
                morningHabits.clear();
                evertTimeHabits.clear();
                eveningHabits.clear();
                for (var habit in getUserHabitUser!.data) {
                  if (habit.slot == "night") {
                    nightHabits.add(habit);
                  } else if (habit.slot == "evening") {
                    eveningHabits.add(habit);
                  } else if (habit.slot == "morning") {
                    morningHabits.add(habit);
                  } else {
                    evertTimeHabits.add(habit);
                  }
                }

                isHabitsLoad.value = true;
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

  getUserHabitDetailsFunc(String habitId) async {
    isHabitsDetailsLoad.value = false;

    await connectionService.checkConnection().then((internet) async {
      if (!internet) {
        CustomToast.noInternetToast();
      } else {
        await habitRepo
            .getHabitDetailsRepo(
                accessToken:
                    sharedPreferences.getString(Constants.accessToken) ?? "",
                habitId: habitId)
            .then((response) async {
          if (response.statusCode == 200) {
            if (response.body["status"] == Constants.failure) {
              CustomToast.failToast(msg: response.body["message"]);
            } else if (response.body["status"] == Constants.success) {
              GetUserHabitDetails model =
                  GetUserHabitDetails.fromJson(response.body);
              if (model.status == Constants.success) {
                getUserHabitDetails = model;
                isHabitsDetailsLoad.value = true;
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

  DateTime now = DateTime.now();
  DateTime firstDayOfMonth =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime lastDayOfMonth =
      DateTime(DateTime.now().year, DateTime.now().month + 1, 0);
  List<String> range = [
    DateFormat("dd-MM-yyyy").format(DateTime.now()),
    DateFormat("dd-MM-yyyy").format(DateTime.now())
  ];
  List<DateTime> initialRange = [DateTime.now(), DateTime.now()];

  crateHabit(
      {required String subCatName,
      required String color,
      required String frequency,
      required String slot,
      String? reminder,
      required String subCatId,
      required String? counterText}) {
    Get.dialog(const Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    connectionService.checkConnection().then((value) async {
      if (!value) {
        Get.back();

        CustomToast.failToast(msg: "No internet Connection".tr);
        // Get.back();
      } else {
        await habitRepo.createHabitRepo(
            formData: {
              "name": subCatName,
              "color": color,
              "frequency": frequency.toLowerCase(),
              "slot": slot.toLowerCase(),
              "reminder": reminder,
              "counter": counterText,
              "start_date": range[0],
              "end_date": range[1],
              "time": showMinutes.value ? time : "null",
              "sub_category_id": subCatId
            },
            accessToken: sharedPreferences.getString(Constants.accessToken) ??
                "").then((response) async {
          Get.back();
          Get.log("login api response :${response.body}");

          if (response.statusCode == 200) {
            //   Get.back();
            if (response.body["status"] == Constants.failure) {
              CustomToast.failToast(msg: response.body["message"]);
            } else if (response.body["status"] == Constants.success) {
              CustomToast.successToast(msg: response.body["message"]);

              Get.offAll(() => DashboardScreen(
                    index: 2,
                    fromHabit: true,
                  ));
              getUserHabits();
            }
          } else {
            CustomToast.failToast(msg: response.body["message"]);
          }
        });
      }
    });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getUserHabits();
    super.onInit();
  }
}
