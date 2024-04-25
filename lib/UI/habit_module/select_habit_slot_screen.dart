import 'package:enfil_libre/UI/dashboard_module/dashboard_screen/dashboard_screen.dart';
import 'package:enfil_libre/UI/values/my_imgs.dart';
import 'package:enfil_libre/UI/widgets/custom_button.dart';
import 'package:enfil_libre/controllers/auth_controller/auth_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../values/my_colors.dart';
import '../widgets/app_bar_widget.dart';

class SelectHabitSlotScreen extends StatelessWidget {
  SelectHabitSlotScreen({super.key});
  final List<Color> tempColors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    Colors.pink,
    Colors.indigo,
    Colors.amber,
  ];

  final List<String> frequencyText = ["Daily", "Weekly", "Monthly"];

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: HelpingWidgets().appBarWidget(() {
        Get.back();
      }, text: "Create new habit"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(
              height: 30.h,
            ),
            Container(
              height: 96.h,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                border:
                    Border.all(color: MyColors.buttonColor.withOpacity(0.12)),
                boxShadow: [
                  BoxShadow(
                      spreadRadius: 0,
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                      color: Colors.black.withOpacity(0.12))
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Select Color",
                    style: textTheme.headlineLarge!
                        .copyWith(fontWeight: FontWeight.w700, fontSize: 16.sp),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  SizedBox(
                    height: 36.h,
                    child: ListView.builder(
                        itemCount: tempColors.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (ctx, index) {
                          return Container(
                            height: 36.h,
                            width: 36.w,
                            margin: EdgeInsets.symmetric(horizontal: 6.w),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: tempColors[index]),
                          );
                        }),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              height: 156.h,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                border:
                    Border.all(color: MyColors.buttonColor.withOpacity(0.12)),
                boxShadow: [
                  BoxShadow(
                      spreadRadius: 0,
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                      color: Colors.black.withOpacity(0.12))
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Select Frequency",
                    style: textTheme.headlineLarge!
                        .copyWith(fontWeight: FontWeight.w700, fontSize: 16.sp),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  SizedBox(
                    height: 36.h,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => frequencyWidget(
                            textTheme, frequencyText[index], index),
                        separatorBuilder: (context, index) => SizedBox(
                              width: 16.w,
                            ),
                        itemCount: frequencyText.length),
                  ),

                  // Row(
                  //   //  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //   children: [
                  //     Container(
                  //       height: 36.h,
                  //       width: 77.w,
                  //       decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(20),
                  //           border:
                  //               Border.all(color: MyColors.black, width: 1)),
                  //       child: Center(
                  //         child: Text(
                  //           "Daily",
                  //           style: textTheme.headlineLarge!.copyWith(
                  //               fontWeight: FontWeight.w400, fontSize: 16.sp),
                  //         ),
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       width: 16.w,
                  //     ),
                  //     Container(
                  //       height: 36.h,
                  //       width: 92.w,
                  //       decoration: BoxDecoration(
                  //           color: MyColors.primary2,
                  //           borderRadius: BorderRadius.circular(20),
                  //           border: Border.all(
                  //               color: MyColors.primaryColor, width: 1)),
                  //       child: Center(
                  //         child: Text(
                  //           "Weekly",
                  //           style: textTheme.headlineLarge!.copyWith(
                  //               color: Colors.white,
                  //               fontWeight: FontWeight.w400,
                  //               fontSize: 16.sp),
                  //         ),
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       width: 16.w,
                  //     ),
                  //     Container(
                  //       height: 36.h,
                  //       width: 100.w,
                  //       decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(20),
                  //           border:
                  //               Border.all(color: MyColors.black, width: 1)),
                  //       child: Center(
                  //         child: Text(
                  //           "Monthly",
                  //           style: textTheme.headlineLarge!.copyWith(
                  //               fontWeight: FontWeight.w400, fontSize: 16.sp),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Container(
                    height: 36.h,
                    width: 145.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: MyColors.black, width: 1)),
                    child: Center(
                      child: Text(
                        "+More option",
                        style: textTheme.headlineLarge!.copyWith(
                            fontWeight: FontWeight.w400, fontSize: 16.sp),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              height: 156.h,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                border:
                    Border.all(color: MyColors.buttonColor.withOpacity(0.12)),
                boxShadow: [
                  BoxShadow(
                      spreadRadius: 0,
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                      color: Colors.black.withOpacity(0.12))
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Select Time Slot",
                    style: textTheme.headlineLarge!
                        .copyWith(fontWeight: FontWeight.w700, fontSize: 16.sp),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),

                  SizedBox(
                    height: 36.h,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => frequencyWidget(
                            textTheme, frequencyText[index], index),
                        separatorBuilder: (context, index) => SizedBox(
                              width: 16.w,
                            ),
                        itemCount: frequencyText.length),
                  ),

                  // Row(
                  //   //  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //   children: [
                  //     Container(
                  //       height: 36.h,
                  //       width: 102.w,
                  //       decoration: BoxDecoration(
                  //           color: MyColors.primary2,
                  //           borderRadius: BorderRadius.circular(20),
                  //           border: Border.all(
                  //               color: MyColors.primaryColor, width: 1)),
                  //       child: Center(
                  //         child: Text(
                  //           "Morning",
                  //           style: textTheme.headlineLarge!.copyWith(
                  //               color: Colors.white,
                  //               fontWeight: FontWeight.w400,
                  //               fontSize: 16.sp),
                  //         ),
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       width: 16.w,
                  //     ),
                  //     Container(
                  //       height: 36.h,
                  //       width: 100.w,
                  //       decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(20),
                  //           border:
                  //               Border.all(color: MyColors.black, width: 1)),
                  //       child: Center(
                  //         child: Text(
                  //           "Evening",
                  //           style: textTheme.headlineLarge!.copyWith(
                  //               fontWeight: FontWeight.w400, fontSize: 16.sp),
                  //         ),
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       width: 16.w,
                  //     ),
                  //     Container(
                  //       height: 36.h,
                  //       width: 81.w,
                  //       decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(20),
                  //           border:
                  //               Border.all(color: MyColors.black, width: 1)),
                  //       child: Center(
                  //         child: Text(
                  //           "Night",
                  //           style: textTheme.headlineLarge!.copyWith(
                  //               fontWeight: FontWeight.w400, fontSize: 16.sp),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Container(
                    height: 36.h,
                    width: 117.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: MyColors.black, width: 1)),
                    child: Center(
                      child: Text(
                        "Every time",
                        style: textTheme.headlineLarge!.copyWith(
                            fontWeight: FontWeight.w400, fontSize: 16.sp),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            CustomButton(
                text: "Create Habit",
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (BuildContext context) {
                      return Container(
                        height: 820.h,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12)),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20.h,
                            ),
                            Text(
                              'Create The Habit ',
                              style: textTheme.headlineLarge!.copyWith(
                                  fontSize: 32.sp, fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Text(
                              'More Option',
                              style: textTheme.headlineLarge!.copyWith(
                                  fontSize: 18.sp, fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: 35.h,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 40.w),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomButton(
                                        text: "Counter",
                                        onPressed: () {},
                                        color: MyColors.splashColor,
                                        borderColor: MyColors.splashColor,
                                        roundCorner: 8,
                                        width: 120.w,
                                        textColor: Colors.black,
                                      ),
                                      Row(
                                        children: [
                                          Switch(
                                            value: true,
                                            onChanged: (value) {},
                                            activeColor: MyColors.buttonColor,
                                          ),
                                          SizedBox(
                                            width: 20.w,
                                          ),
                                          SvgPicture.asset(MyImgs.info)
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  SizedBox(
                                    width: 284.w,
                                    height: 184.h,
                                    child: CupertinoTimerPicker(
                                        mode: CupertinoTimerPickerMode.hms,
                                        onTimerDurationChanged:
                                            (Duration duration) {}),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomButton(
                                        text: "Minute",
                                        onPressed: () {},
                                        color: MyColors.splashColor,
                                        borderColor: MyColors.splashColor,
                                        roundCorner: 8,
                                        width: 120.w,
                                        textColor: Colors.black,
                                      ),
                                      Row(
                                        children: [
                                          Switch(
                                            value: true,
                                            onChanged: (value) {},
                                            activeColor: MyColors.buttonColor,
                                          ),
                                          SizedBox(
                                            width: 20.w,
                                          ),
                                          SvgPicture.asset(MyImgs.info)
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  SizedBox(
                                    width: 284.w,
                                    height: 184.h,
                                    child: CupertinoTimerPicker(
                                        mode: CupertinoTimerPickerMode.hms,
                                        onTimerDurationChanged:
                                            (Duration duration) {}),
                                  ),
                                  SizedBox(
                                    height: 45.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomButton(
                                        text: "Cancel",
                                        onPressed: () {},
                                        width: 160.w,
                                        color: Colors.white,
                                        textColor: MyColors.buttonColor,
                                        roundCorner: 8,
                                      ),
                                      CustomButton(
                                          text: "Save",
                                          onPressed: () {
                                            Get.find<AuthController>()
                                                .fromHabit = true;
                                            Get.offAll(() => DashboardScreen(
                                                  index: 2,
                                                  fromHabit: true,
                                                ));
                                          },
                                          width: 160.w,
                                          roundCorner: 8),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }),
            SizedBox(
              height: 30.h,
            )
          ],
        ),
      ),
    );
  }

  frequencyWidget(TextTheme textTheme, String text, int index) {
    var selectedIndex = Get.find<AuthController>().selectedFrequency;
    return GestureDetector(
      onTap: () {
        selectedIndex.value = index;
      },
      child: Obx(
        () => Container(
          height: 36.h,
          width: 100.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: selectedIndex.value == index
                  ? MyColors.primary2
                  : MyColors.primaryColor,
              border: Border.all(
                  color: selectedIndex.value == index
                      ? MyColors.primary2
                      : MyColors.black,
                  width: 1)),
          child: Center(
            child: Text(
              text,
              style: textTheme.headlineLarge!.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
                color: selectedIndex.value == index
                    ? Colors.white
                    : MyColors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
