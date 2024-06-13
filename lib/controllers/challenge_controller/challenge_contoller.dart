import 'package:enfil_libre/UI/challenge_module/start_challege/start_challege_screen.dart';
import 'package:enfil_libre/UI/dashboard_module/dashboard_screen/dashboard_screen.dart';
import 'package:enfil_libre/controllers/home_controller/home_controller.dart';
import 'package:enfil_libre/data/models/get_user_challenges/get_user_challenges.dart';
import 'package:enfil_libre/data/models/user_challenge_history/user_challenge_history.dart';
import 'package:enfil_libre/data/repos/challenge_repo/challenge_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../UI/values/constants.dart';
import '../../UI/widgets/toasts.dart';
import '../../data/GetServices/CheckConnectionService.dart';
import '../../data/models/get_challenges_model/get_challenges_model.dart';

class ChallengeController extends GetxController implements GetxService {
  SharedPreferences sharedPreferences;
  ChallengeRepo challengeRepo;

  ChallengeController(
      {required this.sharedPreferences, required this.challengeRepo});

  CheckConnectionService connectionService = CheckConnectionService();

  ///variables
  var isChallengesLoad = false.obs;
  var isUserChallenges = false.obs;
  var isUserChallengeHistoryLoad = false.obs;

  ///Models
  GetChallengesModel? challengesModel;
  GetUserChallenges? getUserChallenges;
  UserChallengeHistory? userChallengeHistory;

  Future getChallengesScreen() async {
    isChallengesLoad.value = false;
    await connectionService.checkConnection().then((internet) async {
      if (!internet) {
        CustomToast.noInternetToast();
      } else {
        await challengeRepo
            .getChallengesRepo(
                accessToken:
                    sharedPreferences.getString(Constants.accessToken) ?? "")
            .then((response) async {
          if (response.statusCode == 200) {
            if (response.body["status"] == Constants.failure) {
              CustomToast.failToast(msg: response.body["message"]);
            } else if (response.body["status"] == Constants.success) {
              GetChallengesModel model =
                  GetChallengesModel.fromJson(response.body);
              if (model.status == Constants.success) {
                challengesModel = model;
                isChallengesLoad.value = true;
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

 Future  getUserChallengeHistory(String id) async {
    isUserChallengeHistoryLoad.value = false;
    await connectionService.checkConnection().then((internet) async {
      if (!internet) {
        CustomToast.noInternetToast();
      } else {
        await challengeRepo
            .getChallengeHistoryRepo(
                accessToken:
                    sharedPreferences.getString(Constants.accessToken) ?? "",
                id: id)
            .then((response) async {
          if (response.statusCode == 200) {
            if (response.body["status"] == Constants.failure) {
              CustomToast.failToast(msg: response.body["message"]);
            } else if (response.body["status"] == Constants.success) {
              UserChallengeHistory model =
                  UserChallengeHistory.fromJson(response.body);
              if (model.status == Constants.success) {
                userChallengeHistory = model;
                isUserChallengeHistoryLoad.value = true;
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

  getUserChallengeCheckIn(String id) async {
    await connectionService.checkConnection().then((internet) async {
      if (!internet) {
        CustomToast.noInternetToast();
      } else {
        Get.dialog(const Center(child: CircularProgressIndicator()),
            barrierDismissible: false);
        await challengeRepo
            .getChallengeCheckIn(
                accessToken:
                    sharedPreferences.getString(Constants.accessToken) ?? "",
                id: id)
            .then((response) async {
          Get.back();
          if (response.statusCode == 200) {
            if (response.body["status"] == Constants.failure) {
              CustomToast.failToast(msg: response.body["message"]);
            } else if (response.body["status"] == Constants.success) {
              CustomToast.successToast(
                  msg: response.body["message"] ??
                      "Challenge updated successfully");

              Future.wait([getChallengesScreen(), getUserChallengesFunc(),getUserChallengeHistory(id)]);
              Get.back();
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

  List<Record> pendingList = [];
  List<Record> inProgress = [];
  List<Record> finishedList = [];

  Future getUserChallengesFunc() async {
    isUserChallenges.value = false;
    await connectionService.checkConnection().then((internet) async {
      if (!internet) {
        CustomToast.noInternetToast();
      } else {
        await challengeRepo
            .getUserChallengesRepo(
                accessToken:
                    sharedPreferences.getString(Constants.accessToken) ?? "")
            .then((response) async {
          if (response.statusCode == 200) {
            if (response.body["status"] == Constants.failure) {
              CustomToast.failToast(msg: response.body["message"]);
            } else if (response.body["status"] == Constants.success) {
              GetUserChallenges model =
                  GetUserChallenges.fromJson(response.body);
              if (model.status == Constants.success) {
                getUserChallenges = model;
                inProgress.clear();
                finishedList.clear();
                pendingList.clear();
                isUserChallenges.value = true;
                if (getUserChallenges!.data.record != null) {
                  for (var element in getUserChallenges!.data.record!) {
                    if (element.status == Constants.process) {
                      inProgress.add(element);
                    } else if (element.status == Constants.completed) {
                      finishedList.add(element);
                    } else {
                      pendingList.add(element);
                    }
                  }
                }
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

  addChallenge(String id, Challenges? challenges) {
    Get.dialog(const Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    connectionService.checkConnection().then((value) async {
      if (!value) {
        Get.back();

        CustomToast.failToast(msg: "No internet Connection".tr);
        // Get.back();
      } else {
        await challengeRepo.addUserChallengeRepo(
            formData: {"challenge_id": id},
            accessToken: sharedPreferences.getString(Constants.accessToken) ??
                "").then((response) async {
          Get.back();

          if (response.statusCode == 200) {
            //   Get.back();
            if (response.body["status"] == Constants.failure) {
              CustomToast.failToast(msg: response.body["message"]);
            } else if (response.body["status"] == Constants.success) {
              Get.back();
              if (challenges != null) {
                Get.offAll(() => DashboardScreen(
                      index: 1,
                      myChallengeTabIndex: 1,
                    ));
              }
              CustomToast.successToast(msg: response.body["message"]);
              Future.wait([getUserChallengesFunc(), getChallengesScreen()]);
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
    getChallengesScreen();
    getUserChallengesFunc();

    super.onInit();
  }
}
