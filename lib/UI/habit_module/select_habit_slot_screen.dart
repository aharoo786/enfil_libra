import 'package:enfil_libre/UI/dashboard_module/dashboard_screen/dashboard_screen.dart';
import 'package:enfil_libre/UI/values/my_imgs.dart';
import 'package:enfil_libre/UI/widgets/custom_button.dart';
import 'package:enfil_libre/controllers/auth_controller/auth_controller.dart';
import 'package:enfil_libre/controllers/habit_controller/habit_controller.dart';
import 'package:enfil_libre/data/models/habit_module/get_catergories_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:signature/signature.dart';
import '../values/my_colors.dart';
import '../widgets/app_bar_widget.dart';

class SelectHabitSlotScreen extends StatelessWidget {
  SelectHabitSlotScreen({super.key, required this.subCategory});

  final SubCategory subCategory;

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
  final List<String> slotText = ["Morning", "Evening", "Night", "Every Time"];
  final List<String> dayText = ["M", "T", "W", "T", "F", "S", "S"];
  final List<String> counterNumber = ["1", "2", "3", "4", "5", "6", "7"];
  final List<String> counterType = [
    "Liters",
    "Gallon",
    "Time",
    "Page",
    "Kilometer"
  ];
  final List<String> counterHour = ["Per Hour"];

