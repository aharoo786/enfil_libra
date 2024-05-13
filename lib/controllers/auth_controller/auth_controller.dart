import 'dart:convert';
import 'dart:io';

import 'package:enfil_libre/UI/dashboard_module/dashboard_screen/dashboard_screen.dart';
import 'package:enfil_libre/UI/widgets/otp_bottom_sheet_widget.dart';
import 'package:enfil_libre/data/models/get_user_profile.dart';
import 'package:enfil_libre/data/models/user_model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../UI/auth_module/login/login.dart';
import '../../UI/values/constants.dart';
import '../../UI/widgets/toasts.dart';
import '../../data/GetServices/CheckConnectionService.dart';
import '../../data/repos/auth_repo/auth_repo.dart';
import '../../helper/notification_services.dart';

class AuthController extends GetxController implements GetxService {
  SharedPreferences sharedPreferences;
  AuthRepo authRepo;
  NotificationServices notificationServices;
  AuthController({required this.sharedPreferences, required this.authRepo,required this.notificationServices});
  CheckConnectionService connectionService = CheckConnectionService();

  var isLoginPassObscure = true.obs;
  var bottomSheetStatus = 1.obs;

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

  ///Intiliazting variables
  final firebase_auth.FirebaseAuth _auth = firebase_auth.FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);

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

  socialLogin(String email, String name, String loginType) {
    Get.dialog(const Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    connectionService.checkConnection().then((value) async {
      if (!value) {
        Get.back();

        CustomToast.failToast(msg: "No internet Connection".tr);
        // Get.back();
      } else {
        await authRepo.socialLoginRepo(formData: {
          "email": email,
          "type": loginType,
          "name": name
        }).then((response) async {
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
                  }
                } else {
                  CustomToast.failToast(
                      msg: response.body["errors"]["message"] ??
                          "Some error occurred");
                }
              }
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
            }
          } else {
            CustomToast.failToast(msg: response.body["message"]);
          }
        });
      }
    });
  }

  Future<void> showEmailsDialog({bool isFromResortScreen = false}) async {
    // Get.dialog(Center(child: CircularProgressIndicator()),
    //     barrierDismissible: false);
    await connectionService.checkConnection().then((value) async {
      if (!value) {
        // Get.back();

        CustomToast.noInternetToast();
      } else {
        try {
          final GoogleSignInAccount? googleSignInAccount =
              await googleSignIn.signIn();
          if (googleSignInAccount != null) {
            // Get.back();
            final GoogleSignInAuthentication googleSignInAuthentication =
                await googleSignInAccount.authentication;
            //  signInUsingGoogle(googleSignInAuthentication.accessToken!);
            final firebase_auth.AuthCredential credential =
                firebase_auth.GoogleAuthProvider.credential(
              accessToken: googleSignInAuthentication.accessToken,
              idToken: googleSignInAuthentication.idToken,
            );

            final firebase_auth.UserCredential authResult =
                await _auth.signInWithCredential(credential);
            final firebase_auth.User? user = authResult.user;
            print("user $user");
            if (user != null) {
              socialLogin(user.email ?? "", user.displayName ?? "", "google");
            }
          }
        } catch (error) {
          //Get.back();
          print("Error during Google Sign-In: $error");
        }
      }
    });
  }

  void handleappleLogin() async {
    await connectionService.checkConnection().then((value) async {
      if (!value) {
        CustomToast.noInternetToast();
      } else {
        final appleAuthProvider = firebase_auth.AppleAuthProvider();
        appleAuthProvider.addScope("email");

        var authCredentials = await _auth.signInWithProvider(appleAuthProvider);
        final firebase_auth.User? user = authCredentials.user;
        print("User :   $user");
        if (user != null) {
          if (Platform.isIOS) {
            if (user.email == null) {
              if (user.providerData.isNotEmpty) {
                socialLogin(user.providerData[0].email ?? "",
                    user.displayName ?? "", "apple");
              } else {
                socialLogin(user.email ?? "", user.displayName ?? "", "apple");
              }
            } else {
              socialLogin(user.email ?? "", user.displayName ?? "", "apple");
            }
          } else {
            socialLogin(user.email ?? "", user.displayName ?? "", "apple");
          }
        } else {
          CustomToast.failToast(msg: "Something went wrong");
        }
      }
    });
  }

  Future<void> loginWithFacebook() async {
    try {

      final LoginResult result = await FacebookAuth.instance.login();

      // Check if the login was successful
      if (result.status == LoginStatus.success) {
        // Get the Facebook access token
        final AccessToken accessToken = result.accessToken!;
        final firebase_auth.AuthCredential credential =
            firebase_auth.FacebookAuthProvider.credential(accessToken.token);
        await _auth.signInWithCredential(credential);

      } else {
        print('Facebook Login Failed');
      }
    } catch (e) {
      print('Facebook Login Error: $e');
    }
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


  initializeFireBase() {
    notificationServices.requestNotificationPermission();
    notificationServices.forgroundMessage();
    notificationServices.firebaseInit();
    notificationServices.setupInteractMessage();
    notificationServices.isTokenRefresh();

    notificationServices.getDeviceToken();
    //print('device token ${localStorageMethods.getDvToken()}');
  }

  @override
  void onInit() {
    initializeFireBase();
    super.onInit();
  }
}
