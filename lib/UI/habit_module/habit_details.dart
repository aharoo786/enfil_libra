import 'package:enfil_libre/UI/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../data/models/get_user_habit/get_user_habit.dart';
import '../values/my_colors.dart';
import '../values/my_imgs.dart';

class HabitDetailsScreen extends StatelessWidget {
  const HabitDetailsScreen({super.key, required this.userHabit});
  final UserHabit userHabit;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: HelpingWidgets().appBarWidget(() {
        Get.back();
      }, text: "Habit Details", statusBarColor: Colors.white),
      body: Column(

        children: [
          SizedBox(
            height: 30.h,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            padding: EdgeInsets.all(12.h),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                border: Border(
                  left: BorderSide(
                    color: Colors.black,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 56.h,
                      width: 56.h,
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: MyColors.primary2)),
                      child: SvgPicture.asset(MyImgs.exercise),
                    ),
                    SizedBox(width: 12.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Exercise",
                          style: textTheme.headlineLarge!.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 20.sp,
                              color: MyColors.buttonColor),
                        ),
                        Text(
                          "12/4/204",
                          style: textTheme.headlineLarge!.copyWith(
                              fontWeight: FontWeight.w300,
                              fontSize: 14.sp,
                              color: MyColors.buttonColor),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                rowText(userHabit.name, "100", textTheme),
                rowText("Frequency", userHabit.frequency.capitalizeFirst!,
                    textTheme),
                rowText("Days", "100", textTheme),
                rowText("Time slot", userHabit.slot ?? "Morning", textTheme),
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  "Description",
                  style: textTheme.headlineLarge!.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 18.sp,
                      color: MyColors.buttonColor),
                ),
                SizedBox(
                  height: 7.h,
                ),
                Text(
                  '''Challange details is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s Challange details is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,''',
                  style: textTheme.headlineLarge!.copyWith(
                      fontWeight: FontWeight.w300,
                      fontSize: 14.sp,
                      color: MyColors.buttonColor),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  children: [
                   const Icon(Icons.access_time,color:MyColors.buttonColor),
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
              ],
            ),
          )
        ],
      ),
    );
  }

  rowText(String firstText, String secondText, TextTheme textTheme) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            firstText,
            style: textTheme.headlineLarge!.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
                color: MyColors.buttonColor),
          ),
          Text(
            secondText,
            style: textTheme.headlineLarge!.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 14.sp,
                color: MyColors.buttonColor),
          ),
        ],
      ),
    );
  }
}
