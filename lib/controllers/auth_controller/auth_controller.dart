import 'dart:convert';

import 'package:enfil_libre/UI/dashboard_module/dashboard_screen/dashboard_screen.dart';
import 'package:enfil_libre/UI/widgets/otp_bottom_sheet_widget.dart';
import 'package:enfil_libre/data/models/get_user_profile.dart';
import 'package:enfil_libre/data/models/user_model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../UI/auth_module/email_verification/otp_screen.dart';
import '../../UI/auth_module/login/login.dart';
import '../../UI/values/constants.dart';
import '../../UI/widgets/toasts.dart';
import '../../data/GetServices/CheckConnectionService.dart';
import '../../data/models/sign_up_model/sign_up_model.dart';
import '../../data/repos/auth_repo/auth_repo.dart';

class AuthController extends GetxController implements GetxService {
  SharedPreferences sharedPreferences;
  AuthRepo authRepo;

  AuthController({required this.sharedPreferences, required this.authRepo});
  CheckConnectionService connectionService = CheckConnectionService();

  var isLoginPassObscure = true.obs;
  var bottomSheetStatus = 1.obs;

  var selectedFrequency = 999.obs;
  bool fromHabit = false;

  ///Image counter
  int i = 0;

  XFile? profileImage;

  ///gender List
  List<String> genderList = ["Male", "Female", "Others"];
  String? selectedGender;

  UserModel? userModel;

  ///Text Editing Controllers
  TextEditingController email = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController loginEmail = TextEditingController();
  TextEditingController loginPassword = TextEditingController();

  // checkSignUpValidation(){
  //   if(firstName.text.isEmpty){
  //     CustomToast.failToast(msg: "Please enter first name");
  //   }else if(lastName.text.isEmpty){
  //     CustomToast.failToast(msg: "Please enter last name");
  //   }else if(email.text.isEmpty){
  //     CustomToast.failToast(msg: "Please enter email");
  //   }else if(!GetUtils.isEmail(email.text)){
  //     CustomToast.failToast(msg: "Invalid email");
  //   }else if(password.text.isEmpty){
  //     CustomToast.failToast(msg: "Please enter password");
  //   }else {
  //     signUp();
  //   }
  //
  // }

  String signUpOtp = "";
  signUp(context) async {
    await connectionService.checkConnection().then((value) async {
      if (!value) {
        CustomToast.failToast(msg: "noInternetConnection".tr);
        Get.back();
      } else {
        Get.dialog(const Center(child: CircularProgressIndicator()),
            barrierDismissible: false);

        await authRepo.signUpUserRepo(formData: {
          "first_name": firstName.text,
          "last_name": lastName.text,
          "email": email.text,
          "password": password.text,
          "password_confirmation": password.text
        }).then((response) {
          Get.log("response 111   ${response.body}");
          Get.back();
          if (response.statusCode == 200) {
            // Get.back();
            if (response.body["status"] == Constants.failure) {
              CustomToast.failToast(msg: response.body["message"]);
            } else if (response.body["status"] == Constants.success) {
              if (response.body["data"]["next"] == "otp") {
                Get.bottomSheet(otpBottomSheet(context, email.text));
              }
            }
          } else {
            CustomToast.failToast(msg: response.body["message"]);
          }
        });
      }
    });
  }

  login(String email, String password, BuildContext context) {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    connectionService.checkConnection().then((value) async {
      if (!value) {
        Get.back();

        CustomToast.failToast(msg: "No internet Connection".tr);
        // Get.back();
      } else {
        await authRepo
            .loginRepo(formData: {"email": email, "password": password}).then(
                (response) async {
          Get.back();
          Get.log("login api response :${response.body}");

          if (response.statusCode == 200) {
            //   Get.back();
            if (response.body["status"] == Constants.failure) {
              if (response.body["errors"] != null) {
                if (response.body["errors"]["otp_verify"] != null) {
                  if (response.body["errors"]["otp_verify"] == false) {
                    CustomToast.failToast(
                        msg: response.body["errors"]["message"] ??
                            "Please verify your email");
                    Get.bottomSheet(otpBottomSheet(context, email));
                  }
                } else {
                  CustomToast.failToast(
                      msg: response.body["errors"]["message"] ??
                          "Some error occurred");
                }
              }
            } else if (response.body["status"] == Constants.success) {
              UserModel model = UserModel.fromJson(response.body);

              userModel = model;

              CustomToast.successToast(msg: response.body["message"]);
              sharedPreferences.setString(
                  Constants.userUid, model.data.user.id);
              sharedPreferences.setString(
                  Constants.email, model.data.user.email);

              sharedPreferences.setString(
                  Constants.accessToken, model.data.accessToken);
              sharedPreferences.setBool(Constants.login, true);
              Get.to(() => DashboardScreen());
            }
          } else {
            CustomToast.failToast(msg: response.body["message"]);
          }
        });
      }
    });
  }

