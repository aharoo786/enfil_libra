import 'package:enfil_libre/UI/widgets/toasts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller/auth_controller.dart';
import '../../helper/validators.dart';
import '../dashboard_module/dashboard_screen/dashboard_screen.dart';
import '../values/dimens.dart';
import '../values/my_colors.dart';
import 'custom_button.dart';
import 'custom_textfield.dart';
import 'otp_fields.dart';

otpBottomSheet(context, String email) {
  var theme = Theme.of(context);
  var textTheme = theme.textTheme;
  return ClipRRect(
    borderRadius: const BorderRadius.only(
      topLeft: Radius.circular(20.0),
      topRight: Radius.circular(20.0),
    ),
    child: SingleChildScrollView(
      child: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 25.sp),
          child:

              ///Otp Widget
              Column(
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
                "Enter the 6-digit code we sent to\nyour email",
                textAlign: TextAlign.center,
                style: textTheme.bodyLarge!.copyWith(
                    fontSize: 16.sp,
                    color: Colors.black.withOpacity(0.6),
                    fontWeight: FontWeight.w300),
              ),
              SizedBox(
                height: Dimens.size55.h,
              ),
              CustomPinEntryField(
                keyboard: TextInputType.text,
                fields: 6,
                onSubmit: (otp) {
                  Get.find<AuthController>().signUpOtp = otp;
                  print(
                      "entered opt : ${Get.find<AuthController>().signUpOtp}");
                },
              ),
              SizedBox(
                height: Dimens.size40.h,
              ),
              Text(
                "Didn't get the code?",
                style: textTheme.headlineLarge!
                    .copyWith(fontWeight: FontWeight.w400, fontSize: 16.sp),
              ),
              SizedBox(
                height: 8.h,
              ),
              GestureDetector(
                onTap: () {
                  Get.find<AuthController>().signUpOtp = "";
                  Get.find<AuthController>().resendOtp(email);
                },
                child: Text(
                  "Resend",
                  style: textTheme.headlineLarge!.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                      color: MyColors.buttonColor),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              CustomButton(
                  text: "Confirm",
                  onPressed: () async {
                    AuthController au = Get.find();
                    if (au.signUpOtp.length != 6) {
                      CustomToast.failToast(msg: "Please provide otp");
                    } else {
                      au.verifyEmail(otp: au.signUpOtp, email: email);
                    }
                  }),
              SizedBox(
                height: 30.h,
              ),
            ],
          )),
    ),
  );
}
