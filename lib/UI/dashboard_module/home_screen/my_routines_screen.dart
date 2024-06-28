import 'package:enfil_libre/UI/dashboard_module/widgets/my_routine_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../controllers/habit_controller/habit_controller.dart';
import '../../../data/models/get_user_habit/get_user_habit.dart';
import '../../habit_module/create_new_habit.dart';
import '../../values/my_colors.dart';
import '../../widgets/custom_button.dart';
import '../widgets/custom_progress_widget.dart';

class MyRoutinesScreen extends StatelessWidget {
  MyRoutinesScreen({super.key, required this.userHabits});
  final List<UserHabit> userHabits;

  final HabitController habitController = Get.find();
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

                            GestureDetector(
                              onTap: (){
                                Get.find<HabitController>()
                                    .getCategoriesScreen();
                                Get.to(() => CreateNewHabit());
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 30.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color:  MyColors.buttonColor)
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: Text("+ Create a habit",  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.sp,
                                    color: MyColors.buttonColor),),
                              ),
                            ),

                        
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: () async {
                            await habitController
                                .getUserHabits(); // Await the Future
                          },
                          color: MyColors.buttonColor,
                          child: SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: ListView.separated(
                              physics:
                                  const NeverScrollableScrollPhysics(), // Disable scrolling for the inner ListView
                              shrinkWrap: true,
                              itemBuilder: (context, index) =>
                                  CustomRoutineWidget(
                                userHabit: userHabits[index],
                              ),
                              separatorBuilder: (context, index) => SizedBox(
                                height: 16.h,
                              ),
                              itemCount: userHabits.length,
                            ),
                          ),
                        ),
                      )
                    ],
                  )))
        ],
      ),
    );
  }
}