  TextEditingController forgotPasswordController = TextEditingController();
  forgotPassword() {
    // Get.dialog(const Center(child: CircularProgressIndicator()),
    //     barrierDismissible: false);
    connectionService.checkConnection().then((value) async {
      if (!value) {
        Get.back();
        bottomSheetStatus.value = 1;
        CustomToast.noInternetToast();
        // Get.back();
      } else {
        bottomSheetStatus.value = 0;
        await authRepo.forgotPassword(formData: {
          "email": forgotPasswordController.text
        }).then((response) async {
          //Get.back();
          Get.log("login api response :${response.body}");

          if (response.statusCode == 200) {
            if (response.body["status"] == Constants.failure) {
              bottomSheetStatus.value = 1;

              CustomToast.failToast(msg: response.body["message"]);
            } else if (response.body["status"] == Constants.success) {
              bottomSheetStatus.value = 2;
              CustomToast.successToast(
                  msg: "Otp send successfully\nPlease check your email");
            }
          } else {
            bottomSheetStatus.value = 1;
            CustomToast.failToast(msg: response.body["message"]);
          }
        });
      }
    });
  }

  resendOtp(String email) {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    connectionService.checkConnection().then((value) async {
      if (!value) {
        Get.back();

        CustomToast.failToast(msg: "noInternetConnection".tr);
        // Get.back();
      } else {
        await authRepo
            .resendOtpRepo(formData: {"email": email}).then((response) async {
          Get.back();
          Get.log("login api response :${response.body}");

          if (response.statusCode == 200) {
            //   Get.back();
            if (response.body["status"] == Constants.failure) {
              CustomToast.failToast(msg: response.body["message"]);
            } else if (response.body["status"] == Constants.success) {
              CustomToast.successToast(
                  msg: "Otp send successfully\nPlease check your email");
            }
          } else {
            CustomToast.failToast(msg: response.body["message"]);
          }
        });
      }
    });
  }

  // updatePassword(String password) {
  //   Get.dialog(Center(child: CircularProgressIndicator()),
  //       barrierDismissible: false);
  //   connectionService.checkConnection().then((value) async {
  //     if (!value) {
  //       Get.back();
  //
  //       CustomToast.failToast(msg: "noInternetConnection".tr);
  //       // Get.back();
  //     } else {
  //       await authRepo.updatePasswordRepo(
  //           formData: {"password": password, "password_confirmation": password},
  //           accessToken: sharedPreferences.getString(Constants.accessToken) ??
  //               "").then((response) async {
  //         Get.back();
  //         Get.log("login api response :${response.body}");
  //
  //         if (response.statusCode == 200) {
  //           //   Get.back();
  //           if (response.body["status"] == Constants.failure) {
  //             Get.back();
  //             CustomToast.failToast(msg: response.body["message"]);
  //           } else if (response.body["status"] == Constants.success) {
  //             SignUpModel model = SignUpModel.fromJson(response.body);
  //             if (model.status == Constants.success) {
  //               CustomToast.successToast(msg: "Password updated successfully");
  //               sharedPreferences.setString(
  //                   Constants.userUid, model.data.user.id);
  //               sharedPreferences.setString(
  //                   Constants.email, model.data.user.email);
  //               sharedPreferences.setString(
  //                   Constants.fullName, model.data.user.name);
  //               sharedPreferences.setString(
  //                   Constants.accessToken, model.data.accessToken);
  //               sharedPreferences.setBool(Constants.login, true);
  //               Get.to(() => BottomBarScreen());
  //             }
  //           }
  //         } else {
  //           CustomToast.failToast(msg: response.body["message"]);
  //         }
  //       });
  //     }
  //   });
  // }

  clearLocalStorage() {
    sharedPreferences.clear();
    CustomToast.successToast(msg: "Log out successfully");
    Get.offAll(() => Login());
  }

