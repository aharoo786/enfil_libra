import 'package:enfil_libre/data/models/dashboard_module/get_all_notifications.dart';
import 'package:enfil_libre/data/models/dashboard_module/overview_score_model.dart';
import 'package:enfil_libre/data/models/get_user_habit/get_user_habit.dart';
import 'package:enfil_libre/data/models/get_user_habit_details/get_user_habit_details.dart';
import 'package:enfil_libre/data/models/habit_module/get_catergories_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../UI/dashboard_module/dashboard_screen/dashboard_screen.dart';
import '../../UI/values/constants.dart';
import '../../UI/widgets/toasts.dart';
import '../../data/GetServices/CheckConnectionService.dart';
import '../../data/models/dashboard_module/overview_model.dart';
import '../../data/models/dashboard_module/recent_task_model.dart';
import '../../data/models/dashboard_module/upcoming_rewards_model.dart';
import '../../data/models/dashboard_module/user_rewards_model.dart';
import '../../data/models/dashboard_module/user_streak_model.dart';
import '../../data/models/get_user_profile.dart';
import '../../data/repos/habit_repo/home_repo.dart';
import '../../data/repos/home_repo/home_repo.dart';
import '../auth_controller/auth_controller.dart';

class HomeController extends GetxController implements GetxService {
  SharedPreferences sharedPreferences;
  HomeRepo homeRepo;

  HomeController({required this.sharedPreferences, required this.homeRepo});

  CheckConnectionService connectionService = CheckConnectionService();

  var filterType = ["Week", "Month", "Year"].obs;
  var selectedFilterType = "Week".obs;

  var rewardValue = 0.obs;

  ///variables
  var isUsersRewardsLoad = false.obs;
  var isOverviewLoad = false.obs;
  var isRecentTaskLoad = false.obs;
  var isUpcomingRewardsLoad = false.obs;
  var isNotificationLoad = false.obs;
  var isUserStreakLoad = false.obs;
  var isOverviewScoreModelLoad = false.obs;

  List<Map<String, dynamic>> overViewDataList = [];

  ///Models
  UpcomingRewardsModel? upcomingRewardsModel;
  UserRewardsModel? userRewardsModel;
  RecentTasksModel? recentTasksModel;
  UserStreakModel? userStreakModel;
  OverviewModel? overviewModel;
  OverviewScoreModel? overviewScoreModel;
  GetAllNotifications? getAllNotifications;

