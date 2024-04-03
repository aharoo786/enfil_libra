import 'package:enfil_libre/UI/habit_module/create_new_habit.dart';
import 'package:enfil_libre/UI/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../values/my_colors.dart';
import '../../values/my_imgs.dart';
import '../widgets/custom_progress_widget.dart';

class CreateHabitScreen extends StatelessWidget {
  const CreateHabitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.splashColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20.h,
          ),
          Expanded(
              child: Container(
                  decoration: const BoxDecoration(
                      // boxShadow: [
                      //   BoxShadow(
                      //       spreadRadius: 4,
                      //       blurRadius: 4,
                      //       offset: const Offset(0, 0),
                      //       color: Colors.black.withOpacity(0.08))
                      // ],
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32),
                          topRight: Radius.circular(32))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 60.h,
                      ),
                      Text(
                        'Create your first Habit',
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
                          'Let\'s start your journey to personal growth by creating your first habit.',
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
                        text: "+ Create a habit",
                        width: 190.w,
                        onPressed: () {
                          Get.to(()=>CreateNewHabit());
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