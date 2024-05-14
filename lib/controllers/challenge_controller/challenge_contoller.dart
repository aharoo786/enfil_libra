import 'package:enfil_libre/data/models/get_user_challenges/get_user_challenges.dart';
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

  ///Models
  GetChallengesModel? challengesModel;
  GetUserChallenges? getUserChallenges;

  getChallengesScreen() async {
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

  List<UserChallenges> pendingList=[];
  List<UserChallenges> inProgress=[];
  List<UserChallenges> finishedList=[];

  getUserChallengesFunc() async {
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
                isUserChallenges.value = true;

                for (var element in getUserChallenges!.data) {
                  if(element.status=="process"){
                    inProgress.add(element);
                  }
                  else if(element.status=="finished"){
                    finishedList.add(element);
                  }
                  else{
                    pendingList.add(element);
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


  addChallenge(String id) {
    Get.dialog(Center(child: CircularProgressIndicator()),
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
              getUserChallengesFunc();
              CustomToast.successToast(msg: response.body["message"]);
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
