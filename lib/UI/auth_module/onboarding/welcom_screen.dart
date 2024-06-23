import 'package:enfil_libre/UI/auth_module/sign_up_screen/sign_up_screen.dart';
import 'package:enfil_libre/UI/values/my_colors.dart';
import 'package:enfil_libre/UI/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../login/login.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Scaffold(

      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 120.h,
            ),
            Text(
              "Welcome to Enfin Libre.",
              style:
                  textTheme.headlineLarge!.copyWith(fontWeight: FontWeight.w400,fontSize: 32.sp),
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              "Where\nChallenges\nMeet Transformation!",
              style: textTheme.headlineLarge!.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 48.sp,
                color: MyColors.buttonColor,
              ),
              textAlign: TextAlign.start,
            ),
            Spacer(),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: MyColors.containerColor),
             // margin: EdgeInsets.symmetric(horizontal: 20.w),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 42.h),
              child: Column(
                children: [
                  CustomButton(
                    text: "Sign up",
                    onPressed: () {
                      Get.to(()=>SignUpScreen());
                    },
                    fontSize: 24.sp,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomButton(
                    text: "Login",
                    onPressed: () {
                      Get.to(()=>Login());
                    },
                    fontSize: 24.sp,
                    textColor: Colors.black,
                    borderColor: Colors.black,
                    color: Colors.transparent,
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  // TextButton(
                  //     onPressed: () {},
                  //     child: Text(
                  //       "Continue as guest user",
                  //       style: textTheme.bodySmall!
                  //           .copyWith(fontWeight: FontWeight.w700,fontSize: 16.sp),
                  //     ))
                ],
              ),
            ),
            SizedBox(
              height: 60.h,
            )
          ],
        ),
      ),
    );
  }
}
