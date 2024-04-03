import 'package:enfil_libre/UI/dashboard_module/dashboard_screen/dashboard_screen.dart';
import 'package:enfil_libre/UI/widgets/otp_bottom_sheet_widget.dart';
import 'package:enfil_libre/data/models/user_model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
          "last_name":  lastName.text,
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
                }
                else {
                  CustomToast.failToast(
                      msg: response.body["errors"]["message"] ?? "Some error occurred");
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

  forgotPassword(String email) {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    connectionService.checkConnection().then((value) async {
      if (!value) {
        Get.back();

        CustomToast.failToast(msg: "noInternetConnection".tr);
        // Get.back();
      } else {
        await authRepo
            .forgotPassword(formData: {"email": email}).then((response) async {
          Get.back();
          Get.log("login api response :${response.body}");

          if (response.statusCode == 200) {
            //   Get.back();
            if (response.body["status"] == Constants.failure) {
              CustomToast.failToast(msg: response.body["message"]);
            } else if (response.body["status"] == Constants.success) {
              // Get.to(() => OtpScreen(
              //       email: email,
              //       isFromReset: true,
              //     ));
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

  // resetPasswordEmailVerify({
  //   required String otp,
  //   required String email,
  // }) async {
  //   Get.dialog(const Center(child: CircularProgressIndicator()),
  //       barrierDismissible: false);
  //   connectionService.checkConnection().then((value) async {
  //     if (!value) {
  //       Get.back();
  //       CustomToast.failToast(msg: "noInternetConnection".tr);
  //     } else {
  //       await authRepo.verifyEmailResetPassword(
  //           formData: {"otp": otp, "email": email}).then((response) async {
  //         Get.back();
  //         if (response.statusCode == 200) {
  //           if (response.body["status"] == Constants.failure) {
  //             CustomToast.failToast(msg: response.body["message"]);
  //           } else if (response.body["status"] == Constants.success) {
  //             SignUpModel model = SignUpModel.fromJson(response.body);
  //             if (model.status == Constants.success) {
  //               CustomToast.successToast(msg: response.body["message"]);
  //               sharedPreferences.setString(
  //                   Constants.userUid, model.data.user.id);
  //               sharedPreferences.setString(
  //                   Constants.email, model.data.user.email);
  //               sharedPreferences.setString(
  //                   Constants.fullName, model.data.user.name);
  //               sharedPreferences.setString(
  //                   Constants.accessToken, model.data.accessToken);
  //               sharedPreferences.setBool(Constants.login, true);
  //               Get.to(() => ResetPassword());
  //             }
  //           } else {
  //             CustomToast.failToast(
  //                 msg: "Some Error has occured, Try Again Later");
  //           }
  //         }
  //       });
  //     }
  //   });
  // }
}
