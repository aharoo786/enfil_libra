import 'package:enfil_libre/UI/habit_module/select_habit_slot_screen.dart';
import 'package:enfil_libre/UI/habit_module/widgets/habit_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../values/my_colors.dart';
import '../widgets/app_bar_widget.dart';

class SelectSubHat extends StatelessWidget {
  SelectSubHat({super.key});

  final List<String> catHab = [
    "100 Pushups",
    "2 km running",
    "Weight lifting",
    "Legs exercise",

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
              "Exercise > Choose sub category",
              style: textTheme.headlineLarge!.copyWith(
                  fontSize: 20.sp,
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
                      text: catHab[index],
                      onTap: () {
                        Get.to(()=>SelectHabitSlotScreen());
                      },
                      showContainer: false,
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
