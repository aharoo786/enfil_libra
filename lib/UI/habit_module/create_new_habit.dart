import 'package:enfil_libre/UI/habit_module/select_sub_hab.dart';
import 'package:enfil_libre/UI/habit_module/widgets/habit_widget.dart';
import 'package:enfil_libre/UI/values/my_colors.dart';
import 'package:enfil_libre/UI/widgets/app_bar_widget.dart';
import 'package:enfil_libre/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shimmer/shimmer.dart';

import '../../controllers/habit_controller/habit_controller.dart';
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

  HabitController habitController = Get.find();

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
            child: Obx(
              () => !habitController.isCategoriesLoad.value
                  ? Shimmer.fromColors(
                      baseColor: MyColors.shimmerBaseColor,
                      highlightColor: MyColors.shimmerHighlightColor,
                      child: ListView.separated(
                          padding: EdgeInsets.symmetric(
                              vertical: 20.h, horizontal: 20.w),
                          itemBuilder: (context, index) => Container(
                                height: 70.h,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 10.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                  border: Border.all(
                                      color: MyColors.buttonColor
                                          .withOpacity(0.12)),
                                  boxShadow: [
                                    BoxShadow(
                                        spreadRadius: 0,
                                        blurRadius: 16,
                                        offset: const Offset(0, 4),
                                        color: Colors.black.withOpacity(0.12))
                                  ],
                                ),
                              ),
                          separatorBuilder: (context, index) => SizedBox(
                                height: 12.h,
                              ),
                          itemCount: catHab.length),
                    )
                  : ListView.separated(
                      padding: EdgeInsets.symmetric(
                          vertical: 20.h, horizontal: 20.w),
                      itemBuilder: (context, index) {
                        var cat = habitController.categoriesModel!.data[index];

                        return HabitWidget(
                          text: cat.name,
                          icon: catHab[0]["icon"],
                          onTap: () {
                            Get.to(() => SelectSubHat(
                                  subCategories: cat.subCategories,
                                  category: cat,
                                ));
                          },
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(
                            height: 12.h,
                          ),
                      itemCount: habitController.categoriesModel!.data.length),
            ),
          )
        ],
      ),
    );
  }
}
