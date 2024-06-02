import 'package:enfil_libre/UI/dashboard_module/dashboard_screen/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../values/my_colors.dart';
import '../../values/my_imgs.dart';
import '../../widgets/custom_button.dart';

class CreateNewChallenge extends StatelessWidget {
  const CreateNewChallenge({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.splashColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 60.h,
                      ),
                      Text(
                        'Start Your first Challenge',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 32.sp,
                            color: MyColors.buttonColor),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Let\'s start your journey to personal growth by creating your first Challenge.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 20.sp,
                          ),
                        ),
                      ),
                      Spacer(),
                      SvgPicture.asset(MyImgs.createHabitVector),
                      SizedBox(
                        height: 60.h,
                      ),
                      CustomButton(
                        text: "+ Start new Challenge",
                        width: 220.w,
                        onPressed: () {
                          Get.offAll(()=>DashboardScreen(index: 1,));
                        },
                        color: Colors.white,
                        textColor: MyColors.buttonColor,
                      ),
                      SizedBox(
                        height: 60.h,
                      ),
                    ],
                  )))
        ],
      ),
    );
  }
}
