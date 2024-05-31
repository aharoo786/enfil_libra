import 'package:enfil_libre/UI/habit_module/habit_details.dart';
import 'package:enfil_libre/controllers/habit_controller/habit_controller.dart';
import 'package:enfil_libre/data/models/get_user_habit/get_user_habit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../habit_module/widgets/bottom_sheets.dart';
import '../../values/my_colors.dart';
import '../../values/my_imgs.dart';

class CustomRoutineWidget extends StatelessWidget {
  const CustomRoutineWidget({super.key, required this.userHabit});
  final UserHabit userHabit;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return GestureDetector(
      onTap: () {
        Get.find<HabitController>().getUserHabitDetailsFunc(userHabit.id.toString());
        Get.to(() => HabitDetailsScreen(color: userHabit.color,
            ));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        padding: EdgeInsets.all(12.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            border: Border(
              left: BorderSide(
                color:  HabitBottomSheets().hexToColor(userHabit.color), // Convert and use the color

              width: 4.0.w,
              ),
            ),
            boxShadow: [
              BoxShadow(
                  spreadRadius: 0,
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                  color: Colors.black.withOpacity(0.12))
            ]),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  userHabit.counter,
                  style: textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                      color: MyColors.buttonColor),
                ),
                Text(
                  '5/13/2024',
                  style: textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.w300,
                      fontSize: 16.sp,
                      color: MyColors.buttonColor),
                ),
                // SvgPicture.asset(MyImgs.rewardBig)
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                SvgPicture.asset(
                  MyImgs.calender,
                  height: 20.h,
                  colorFilter: ColorFilter.mode(
                      MyColors.buttonColor.withOpacity(0.4), BlendMode.srcIn),
                ),
                SizedBox(
                  width: 8.w,
                ),
                Text(
                  '07:30 PM - 09:30 PM ',
                  style: textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 12.sp,
                      color: MyColors.buttonColor),
                ),
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
          ],
        ),
      ),
    );
  }

}
