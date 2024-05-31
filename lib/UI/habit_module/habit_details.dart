import 'package:enfil_libre/UI/habit_module/widgets/bottom_sheets.dart';
import 'package:enfil_libre/UI/widgets/app_bar_widget.dart';
import 'package:enfil_libre/controllers/habit_controller/habit_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../data/models/get_user_habit/get_user_habit.dart';
import '../values/my_colors.dart';
import '../values/my_imgs.dart';

class HabitDetailsScreen extends StatelessWidget {
  HabitDetailsScreen({
    super.key,
    required this.color
  });
  String color;

  final HabitController habitController = Get.find();

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
                    color: HabitBottomSheets(). hexToColor(color), // Convert and use the color

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
            child: Obx(() {
              if (habitController.isHabitsDetailsLoad.value) {
                var userHabit = habitController.getUserHabitDetails!.data;
                return Column(
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
                              userHabit.category,
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
                    rowText(userHabit.subCategory, "100", textTheme),
                    rowText("Frequency", userHabit.frequency,
                        textTheme),
                    rowText("Days", "100", textTheme),
                    rowText("Time slot",userHabit.slot ??"Morning", textTheme),
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
                      userHabit.description,
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
                        const Icon(Icons.access_time,
                            color: MyColors.buttonColor),
                        SizedBox(
                          width: 8.w,
                        ),
                        Text(
                          '  ',
                          style: textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp,
                              color: MyColors.buttonColor),
                        ),
                      ],
                    ),
                  ],
                );
              } else {
                return Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 56,
                            width: 56,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey[400]!),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 20,
                                width: 150,
                                color: Colors.grey[400],
                              ),
                              const SizedBox(height: 4),
                              Container(
                                height: 16,
                                width: 100,
                                color: Colors.grey[400],
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const RowTextShimmer(),
                      const RowTextShimmer(),
                      const RowTextShimmer(),
                      const RowTextShimmer(),
                      const SizedBox(height: 15),
                      Container(
                        height: 20,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 7),
                      Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Icon(Icons.access_time, color: Colors.grey[400]),
                          const SizedBox(width: 8),
                          Container(
                            height: 16,
                            width: 100,
                            color: Colors.grey[400],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }
            }),
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

class RowTextShimmer extends StatelessWidget {
  const RowTextShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 16,
            width: 150,
            color: Colors.grey[400],
          ),
          Container(
            height: 16,
            width: 100,
            color: Colors.grey[400],
          ),
        ],
      ),
    );
  }
}
