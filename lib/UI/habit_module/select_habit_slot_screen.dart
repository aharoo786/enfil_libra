import 'package:enfil_libre/UI/dashboard_module/dashboard_screen/dashboard_screen.dart';
import 'package:enfil_libre/UI/habit_module/widgets/bottom_sheets.dart';
import 'package:enfil_libre/UI/values/my_imgs.dart';
import 'package:enfil_libre/UI/widgets/custom_button.dart';
import 'package:enfil_libre/controllers/auth_controller/auth_controller.dart';
import 'package:enfil_libre/controllers/habit_controller/habit_controller.dart';
import 'package:enfil_libre/data/models/habit_module/get_catergories_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:signature/signature.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
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
  final List<String> dayText = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];

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
                            habitController.selectedFrequency,
                            context,
                            isFrequency: true),
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
                    () => habitController.selectedFrequency.value == 1
                        ? SizedBox(
                            height: 40.h,
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
                          index, habitController.selectedSlot, context),
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
                  HabitBottomSheets().showCreateHabitBottomSheet(
                      context,
                      habitController,
                      subCategory,
                      tempColors,
                      frequencyText,
                      slotText,
                      dayText);
                }),
            SizedBox(
              height: 30.h,
            )
          ],
        ),
      ),
    );
  }

  frequencyWidget(TextTheme textTheme, String text, int index,
      RxInt selectedIndex, BuildContext context,
      {bool isFrequency = false}) {
    return GestureDetector(
      onTap: () {
        if (isFrequency && index == 2) {
          _selectDateRange(context);
        }

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

  Future<void> _selectDateRange(BuildContext context) async {
    print(":initial ${habitController.initialRange}");
    DateRangePickerController dateRangePickerController =
        DateRangePickerController();
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          backgroundColor: Colors.white,
          child: Container(
            padding: EdgeInsets.all(10.h),
            height: 350.0.h,
            width: 374.0.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: SfDateRangePicker(
                      initialSelectedRange: PickerDateRange(
                          habitController.initialRange[0],
                          habitController.initialRange[1]),
                      onSelectionChanged:
                          (DateRangePickerSelectionChangedArgs args) {
                        if (args.value is PickerDateRange) {
                          DateTime? startDate = args.value.startDate;
                          DateTime? endDate = args.value.endDate;

                          if (startDate != null && endDate != null) {
                            habitController.range = [
                              DateFormat("dd-MM-yyyy").format(startDate),
                              DateFormat("dd-MM-yyyy").format(endDate)
                            ];
                            habitController.initialRange = [startDate, endDate];
                          }
                        }
                      },
                      minDate: habitController.firstDayOfMonth,
                      rangeSelectionColor: MyColors.buttonColor,
                      maxDate: habitController.lastDayOfMonth,
                      backgroundColor: Colors.white,
                      startRangeSelectionColor: MyColors.buttonColor,
                      selectionColor: MyColors.buttonColor,
                      initialSelectedDate: DateTime.now(),
                      todayHighlightColor: MyColors.buttonColor,
                      endRangeSelectionColor: MyColors.buttonColor,
                      selectionMode: DateRangePickerSelectionMode.range,
                      headerStyle: const DateRangePickerHeaderStyle(
                        backgroundColor: Colors.white,
                      ),
                      monthCellStyle: const DateRangePickerMonthCellStyle(
                          todayCellDecoration: BoxDecoration(
                              color: MyColors.buttonColor,
                              shape: BoxShape.circle)),
                      view: DateRangePickerView.month,
                      monthViewSettings: const DateRangePickerMonthViewSettings(
                        firstDayOfWeek: 1,
                      ),
                      selectionTextStyle: const TextStyle(
                        color:
                            Colors.white, // Text color for the selected dates
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 30.h,
                          width: 80.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: MyColors.buttonColor)),
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp,
                                color: MyColors.buttonColor),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 30.h,
                          width: 50.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: MyColors.buttonColor)),
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Text(
                            "OK",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp,
                                color: MyColors.buttonColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
    // final DateTimeRange? picked = await showDateRangePicker(
    //   context: context,
    //   firstDate: DateTime.now(), // Example: From today's date minus 1 year
    //   lastDate: DateTime.now().add(Duration(days: 30)), // Example: Up to today's date
    // );
    //
    // if (picked != null) {
    //   // Handle the selected date range
    //   print('Selected date range: ${picked.start} to ${picked.end}');
    //   // You can use picked.start and picked.end to process the selected range
    // }
  }

  dayWidget(TextTheme textTheme, String text, int index, RxInt selectedIndex) {
    return GestureDetector(
      onTap: () {
        selectedIndex.value = index;
      },
      child: Obx(
        () => Container(
          height: 40.h,
          // width: 40.w,
          padding: EdgeInsets.symmetric(horizontal: 12.w),
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
