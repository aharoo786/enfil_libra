import 'package:enfil_libre/controllers/habit_controller/habit_controller.dart';
import 'package:enfil_libre/data/models/habit_module/get_catergories_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';

import '../../values/my_colors.dart';
import '../../values/my_imgs.dart';
import '../../widgets/custom_button.dart';

class HabitBottomSheets {
  final List<String> counterNumber = ["1", "2", "3", "4", "5", "6", "7"];
  final List<String> counterType = [
    "Liters",
    "Gallon",
    "Time",
    "Page",
    "Kilometer"
  ];
  final List<String> counterHour = ["Per Hour"];
  showCreateHabitBottomSheet(
      BuildContext context,
      HabitController habitController,
      SubCategory subCategory,
      List<Color> tempColors,
      List<String> frequencyText,
      List<String> slotText,
      List<String> dayText) {
    var textTheme = Theme.of(context).textTheme;
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(12.r), topLeft: Radius.circular(12.r))),
      builder: (BuildContext context) {
        return Container(
          height: 820.h,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12)),
          ),
          child: ListView(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    'Create The Habit ',
                    style: textTheme.headlineLarge!
                        .copyWith(fontSize: 32.sp, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    'More Option',
                    style: textTheme.headlineLarge!
                        .copyWith(fontSize: 18.sp, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 35.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.w),
                    child: Column(
                      children: [
                        createInfoRow("Reminder", (p0) {
                          habitController.showReminder.value = p0;
                        }, habitController.showReminder),
                        SizedBox(
                          height: 20.h,
                        ),
                        Obx(
                          () => habitController.showReminder.value
                              ? SizedBox(
                                  width: habitController.showReminder.value
                                      ? 284.w
                                      : 0,
                                  height: habitController.showReminder.value
                                      ? 184.h
                                      : 0,
                                  child: CupertinoDatePicker(
                                    mode: CupertinoDatePickerMode.time,
                                    initialDateTime: DateTime.now(),
                                    onDateTimeChanged: (DateTime dateTime) {
                                      habitController.reminderTime =
                                          DateFormat('hh:mm a')
                                              .format(dateTime);
                                      // Handle selected time here
                                      // You can convert the selected time to AM/PM format
                                    },
                                  ))
                              : SizedBox.shrink(),
                        ),
                        createInfoRow("Counter", (p0) {
                          habitController.showCounter.value = p0;
                        }, habitController.showCounter),
                        SizedBox(
                          height: 20.h,
                        ),
                        Obx(
                          () => habitController.showCounter.value
                              ? SizedBox(
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
                                              counterType.length, (int index) {
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
                                              counterHour.length, (int index) {
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
                                )
                              : SizedBox.shrink(),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        createInfoRow("Minutes", (p0) {
                          habitController.showMinutes.value = p0;
                        }, habitController.showMinutes),
                        SizedBox(
                          height: 20.h,
                        ),
                        Obx(() => habitController.showMinutes.value
                            ? SizedBox(
                                width: 284.w,
                                height: 184.h,
                                child: CupertinoTimerPicker(
                                    mode: CupertinoTimerPickerMode.hm,
                                    onTimerDurationChanged:
                                        (Duration duration) {
                                      habitController.time =
                                          "${duration.inHours}:${duration.inMinutes.remainder(60)}";
                                    }),
                              )
                            : SizedBox.shrink()),
                        SizedBox(
                          height: 45.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  habitController.crateHabit(
                                      subCategory.name,
                                      tempColors[habitController
                                              .selectedHabitColor.value]
                                          .value
                                          .toRadixString(16)
                                          .substring(2)
                                          .toUpperCase(),
                                      habitController.selectedFrequency.value ==
                                              3
                                          ? dayText[habitController
                                              .selectedFrequencyDay.value]
                                          : frequencyText[habitController
                                              .selectedFrequency.value],
                                      slotText[
                                          habitController.selectedSlot.value],
                                      habitController.reminderTime,
                                      subCategory.id.toString(),
                                      "${counterNumber[habitController.counterNumberIndex]} ${counterType[habitController.counterTypeIndex]} ${counterHour[habitController.counterHourIndex]} ");
                                },
                                width: 160.w,
                                roundCorner: 8),
                          ],
                        ),
                        SizedBox(
                          height: 40.h,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  createInfoRow(
      String buttonText, Function(bool) onSwitch, RxBool switchValue) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomButton(
          text: buttonText,
          onPressed: () {},
          fontWeight: FontWeight.w700,
          fontSize: 18.sp,
          color: MyColors.splashColor,
          borderColor: MyColors.splashColor,
          roundCorner: 8,
          width: 120.w,
          height: 36.h,
          textColor: Colors.black,
        ),
        Row(
          children: [
            Transform.scale(
              scale: 0.6, // Adjust the scale factor as needed
              child: Obx(
                () => Switch(
                  inactiveThumbColor: Colors.white,
                  inactiveTrackColor: Colors.grey.withOpacity(0.4),
                  value: switchValue.value,
                  onChanged: (value) {
                    onSwitch(value);
                  },
                  activeColor: MyColors.buttonColor,
                ),
              ),
            ),
            SvgPicture.asset(MyImgs.info)
          ],
        )
      ],
    );
  }
  Color hexToColor(String hex) {
    // Ensure that the hex string is valid and properly formatted
    hex = hex.replaceFirst('#', ''); // Remove '#' if present
    if (hex.length == 6) {
      hex = 'ff$hex'; // Add alpha value if not present
    }
    return Color(int.parse('0x$hex'));
  }
}
