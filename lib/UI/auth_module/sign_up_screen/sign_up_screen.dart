import 'package:enfil_libre/UI/dashboard_module/dashboard_screen/dashboard_screen.dart';
import 'package:enfil_libre/UI/widgets/toasts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../controllers/auth_controller/auth_controller.dart';
import '../../../helper/validators.dart';

import '../../values/dimens.dart';
import '../../values/my_colors.dart';
import '../../values/my_imgs.dart';
import '../../widgets/app_bar_widget.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/otp_bottom_sheet_widget.dart';
import '../../widgets/otp_fields.dart';
import '../email_verification/otp_screen.dart';
import '../login/login.dart';
import '../widgets/socialCard.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  GlobalKey<FormState> signUpformKey = GlobalKey();
  AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var mediaQuery = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: AppBar(
            elevation: 0,
            systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: MyColors.containerColor),
          ),
        ),
        // appBar: HelpingWidgets().appBarWidget(() {
        //   Get.back();
        // }),
        backgroundColor: MyColors.splashColor,
        body: Form(
          key: signUpformKey,
          child: Stack(
            children: [
              Image.asset(
                MyImgs.welcomeCard,
                fit: BoxFit.cover,
              ),
              Container(
                height: mediaQuery.height,
                decoration: const BoxDecoration(color: Colors.transparent),
                child: Column(
                  children: [
                    SizedBox(
                      height: 40.h,
                    ),
                    SizedBox(
                      height: 110.h,
                      child: Image.asset(
                        MyImgs.logo,
                        height: 110.h,
                      ),
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 40.w),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 4,
                                  blurRadius: 12,
                                  offset: const Offset(4, 4),
                                  color: Colors.black.withOpacity(0.28))
                            ],
                            color: Colors.white,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(32),
                                topRight: Radius.circular(32))),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: Dimens.size25.h,
                              ),
                              Text(
                                "Create new account",
                                style: textTheme.headlineLarge!.copyWith(
                                    color: MyColors.buttonColor,
                                    fontSize: 34.sp,
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height: Dimens.size40.h,
                              ),
                              LayoutBuilder(builder: (context, constraints) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomTextField(
                                      roundCorner: 16,
                                      width: constraints.maxWidth / 2.1,

                                      // controller: loginPassword,
                                      keyboardType: TextInputType.text,
                                      validator: (value) =>
                                          Validators.passwordValidator(value!),
                                      hintText: "First Name".tr,
                                      maxLength: 30,
                                      controller: authController.firstName,
                                      // suffixIcon: GestureDetector(
                                      //   child: Image.asset(
                                      //     Get.find<AuthController>().isLoginPassObscure.value
                                      //         ? MyImgs.eyeOff
                                      //         : MyImgs.eye_on,
                                      //     scale: 3.5,
                                      //   ),
                                      //   onTap: () {
                                      //     Get.find<AuthController>().isLoginPassObscure.value =
                                      //         !Get.find<AuthController>()
                                      //             .isLoginPassObscure
                                      //             .value;
                                      //   },
                                      // ),
                                      inputFormatter:
                                          FilteringTextInputFormatter
                                              .singleLineFormatter,
                                    ),
                                    CustomTextField(
                                      roundCorner: 16,
                                      width: constraints.maxWidth / 2.1,

                                      // controller: loginPassword,
                                      keyboardType: TextInputType.text,
                                      validator: (value) =>
                                          Validators.passwordValidator(value!),
                                      hintText: "Last Name".tr,
                                      maxLength: 30,
                                      controller: authController.lastName,

                                      // suffixIcon: GestureDetector(
                                      //   child: Image.asset(
                                      //     Get.find<AuthController>().isLoginPassObscure.value
                                      //         ? MyImgs.eyeOff
                                      //         : MyImgs.eye_on,
                                      //     scale: 3.5,
                                      //   ),
                                      //   onTap: () {
                                      //     Get.find<AuthController>().isLoginPassObscure.value =
                                      //         !Get.find<AuthController>()
                                      //             .isLoginPassObscure
                                      //             .value;
                                      //   },
                                      // ),
                                      inputFormatter:
                                          FilteringTextInputFormatter
                                              .singleLineFormatter,
                                    ),
                                  ],
                                );
                              }),
                              SizedBox(
                                height: Dimens.size25.h,
                              ),
                              CustomTextField(
                                roundCorner: 16,
                                width: mediaQuery.width,

                                // controller: loginPassword,
                                keyboardType: TextInputType.text,
                                validator: (value) =>
                                    Validators.passwordValidator(value!),
                                hintText: "Enter your email".tr,
                                maxLength: 30,
                                controller: authController.email,

                                // suffixIcon: GestureDetector(
                                //   child: Image.asset(
                                //     Get.find<AuthController>().isLoginPassObscure.value
                                //         ? MyImgs.eyeOff
                                //         : MyImgs.eye_on,
                                //     scale: 3.5,
                                //   ),
                                //   onTap: () {
                                //     Get.find<AuthController>().isLoginPassObscure.value =
                                //         !Get.find<AuthController>()
                                //             .isLoginPassObscure
                                //             .value;
                                //   },
                                // ),
                                inputFormatter: FilteringTextInputFormatter
                                    .singleLineFormatter,
                              ),
                              SizedBox(
                                height: Dimens.size25.h,
                              ),
                              Obx(
                                () => CustomTextField(
                                  roundCorner: 16,
                                  width: mediaQuery.width,
                                  obscureText:
                                      authController.isLoginPassObscure.value,
                                  // controller: loginPassword,
                                  keyboardType: TextInputType.text,
                                  validator: (value) =>
                                      Validators.passwordValidator(value!),
                                  hintText: "Create Password".tr,
                                  maxLength: 30,
                                  controller: authController.password,

                                  // suffixIcon: GestureDetector(
                                  //   child: Image.asset(
                                  //     Get.find<AuthController>().isLoginPassObscure.value
                                  //         ? MyImgs.eyeOff
                                  //         : MyImgs.eye_on,
                                  //     scale: 3.5,
                                  //   ),
                                  //   onTap: () {
                                  //     Get.find<AuthController>().isLoginPassObscure.value =
                                  //         !Get.find<AuthController>()
                                  //             .isLoginPassObscure
                                  //             .value;
                                  //   },
                                  // ),
                                  inputFormatter: FilteringTextInputFormatter
                                      .singleLineFormatter,
                                ),
                              ),
                              SizedBox(
                                height: Dimens.size15.h,
                              ),
                              Row(
                                children: [
                                  Container(
                                      width: 20.w,
                                      height: 20.w,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                            color: MyColors.buttonColor),
                                        // color: widget.value ? widget.fillColor : Colors.transparent, // Fill color based on checkbox value
                                      ),
                                      child: const Icon(Icons.check,
                                          size: 15,
                                          color: MyColors
                                              .buttonColor // Icon color when checkbox is checked
                                          )),
                                  SizedBox(
                                    width: 12.w,
                                  ),
                                  Text(
                                    "I agree to Terms & Conditions",
                                    style: textTheme.bodyMedium!.copyWith(
                                        color: Colors.black.withOpacity(0.6),
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 25.h,
                              ),
                              CustomButton(
                                  text: "Sign up",
                                  onPressed: () async {
                                    // Get.bottomSheet(otpBottomSheet(context, "abc"));

                                    if (authController.email.text.isEmpty ||
                                        authController.firstName.text.isEmpty ||
                                        authController.lastName.text.isEmpty ||
                                        authController.password.text.isEmpty) {
                                      CustomToast.failToast(
                                          msg:
                                              "Please provide all information");
                                    } else if (!authController
                                        .email.text.isEmail) {
                                      CustomToast.failToast(
                                          msg: "Please provide valid email");
                                    } else if (authController
                                            .password.text.length <
                                        8) {
                                      CustomToast.failToast(
                                          msg:
                                              "Password should be at least 8 letters");
                                    } else {
                                      authController.signUp(context);
                                    }
                                  }),
                              SizedBox(
                                height: 25.h,
                              ),
                              Center(
                                child: Text(
                                  "Or continue with",
                                  style: textTheme.bodyMedium!.copyWith(
                                      color: Colors.black.withOpacity(0.6),
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                               Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SocialCard(icon: MyImgs.googleIcon,onTap: (){authController.showEmailsDialog();},),
                                  SocialCard(icon: MyImgs.appleIcon,onTap: (){
                                    authController.handleappleLogin();

                                  },),
                                  SocialCard(icon: MyImgs.facebookIcon,onTap: (){},)
                                ],
                              ),
                              SizedBox(
                                height: 50.h,
                              ),
                              //const Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Already have an account?",
                                    style: textTheme.bodyMedium!.copyWith(
                                        //   fontFamily: "TiemposHeadline-Regular",
                                        color: MyColors.lightTextColor,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.off(() => const Login(),
                                          transition: Transition.leftToRight);
                                    },
                                    child: Text(
                                      "  Sign in".tr,
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          color: MyColors.primary2,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20.h,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