  verifyEmail({
    required String otp,
    required String email,
  }) async {
    Get.dialog(const Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    connectionService.checkConnection().then((value) async {
      if (!value) {
        Get.back();
        CustomToast.failToast(msg: "noInternetConnection".tr);
      } else {
        await authRepo.verifyEmail(formData: {"otp": otp, "email": email}).then(
            (response) async {
          Get.back();
          if (response.statusCode == 200) {
            if (response.body["status"] == Constants.failure) {
              CustomToast.failToast(msg: response.body["message"]);
            } else if (response.body["status"] == Constants.success) {
              UserModel model = UserModel.fromJson(response.body);
              if (model.status == Constants.success) {
                CustomToast.successToast(msg: response.body["message"]);
                sharedPreferences.setString(
                    Constants.userUid, model.data.user.id);
                sharedPreferences.setString(
                    Constants.email, model.data.user.email);

                sharedPreferences.setString(
                    Constants.accessToken, model.data.accessToken);

                sharedPreferences.setBool(Constants.login, true);
                userModel = model;
                Get.to(() => DashboardScreen());
              }
            } else {
              CustomToast.failToast(
                  msg: "Some Error has occurred, Try Again Later");
            }
          }
        });
      }
    });
  }

  ///gettting user Data

  var isUserDataLoad = false.obs;
  TextEditingController updateFirstNameController = TextEditingController();
  TextEditingController updateLastNameController = TextEditingController();
  TextEditingController updateEmailController = TextEditingController();
  GetUserProfile? getUserProfile;

  getUserData() async {
    isUserDataLoad.value = false;

    await connectionService.checkConnection().then((internet) async {
      if (!internet) {
        CustomToast.noInternetToast();
      } else {
        await authRepo
            .getUserProfile(
                accessToken:
                    sharedPreferences.getString(Constants.accessToken) ?? "")
            .then((response) async {
          if (response.statusCode == 200) {
            if (response.body["status"] == Constants.failure) {
              CustomToast.failToast(msg: response.body["message"]);
            } else if (response.body["status"] == Constants.success) {
              GetUserProfile model = GetUserProfile.fromJson(response.body);
              if (model.status == Constants.success) {
                getUserProfile = model;
                isUserDataLoad.value = true;
                selectedGender = genderList[0];
                updateFirstNameController.text = model.data.firstName;
                updateLastNameController.text = model.data.lastName;
                updateEmailController.text = model.data.email;
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

  updateUser() {
    connectionService.checkConnection().then((value) async {
      if (!value) {
        CustomToast.noInternetToast();
        // Get.back();
      } else {
        Get.dialog(const Center(child: CircularProgressIndicator()),
            barrierDismissible: false);

        await authRepo.updateUser(
            accessToken:
                sharedPreferences.getString(Constants.accessToken) ?? "",
            map: {
              "image": profileImage == null ? null : profileImage!.path,
              "first_name": updateFirstNameController.text,
              "date_of_birth": "2000-01-25",
              "gender": selectedGender!.toLowerCase(),
              "last_name": updateLastNameController.text,
            }).then((response) async {
          Get.back();
          var body = jsonDecode(response.body);
          if (response.statusCode == 200) {
            print("respn  ${response.body}");

            if (body["status"] == Constants.failure) {
              CustomToast.failToast(msg: response.body["message"]);
            } else if (body["status"] == Constants.success) {
              var getUserProfile =
                  GetUserProfile.fromJson(jsonDecode(response.body));
              userModel!.data.user.firstName = getUserProfile.data.firstName;
              userModel!.data.user.lastName = getUserProfile.data.lastName;
              userModel!.data.user.image = getUserProfile.data.image;
              userModel!.data.user.gender = getUserProfile.data.gender;

              profileImage = null;
              update();

              Get.back();

              CustomToast.successToast(msg: "User updated successfully");
              getUserData();
            } else {
              CustomToast.failToast(
                  msg: "Some Error has occurred, Try Again Later");
            }
          } else {
            CustomToast.failToast(msg: body["message"]);
          }
        });
      }
    });
  }

  TextEditingController resetPasswordController = TextEditingController();
  TextEditingController resetPasswordConfirmController =
      TextEditingController();
  resetPasswordEmailVerify() async {
    Get.dialog(const Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    connectionService.checkConnection().then((value) async {
      if (!value) {
        Get.back();
        CustomToast.failToast(msg: "noInternetConnection".tr);
      } else {
        await authRepo.verifyEmailResetPassword(formData: {
          "otp": signUpOtp,
          "email": forgotPasswordController.text
        }).then((response) async {
          Get.back();
          if (response.statusCode == 200) {
            //   Get.back();
            if (response.body["status"] == Constants.failure) {
              CustomToast.failToast(msg: response.body["message"]);
            } else if (response.body["status"] == Constants.success) {
              UserModel model = UserModel.fromJson(response.body);

              userModel = model;

              CustomToast.successToast(msg: response.body["message"]);
              sharedPreferences.setString(
                  Constants.userUid, model.data.user.id);
              sharedPreferences.setString(
                  Constants.email, model.data.user.email);

              sharedPreferences.setString(
                  Constants.accessToken, model.data.accessToken);
              sharedPreferences.setBool(Constants.login, true);
              Get.to(() => DashboardScreen());
            }
          } else {
            CustomToast.failToast(msg: response.body["message"]);
          }
        });
      }
    });
  }
}