  final HabitController habitController = Get.find();

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
                          return Obx(
                            () => GestureDetector(
                              onTap: () {
                                habitController.selectedHabitColor.value =
                                    index;
                              },
                              child: Container(
                                height: 36.h,
                                width: 36.w,
                                margin: EdgeInsets.symmetric(horizontal: 6.w),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        width: 2,
                                        color: habitController
                                                    .selectedHabitColor.value ==
                                                index
                                            ? MyColors.primary2
                                            : Colors.transparent),
                                    color: tempColors[index]),
                              ),
                            ),
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
              // height: 156.h,
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
                            textTheme,
                            frequencyText[index],
                            index,
                            habitController.selectedFrequency),
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
                  Obx(
                    () => habitController.selectedFrequency.value == 3
                        ? SizedBox(
                            height: 60.h,
                            child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) => dayWidget(
                                    textTheme,
                                    dayText[index],
                                    index,
                                    habitController.selectedFrequencyDay),
                                separatorBuilder: (context, index) => SizedBox(
                                      width: 11.w,
                                    ),
                                itemCount: dayText.length),
                          )
                        : GestureDetector(
                            onTap: () {
                              habitController.selectedFrequency.value = 3;
                            },
                            child: Container(
                              height: 36.h,
                              width: 145.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: MyColors.buttonColor, width: 1)),
                              child: Center(
                                child: Text(
                                  "+More option",
                                  style: textTheme.headlineLarge!.copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16.sp,
                                      color: MyColors.buttonColor),
                                ),
                              ),
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

                  Wrap(
                    spacing: 16.w,
                    runSpacing: 16.h,
                    children: List.generate(
                      slotText.length,
                      (index) => frequencyWidget(textTheme, slotText[index],
                          index, habitController.selectedSlot),
                    ),
                  ),

                  // SizedBox(
                  //   height: 36.h,
                  //   child: ListView.separated(
                  //       scrollDirection: Axis.horizontal,
                  //       itemBuilder: (context, index) => frequencyWidget(
                  //           textTheme,
                  //           slotText[index],
                  //           index,
                  //           habitController.selectedSlot),
                  //       separatorBuilder: (context, index) => SizedBox(
                  //             width: 16.w,
                  //           ),
                  //       itemCount: slotText.length),
                  // ),

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
                  // SizedBox(
                  //   height: 16.h,
                  // ),
                  // Container(
                  //   height: 36.h,
                  //   width: 117.w,
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(20),
                  //       border: Border.all(color: MyColors.black, width: 1)),
                  //   child: Center(
                  //     child: Text(
                  //       "Every time",
                  //       style: textTheme.headlineLarge!.copyWith(
                  //           fontWeight: FontWeight.w400, fontSize: 16.sp),
                  //     ),
                  //   ),
                  // ),
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
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(12.r),
                            topLeft: Radius.circular(12.r))),
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
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18.sp,
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
                                            width: 5.w,
                                          ),
                                          SvgPicture.asset(MyImgs.info)
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  // SizedBox(
                                  //   width: 284.w,
                                  //   height: 184.h,
                                  //   child: CupertinoPicker(
                                  //     itemExtent: 40,
                                  //     onSelectedItemChanged: (int value) {
                                  //       print("Value  $value");
                                  //     },
                                  //     children: [
                                  //       Row(
                                  //         mainAxisAlignment:
                                  //             MainAxisAlignment.spaceEvenly,
                                  //         children: [
                                  //           Expanded(
                                  //             child: ListView.separated(
                                  //                 itemBuilder: (BuildContext
                                  //                             context,
                                  //                         int index) =>
                                  //                     Text(
                                  //                         "${counterNumber[index]}"),
                                  //                 separatorBuilder:
                                  //                     (BuildContext context,
                                  //                             int index) =>
                                  //                         SizedBox(
                                  //                           height: 10.h,
                                  //                         ),
                                  //                 itemCount:
                                  //                     counterNumber.length),
                                  //           ),
                                  //           Expanded(
                                  //             child: ListView.separated(
                                  //                 itemBuilder: (BuildContext
                                  //                             context,
                                  //                         int index) =>
                                  //                     Text(
                                  //                         "${counterType[index]}"),
                                  //                 separatorBuilder:
                                  //                     (BuildContext context,
                                  //                             int index) =>
                                  //                         SizedBox(
                                  //                           height: 10.h,
                                  //                         ),
                                  //                 itemCount:
                                  //                     counterType.length),
                                  //           ),
                                  //           Expanded(
                                  //             child: ListView.separated(
                                  //                 itemBuilder: (BuildContext
                                  //                             context,
                                  //                         int index) =>
                                  //                     Text(
                                  //                         "${counterHour[index]}"),
                                  //                 separatorBuilder:
                                  //                     (BuildContext context,
                                  //                             int index) =>
                                  //                         SizedBox(
                                  //                           height: 10.h,
                                  //                         ),
                                  //                 itemCount:
                                  //                     counterHour.length),
                                  //           ),
                                  //         ],
                                  //       )
                                  //     ],
                                  //   ),
                                  // ),
                                  SizedBox(
                                    height: 184.h,
                                    width: 300.w,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: CupertinoPicker(
                                            itemExtent: 40,
                                            onSelectedItemChanged: (int value) {
                                              habitController.counterNumberIndex =
                                                  value;
                                            },
                                            children: List<Widget>.generate(
                                                counterNumber.length,
                                                (int index) {
                                              return Center(
                                                child: Text(
                                                    '${counterNumber[index]}'),
                                              );
                                            }),
                                          ),
                                        ),
                                        Expanded(
                                          child: CupertinoPicker(
                                            itemExtent: 40,
                                            onSelectedItemChanged: (int value) {
                                              habitController.counterTypeIndex =
                                                  value;
                                            },
                                            children: List<Widget>.generate(
                                                counterType.length,
                                                (int index) {
                                              return Center(
                                                child: Text(
                                                  '${counterType[index]}',
                                                  style: TextStyle(
                                                      fontSize: 20.sp,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              );
                                            }),
                                          ),
                                        ),
                                        Expanded(
                                          child: CupertinoPicker(
                                            itemExtent: 40,
                                            onSelectedItemChanged: (int value) {
                                              habitController.counterHourIndex =
                                                  value;
                                            },
                                            children: List<Widget>.generate(
                                                counterHour.length,
                                                (int index) {
                                              return Center(
                                                child: Text(
                                                  counterHour[index],
                                                  style: TextStyle(
                                                      fontSize: 18.sp,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              );
                                            }),
                                          ),
                                        ),
                                      ],
                                    ),
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
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18.sp,
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
                                            width: 5.w,
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
                                        mode: CupertinoTimerPickerMode.hm,
                                        onTimerDurationChanged:
                                            (Duration duration) {
                                          habitController.time =
                                              "${duration.inHours}:${duration.inMinutes.remainder(60)}";
                                        }),
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

                                      print("   1112 2 2 ${  tempColors[
                                      habitController
                                          .selectedHabitColor
                                          .value].value.toRadixString(16).substring(2).toUpperCase()}");
                                            habitController.crateHabit(
                                                subCategory.name,
                                                tempColors[
                                                        habitController
                                                            .selectedHabitColor
                                                            .value].value.toRadixString(16).substring(2).toUpperCase(),
                                                habitController
                                                            .selectedFrequency
                                                            .value ==
                                                        3
                                                    ? dayText[habitController
                                                        .selectedFrequencyDay
                                                        .value]
                                                    : frequencyText[
                                                        habitController
                                                            .selectedFrequency
                                                            .value],
                                                slotText[habitController
                                                    .selectedSlot.value],
                                                null,
                                                subCategory.id.toString(),
                                                "${counterNumber[habitController.counterNumberIndex]} ${counterType[habitController.counterTypeIndex]} ${counterHour[habitController.counterHourIndex]} ");
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

  frequencyWidget(
      TextTheme textTheme, String text, int index, RxInt selectedIndex) {
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

  dayWidget(TextTheme textTheme, String text, int index, RxInt selectedIndex) {
    return GestureDetector(
      onTap: () {
        selectedIndex.value = index;
      },
      child: Obx(
        () => Container(
          height: 60.h,
          width: 40.w,
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