  Future getUpcomingRewards() async {
    isUpcomingRewardsLoad.value = false;

    await connectionService.checkConnection().then((internet) async {
      if (!internet) {
        CustomToast.noInternetToast();
      } else {
        await homeRepo
            .getUpcomingRewardsRepo(
                accessToken:
                    sharedPreferences.getString(Constants.accessToken) ?? "")
            .then((response) async {
          if (response.statusCode == 200) {
            if (response.body["status"] == Constants.failure) {
              CustomToast.failToast(msg: response.body["message"]);
            } else if (response.body["status"] == Constants.success) {
              UpcomingRewardsModel model =
                  UpcomingRewardsModel.fromJson(response.body);
              if (model.status == Constants.success) {
                upcomingRewardsModel = model;
                isUpcomingRewardsLoad.value = true;
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

  Future getNotificationList() async {
    isNotificationLoad.value = false;

    await connectionService.checkConnection().then((internet) async {
      if (!internet) {
        CustomToast.noInternetToast();
      } else {
        await homeRepo
            .getNotificationRepo(
                accessToken:
                    sharedPreferences.getString(Constants.accessToken) ?? "")
            .then((response) async {
          if (response.statusCode == 200) {
            if (response.body["status"] == Constants.failure) {
              CustomToast.failToast(msg: response.body["message"]);
            } else if (response.body["status"] == Constants.success) {
              GetAllNotifications model =
                  GetAllNotifications.fromJson(response.body);
              if (model.status == Constants.success) {
                getAllNotifications = model;
                isNotificationLoad.value = true;
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

  Future readNotificationList(String id) async {
    await connectionService.checkConnection().then((internet) async {
      if (!internet) {
        CustomToast.noInternetToast();
      } else {
        await homeRepo
            .readNotificationRepo(
                accessToken:
                    sharedPreferences.getString(Constants.accessToken) ?? "",
                id: id)
            .then((response) async {
          if (response.statusCode == 200) {
            if (response.body["status"] == Constants.failure) {
              CustomToast.failToast(msg: response.body["message"]);
            } else if (response.body["status"] == Constants.success) {
              GetAllNotifications model =
                  GetAllNotifications.fromJson(response.body);
              if (model.status == Constants.success) {}
            } else {
              // CustomToast.failToast(
              //     msg: "Some Error has occurred, Try Again Later");
            }
          } else {
            // CustomToast.failToast(msg: response.body["message"]);
          }
        });
      }
    });
  }

  Future getOverview() async {
    isOverviewLoad.value = false;

    await connectionService.checkConnection().then((internet) async {
      if (!internet) {
        CustomToast.noInternetToast();
      } else {
        await homeRepo
            .getOverviewRepo(
                accessToken:
                    sharedPreferences.getString(Constants.accessToken) ?? "",
                filter: selectedFilterType.value.toLowerCase())
            .then((response) async {
          if (response.statusCode == 200) {
            if (response.body["status"] == Constants.failure) {
              CustomToast.failToast(msg: response.body["message"]);
            } else if (response.body["status"] == Constants.success) {
              OverviewModel model = OverviewModel.fromJson(response.body);
              if (model.status == Constants.success) {
                overviewModel = model;
                overViewDataList = [];

                overviewModel!.data.forEach((key, value) {
                  overViewDataList.add({"key": key, "value": value});
                });

                isOverviewLoad.value = true;
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

  Future getRecentTasks() async {
    isRecentTaskLoad.value = false;

    await connectionService.checkConnection().then((internet) async {
      if (!internet) {
        CustomToast.noInternetToast();
      } else {
        await homeRepo
            .getRecentTasksRepo(
                accessToken:
                    sharedPreferences.getString(Constants.accessToken) ?? "")
            .then((response) async {
          if (response.statusCode == 200) {
            if (response.body["status"] == Constants.failure) {
              CustomToast.failToast(msg: response.body["message"]);
            } else if (response.body["status"] == Constants.success) {
              RecentTasksModel model = RecentTasksModel.fromJson(response.body);
              if (model.status == Constants.success) {
                recentTasksModel = model;
                isRecentTaskLoad.value = true;
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

  Future getUsersRewards() async {
    isUsersRewardsLoad.value = false;

    await connectionService.checkConnection().then((internet) async {
      if (!internet) {
        CustomToast.noInternetToast();
      } else {
        await homeRepo
            .getUsersRewardsRepo(
                accessToken:
                    sharedPreferences.getString(Constants.accessToken) ?? "")
            .then((response) async {
          if (response.statusCode == 200) {
            if (response.body["status"] == Constants.failure) {
              CustomToast.failToast(msg: response.body["message"]);
            } else if (response.body["status"] == Constants.success) {
              UserRewardsModel model = UserRewardsModel.fromJson(response.body);
              if (model.status == Constants.success) {
                userRewardsModel = model;
                isUsersRewardsLoad.value = true;
                rewardValue.value = int.parse(userRewardsModel!.data.reward);
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

  Future getUserStreak() async {
    isUserStreakLoad.value = false;

    await connectionService.checkConnection().then((internet) async {
      if (!internet) {
        CustomToast.noInternetToast();
      } else {
        await homeRepo
            .getUserStreakRepo(
                accessToken:
                    sharedPreferences.getString(Constants.accessToken) ?? "")
            .then((response) async {
          if (response.statusCode == 200) {
            if (response.body["status"] == Constants.failure) {
              CustomToast.failToast(msg: response.body["message"]);
            } else if (response.body["status"] == Constants.success) {
              UserStreakModel model = UserStreakModel.fromJson(response.body);
              if (model.status == Constants.success) {
                userStreakModel = model;
                isUserStreakLoad.value = true;
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

  Future getOverviewScore() async {
    isOverviewScoreModelLoad.value = false;

    await connectionService.checkConnection().then((internet) async {
      if (!internet) {
        CustomToast.noInternetToast();
      } else {
        await homeRepo
            .getUserOverviewScore(
                accessToken:
                    sharedPreferences.getString(Constants.accessToken) ?? "")
            .then((response) async {
          if (response.statusCode == 200) {
            if (response.body["status"] == Constants.failure) {
              CustomToast.failToast(msg: response.body["message"]);
            } else if (response.body["status"] == Constants.success) {
              OverviewScoreModel model =
                  OverviewScoreModel.fromJson(response.body);
              if (model.status == Constants.success) {
                overviewScoreModel = model;
                isOverviewScoreModelLoad.value = true;
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

  @override
  void onInit() {
    Future.wait([
      getRecentTasks(),
      getUpcomingRewards(),
      getUsersRewards(),
      getOverview(),
      getUserStreak(),
      getOverviewScore()
    ]);
    super.onInit();
  }
}
