import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../controllers/habit_controller/habit_controller.dart';
import '../../habit_module/create_new_habit.dart';
import '../../values/my_colors.dart';
import '../../widgets/custom_button.dart';
import '../widgets/custom_progress_widget.dart';

class MyRoutinesScreen extends StatelessWidget {
  const MyRoutinesScreen({super.key});

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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 40.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'My Routines',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20.sp,
                                  color: MyColors.buttonColor),
                            ),
                            CustomButton(
                              text: "+ Create a habit",
                              width: 150.w,
                              height: 30.h,
                              fontSize: 14.sp,
                              onPressed: () {
                                Get.find<HabitController>()
                                    .getCategoriesScreen();
                                Get.to(() => CreateNewHabit());
                              },
                              color: Colors.white,
                              textColor: MyColors.buttonColor,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Expanded(
                        child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            // shrinkWrap: true,
                            itemBuilder: (context, index) =>
                                const CustomProgressWidget(),
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 16.h,
                                ),
                            itemCount: 8),
                      )
                    ],
                  )))
        ],
      ),
    );
  }
}
