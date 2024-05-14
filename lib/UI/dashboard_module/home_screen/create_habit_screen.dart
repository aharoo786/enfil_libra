import 'package:enfil_libre/UI/dashboard_module/home_screen/my_routines_screen.dart';
import 'package:enfil_libre/UI/habit_module/create_new_habit.dart';
import 'package:enfil_libre/UI/widgets/custom_button.dart';
import 'package:enfil_libre/controllers/auth_controller/auth_controller.dart';
import 'package:enfil_libre/controllers/habit_controller/habit_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shimmer/shimmer.dart';

import '../../values/my_colors.dart';
import '../../values/my_imgs.dart';
import '../widgets/custom_progress_widget.dart';

class CreateHabitScreen extends StatelessWidget {
  CreateHabitScreen({super.key, this.fromHabit = false});
  final bool fromHabit;
  final HabitController habitController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (habitController.isHabitsLoad.value) {
        if (habitController.getUserHabitUser!.data.isEmpty) {
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
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
                                Get.find<HabitController>()
                                    .getCategoriesScreen();
                                Get.to(() => CreateNewHabit());
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
        } else {
          return MyRoutinesScreen(userHabits:habitController.getUserHabitUser!.data);
        }
      } else {
        return Shimmer.fromColors(
          baseColor: MyColors.shimmerBaseColor,
          highlightColor: MyColors.shimmerHighlightColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.w),
                    child: Text(
                      'My Routines',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20.sp,
                          color: MyColors.buttonColor),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Expanded(
                    child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        // shrinkWrap: true,
                        itemBuilder: (context, index) => Container(
                              color: MyColors.shimmerBaseColor,
                              height: 96.h,
                              margin: EdgeInsets.symmetric(horizontal: 20.w),
                            ),
                        separatorBuilder: (context, index) => SizedBox(
                              height: 16.h,
                            ),
                        itemCount: 8),
                  )
                ],
              ))
            ],
          ),
        );
      }
    });
  }
}
