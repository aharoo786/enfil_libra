import 'package:enfil_libre/UI/auth_module/sign_up_screen/sign_up_screen.dart';
import 'package:enfil_libre/UI/dashboard_module/dashboard_screen/dashboard_screen.dart';
import 'package:enfil_libre/UI/values/my_imgs.dart';
import 'package:enfil_libre/controllers/auth_controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../helper/validators.dart';
import '../../values/dimens.dart';
import '../../values/my_colors.dart';
import '../../widgets/app_bar_widget.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/otp_fields.dart';
import '../../widgets/toasts.dart';
import '../widgets/socialCard.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    super.initState();
  }

  GlobalKey<FormState> loginformKey = GlobalKey();

  // TextEditingController countryCode =
  TextEditingController loginMobileNumber = TextEditingController();

  TextEditingController loginPassword = TextEditingController();
  AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
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
          key: loginformKey,
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
                                height: Dimens.size30.h,
                              ),
                              Text(
                                "Welcome",
                                style: textTheme.headlineLarge!.copyWith(
                                    color: MyColors.buttonColor,
                                    fontSize: 36.sp,
                                    fontWeight: FontWeight.w700),
                              ),
                              Text(
                                "Hey there! Continue your growth journey",
                                style: textTheme.bodyLarge!.copyWith(
                                    color: Colors.black.withOpacity(0.6),
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                height: Dimens.size40.h,
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
                                controller: authController.loginEmail,
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
                                  hintText: "Password".tr,
                                  maxLength: 30,
                                  controller: authController.loginPassword,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                          width: 20.w,
                                          height: 20.w,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
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
                                        "Remember me",
                                        style: textTheme.bodyMedium!.copyWith(
                                            fontSize: 16.sp,
                                            color:
                                                Colors.black.withOpacity(0.6),
                                            fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      authController.bottomSheetStatus.value =
                                          1;

                                      Get.bottomSheet(forgotBottomSheet());
                                    },
                                    child: Text(
                                      "Forgot password?",
                                      style: textTheme.bodyMedium!.copyWith(
                                          fontSize: 16.sp,
                                          color: Colors.black.withOpacity(0.6),
                                          fontWeight: FontWeight.w400),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 25.h,
                              ),
                              CustomButton(
                                  text: "Login",
                                  onPressed: () async {
                                    if (authController
                                            .loginEmail.text.isEmpty ||
                                        authController
                                            .loginPassword.text.isEmpty) {
                                      CustomToast.failToast(
                                          msg:
                                              "Please provide all necessary information");
                                    } else if (!authController
                                        .loginEmail.text.isEmail) {
                                      CustomToast.failToast(
                                          msg: "Please provide valid email");
                                    } else if (authController
                                            .loginPassword.text.length <
                                        8) {
                                      CustomToast.failToast(
                                          msg:
                                              "Password should be at least 8 letters");
                                    } else {
                                      authController.login(
                                          authController.loginEmail.text,
                                          authController.loginPassword.text,
                                          context);
                                    }
                                  }
                                  ),
                              SizedBox(
                                height: 25.h,
                              ),
                              Center(
                                child: Text(
                                  "Or continue with",
                                  style: textTheme.bodyMedium!.copyWith(
                                      fontSize: 16.sp,
                                      color: Colors.black.withOpacity(0.6),
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              SizedBox(
                                height: 24.h,
                              ),
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SocialCard(icon: MyImgs.googleIcon),
                                  SocialCard(icon: MyImgs.appleIcon),
                                  SocialCard(icon: MyImgs.facebookIcon)
                                ],
                              ),
                              SizedBox(
                                height: 70.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Don’t have an account?",
                                    style: textTheme.bodyMedium!.copyWith(
                                        //   fontFamily: "TiemposHeadline-Regular",
                                        color: MyColors.lightTextColor,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.off(() => SignUpScreen(),
                                          transition: Transition.leftToRight);
                                    },
                                    child: Text(
                                      "  Sign up".tr,
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          color: MyColors.primary2,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 30.h,
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

  forgotBottomSheet() {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
      child: SingleChildScrollView(
        child: Obx(
          () => Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 25.sp),
            child: Get.find<AuthController>().bottomSheetStatus.value == 1
                ?

                ///Email Widget

                Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: Dimens.size30.h,
                      ),
                      Text(
                        "Forgot password?",
                        style: textTheme.headlineLarge!.copyWith(
                            color: MyColors.buttonColor,
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: Dimens.size12.h,
                      ),
                      Text(
                        "Enter your email for the verification process.\nwe will send 4 digits code for your email.",
                        style: textTheme.bodyLarge!.copyWith(
                            fontSize: 16.sp,
                            color: Colors.black.withOpacity(0.6),
                            fontWeight: FontWeight.w300),
                      ),
                      SizedBox(
                        height: Dimens.size55.h,
                      ),
                      CustomTextField(
                        roundCorner: 16,
                        width: double.infinity,

                        // controller: loginPassword,
                        keyboardType: TextInputType.text,
                        validator: (value) =>
                            Validators.passwordValidator(value!),
                        hintText: "Enter your email".tr,
                        maxLength: 30,
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
                            FilteringTextInputFormatter.singleLineFormatter,
                      ),
                      SizedBox(
                        height: Dimens.size70.h,
                      ),
                      CustomButton(
                          text: "Continue",
                          onPressed: () async {
                            authController.bottomSheetStatus.value = 2;
                            // if (!loginformKey.currentState!.validate()) {
                            //   CustomToast.failToast(
                            //       msg: "Please provide all necessary information");
                            // } else {
                            // }
                          }),
                      SizedBox(
                        height: 30.h,
                      ),
                    ],
                  )
                :

                ///Otp Widget
                Get.find<AuthController>().bottomSheetStatus.value == 2
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: Dimens.size30.h,
                          ),
                          Text(
                            "Verify Code",
                            style: textTheme.headlineLarge!.copyWith(
                                color: MyColors.buttonColor,
                                fontSize: 28.sp,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: Dimens.size12.h,
                          ),
                          Text(
                            "Enter the 4-digit code we sent to\nyour email",
                            textAlign: TextAlign.center,
                            style: textTheme.bodyLarge!.copyWith(
                                fontSize: 16.sp,
                                color: Colors.black.withOpacity(0.6),
                                fontWeight: FontWeight.w300),
                          ),
                          SizedBox(
                            height: Dimens.size55.h,
                          ),
                          CustomPinEntryField(),
                          SizedBox(
                            height: Dimens.size70.h,
                          ),
                          CustomButton(
                              text: "Confirm",
                              onPressed: () async {
                                authController.bottomSheetStatus.value = 3;

                                // if (!loginformKey.currentState!.validate()) {
                                //   CustomToast.failToast(
                                //       msg: "Please provide all necessary information");
                                // } else {
                                // }
                              }),
                          SizedBox(
                            height: 30.h,
                          ),
                        ],
                      )
                    :

                    ///Reset Password Widget

                    Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: Dimens.size30.h,
                          ),
                          Text(
                            "Reset Password",
                            style: textTheme.headlineLarge!.copyWith(
                                color: MyColors.buttonColor,
                                fontSize: 28.sp,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: Dimens.size12.h,
                          ),
                          Text(
                            "Your new password must be different\nfrom previously used password.",
                            textAlign: TextAlign.center,
                            style: textTheme.bodyLarge!.copyWith(
                                fontSize: 16.sp,
                                color: Colors.black.withOpacity(0.6),
                                fontWeight: FontWeight.w300),
                          ),
                          SizedBox(
                            height: Dimens.size55.h,
                          ),
                          CustomTextField(
                            roundCorner: 16,
                            width: double.infinity,

                            // controller: loginPassword,
                            keyboardType: TextInputType.text,
                            validator: (value) =>
                                Validators.passwordValidator(value!),
                            hintText: "New Password".tr,
                            maxLength: 30,
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
                                FilteringTextInputFormatter.singleLineFormatter,
                          ),
                          SizedBox(
                            height: Dimens.size12.h,
                          ),
                          CustomTextField(
                            roundCorner: 16,
                            width: double.infinity,

                            // controller: loginPassword,
                            keyboardType: TextInputType.text,
                            validator: (value) =>
                                Validators.passwordValidator(value!),
                            hintText: "Confirm Password".tr,
                            maxLength: 30,
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
                                FilteringTextInputFormatter.singleLineFormatter,
                          ),
                          SizedBox(
                            height: Dimens.size70.h,
                          ),
                          CustomButton(
                              text: "Change Password",
                              onPressed: () async {
                                Get.offAll(() => DashboardScreen());

                                // if (!loginformKey.currentState!.validate()) {
                                //   CustomToast.failToast(
                                //       msg: "Please provide all necessary information");
                                // } else {
                                // }
                              }),
                          SizedBox(
                            height: 30.h,
                          ),
                        ],
                      ),
          ),
        ),
      ),
    );
  }
}
