import 'package:enfil_libre/UI/habit_module/select_sub_hab.dart';
import 'package:enfil_libre/UI/habit_module/widgets/habit_widget.dart';
import 'package:enfil_libre/UI/values/my_colors.dart';
import 'package:enfil_libre/UI/widgets/app_bar_widget.dart';
import 'package:enfil_libre/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../values/my_imgs.dart';

class CreateNewHabit extends StatelessWidget {
  CreateNewHabit({super.key});
  final List<Map<String, dynamic>> catHab = [
    {"name": "Exercise", "icon": MyImgs.exercise},
    {"name": "Eat Healthy", "icon": MyImgs.heart},
    {"name": "Sleep Early", "icon": MyImgs.sleep},
    {"name": "Drink Water", "icon": MyImgs.drinkWater},
    {"name": "Take a Bath", "icon": MyImgs.takeBath}
  ];

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: HelpingWidgets().appBarWidget(() {
        Get.back();
      }, text: "Create new habit"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.w),
            child: Text(
              "Choose your habit category",
              style: textTheme.headlineLarge!.copyWith(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: MyColors.buttonColor),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Expanded(
            child: ListView.separated(
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
                itemBuilder: (context, index) => HabitWidget(
                      text: catHab[index]["name"],
                      icon: catHab[index]["icon"],
                      onTap: () {
                        Get.to(()=>SelectSubHat());
                      },
                    ),
                separatorBuilder: (context, index) => SizedBox(
                      height: 12.h,
                    ),
                itemCount: catHab.length),
          )
        ],
      ),
    );
  }
}
