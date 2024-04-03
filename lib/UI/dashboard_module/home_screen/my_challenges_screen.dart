import 'package:enfil_libre/UI/challenge_module/start_challege/start_challege_screen.dart';
import 'package:enfil_libre/UI/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../values/my_colors.dart';
import '../../values/my_imgs.dart';
import '../widgets/custom_progress_widget.dart';

class MyChallengesScreen extends StatelessWidget {
  MyChallengesScreen({super.key});

  final List<Color> myColors = [
    MyColors.pendingColor,
    MyColors.inProgressColor,
    MyColors.finishedColor,
    MyColors.finishedColor,
  ];

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: MyColors.splashColor,
      body: DefaultTabController(
        length: 4,
        child: Column(
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
                          padding: EdgeInsets.only(left: 20.w),
                          child: Text(
                            'My Challenges',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 20.sp,
                                color: MyColors.buttonColor),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        SizedBox(
                          height: 30.h,
                          child: TabBar(
                              // padding: const EdgeInsets.only(right: 100),

                              labelColor: MyColors.buttonColor,
                              labelPadding: EdgeInsets.zero,
                              unselectedLabelColor:
                                  Colors.black.withOpacity(0.4),
                              indicatorSize: TabBarIndicatorSize.label,
                              indicatorColor: MyColors.buttonColor,
                              tabs: const [
                                Tab(
                                  text: "All",
                                ),
                                Tab(
                                  text: "Pending",
                                ),
                                Tab(
                                  text: "In progress",
                                ),
                                Tab(
                                  text: "Finished",
                                )
                              ]),
                        ),
                        Expanded(
                            child: TabBarView(
                          children: [
                            GridView.builder(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20.h, horizontal: 20.w),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, // Number of columns
                                crossAxisSpacing:
                                    14.w, // Spacing between columns
                                mainAxisSpacing: 24.h, // Spacing between rows
                              ),
                              itemCount: myColors.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12.w, vertical: 12.h),
                                    decoration: BoxDecoration(
                                        color: myColors[index],
                                        borderRadius: BorderRadius.circular(8),
                                        boxShadow: [
                                          BoxShadow(
                                              spreadRadius: 0,
                                              blurRadius: 16,
                                              offset: const Offset(0, 4),
                                              color: Colors.black
                                                  .withOpacity(0.12))
                                        ],
                                        border: Border.all(
                                            color: MyColors.buttonColor
                                                .withOpacity(0.12))),
                                    child: Column(
                                      children: [
                                        Text(
                                          'Do 100 pushups daily for 1 hour',
                                          style: textTheme.headlineSmall!
                                              .copyWith(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16.sp,
                                                  color: MyColors.buttonColor),
                                        ),
                                        SizedBox(
                                          height: 15.h,
                                        ),
                                        Row(
                                          children: [
                                            Row(
                                              children: [
                                                SvgPicture.asset(
                                                  MyImgs.miniBadge,
                                                  height: 20.h,
                                                  colorFilter: ColorFilter.mode(
                                                      MyColors.buttonColor
                                                          .withOpacity(0.4),
                                                      BlendMode.srcIn),
                                                ),
                                                SizedBox(
                                                  width: 8.w,
                                                ),
                                                Text(
                                                  '12',
                                                  style: textTheme.titleLarge!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 12.sp,
                                                          color: MyColors
                                                              .buttonColor),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 12.w,
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.access_time,
                                                  color: MyColors.buttonColor
                                                      .withOpacity(0.4),
                                                ),
                                                SizedBox(
                                                  width: 8.w,
                                                ),
                                                Text(
                                                  '2 days left',
                                                  style: textTheme.titleLarge!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 12.sp,
                                                          color: MyColors
                                                              .buttonColor),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                              MyImgs.calender,
                                              height: 20.h,
                                              colorFilter: ColorFilter.mode(
                                                  MyColors.buttonColor
                                                      .withOpacity(0.4),
                                                  BlendMode.srcIn),
                                            ),
                                            SizedBox(
                                              width: 8.w,
                                            ),
                                            Text(
                                              '07:30 PM - 09:30 PM ',
                                              style: textTheme.titleLarge!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 12.sp,
                                                      color:
                                                          MyColors.buttonColor),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        index == 1
                                            ? Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                      '25%',
                                                      style: textTheme
                                                          .titleLarge!
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize: 12.sp,
                                                              color: MyColors
                                                                  .buttonColor),
                                                    ),
                                                  ),
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    child:
                                                        LinearProgressIndicator(
                                                      minHeight: 8.h,
                                                      value: 0.5,
                                                      valueColor:
                                                          const AlwaysStoppedAnimation<
                                                                  Color>(
                                                              MyColors
                                                                  .primary2), // Color of the progress indicator
                                                      backgroundColor: Colors
                                                          .black
                                                          .withOpacity(0.1),
                                                    ),
                                                  )
                                                ],
                                              )
                                            : CustomButton(
                                                text: MyColors.finishedColor ==
                                                        myColors[index]
                                                    ? "Finished"
                                                    : "START",
                                                onPressed: () {
                                                  Get.to(()=>StartChallengeScreen());
                                                },
                                                height: 32.h,
                                                color: MyColors.finishedColor ==
                                                        myColors[index]
                                                    ? const Color(0xff4ECB71)
                                                    : MyColors.buttonColor,
                                                borderColor: MyColors
                                                            .finishedColor ==
                                                        myColors[index]
                                                    ? const Color(0xff4ECB71)
                                                    : MyColors.primary2,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w700,
                                              )
                                      ],
                                    ));
                              },
                            ),
                            GridView.builder(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20.h, horizontal: 20.w),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, // Number of columns
                                crossAxisSpacing:
                                    14.w, // Spacing between columns
                                mainAxisSpacing: 24.h, // Spacing between rows
                              ),
                              itemCount: myColors.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12.w, vertical: 12.h),
                                    decoration: BoxDecoration(
                                        color: myColors[index],
                                        borderRadius: BorderRadius.circular(8),
                                        boxShadow: [
                                          BoxShadow(
                                              spreadRadius: 0,
                                              blurRadius: 16,
                                              offset: const Offset(0, 4),
                                              color: Colors.black
                                                  .withOpacity(0.12))
                                        ],
                                        border: Border.all(
                                            color: MyColors.buttonColor
                                                .withOpacity(0.12))),
                                    child: Column(
                                      children: [
                                        Text(
                                          'Do 100 pushups daily for 1 hour',
                                          style: textTheme.headlineSmall!
                                              .copyWith(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16.sp,
                                                  color: MyColors.buttonColor),
                                        ),
                                        SizedBox(
                                          height: 15.h,
                                        ),
                                        Row(
                                          children: [
                                            Row(
                                              children: [
                                                SvgPicture.asset(
                                                  MyImgs.miniBadge,
                                                  height: 20.h,
                                                  colorFilter: ColorFilter.mode(
                                                      MyColors.buttonColor
                                                          .withOpacity(0.4),
                                                      BlendMode.srcIn),
                                                ),
                                                SizedBox(
                                                  width: 8.w,
                                                ),
                                                Text(
                                                  '12',
                                                  style: textTheme.titleLarge!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 12.sp,
                                                          color: MyColors
                                                              .buttonColor),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 12.w,
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.access_time,
                                                  color: MyColors.buttonColor
                                                      .withOpacity(0.4),
                                                ),
                                                SizedBox(
                                                  width: 8.w,
                                                ),
                                                Text(
                                                  '2 days left',
                                                  style: textTheme.titleLarge!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 12.sp,
                                                          color: MyColors
                                                              .buttonColor),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                              MyImgs.calender,
                                              height: 20.h,
                                              colorFilter: ColorFilter.mode(
                                                  MyColors.buttonColor
                                                      .withOpacity(0.4),
                                                  BlendMode.srcIn),
                                            ),
                                            SizedBox(
                                              width: 8.w,
                                            ),
                                            Text(
                                              '07:30 PM - 09:30 PM ',
                                              style: textTheme.titleLarge!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 12.sp,
                                                      color:
                                                          MyColors.buttonColor),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        index == 1
                                            ? Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                      '25%',
                                                      style: textTheme
                                                          .titleLarge!
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize: 12.sp,
                                                              color: MyColors
                                                                  .buttonColor),
                                                    ),
                                                  ),
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    child:
                                                        LinearProgressIndicator(
                                                      minHeight: 8.h,
                                                      value: 0.5,
                                                      valueColor:
                                                          const AlwaysStoppedAnimation<
                                                                  Color>(
                                                              MyColors
                                                                  .primary2), // Color of the progress indicator
                                                      backgroundColor: Colors
                                                          .black
                                                          .withOpacity(0.1),
                                                    ),
                                                  )
                                                ],
                                              )
                                            : CustomButton(
                                                text: "START",
                                                onPressed: () {},
                                                height: 32.h,
                                                color: MyColors.finishedColor ==
                                                        myColors[index]
                                                    ? const Color(0xff4ECB71)
                                                    : MyColors.buttonColor,
                                                borderColor: MyColors
                                                            .finishedColor ==
                                                        myColors[index]
                                                    ? const Color(0xff4ECB71)
                                                    : MyColors.primary2,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w700,
                                              )
                                      ],
                                    ));
                              },
                            ),
                            GridView.builder(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20.h, horizontal: 20.w),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, // Number of columns
                                crossAxisSpacing:
                                    14.w, // Spacing between columns
                                mainAxisSpacing: 24.h, // Spacing between rows
                              ),
                              itemCount: myColors.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12.w, vertical: 12.h),
                                    decoration: BoxDecoration(
                                        color: myColors[index],
                                        borderRadius: BorderRadius.circular(8),
                                        boxShadow: [
                                          BoxShadow(
                                              spreadRadius: 0,
                                              blurRadius: 16,
                                              offset: const Offset(0, 4),
                                              color: Colors.black
                                                  .withOpacity(0.12))
                                        ],
                                        border: Border.all(
                                            color: MyColors.buttonColor
                                                .withOpacity(0.12))),
                                    child: Column(
                                      children: [
                                        Text(
                                          'Do 100 pushups daily for 1 hour',
                                          style: textTheme.headlineSmall!
                                              .copyWith(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16.sp,
                                                  color: MyColors.buttonColor),
                                        ),
                                        SizedBox(
                                          height: 15.h,
                                        ),
                                        Row(
                                          children: [
                                            Row(
                                              children: [
                                                SvgPicture.asset(
                                                  MyImgs.miniBadge,
                                                  height: 20.h,
                                                  colorFilter: ColorFilter.mode(
                                                      MyColors.buttonColor
                                                          .withOpacity(0.4),
                                                      BlendMode.srcIn),
                                                ),
                                                SizedBox(
                                                  width: 8.w,
                                                ),
                                                Text(
                                                  '12',
                                                  style: textTheme.titleLarge!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 12.sp,
                                                          color: MyColors
                                                              .buttonColor),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 12.w,
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.access_time,
                                                  color: MyColors.buttonColor
                                                      .withOpacity(0.4),
                                                ),
                                                SizedBox(
                                                  width: 8.w,
                                                ),
                                                Text(
                                                  '2 days left',
                                                  style: textTheme.titleLarge!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 12.sp,
                                                          color: MyColors
                                                              .buttonColor),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                              MyImgs.calender,
                                              height: 20.h,
                                              colorFilter: ColorFilter.mode(
                                                  MyColors.buttonColor
                                                      .withOpacity(0.4),
                                                  BlendMode.srcIn),
                                            ),
                                            SizedBox(
                                              width: 8.w,
                                            ),
                                            Text(
                                              '07:30 PM - 09:30 PM ',
                                              style: textTheme.titleLarge!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 12.sp,
                                                      color:
                                                          MyColors.buttonColor),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        index == 1
                                            ? Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                      '25%',
                                                      style: textTheme
                                                          .titleLarge!
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize: 12.sp,
                                                              color: MyColors
                                                                  .buttonColor),
                                                    ),
                                                  ),
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    child:
                                                        LinearProgressIndicator(
                                                      minHeight: 8.h,
                                                      value: 0.5,
                                                      valueColor:
                                                          const AlwaysStoppedAnimation<
                                                                  Color>(
                                                              MyColors
                                                                  .primary2), // Color of the progress indicator
                                                      backgroundColor: Colors
                                                          .black
                                                          .withOpacity(0.1),
                                                    ),
                                                  )
                                                ],
                                              )
                                            : CustomButton(
                                                text: "START",
                                                onPressed: () {},
                                                height: 32.h,
                                                color: MyColors.finishedColor ==
                                                        myColors[index]
                                                    ? const Color(0xff4ECB71)
                                                    : MyColors.buttonColor,
                                                borderColor: MyColors
                                                            .finishedColor ==
                                                        myColors[index]
                                                    ? const Color(0xff4ECB71)
                                                    : MyColors.primary2,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w700,
                                              )
                                      ],
                                    ));
                              },
                            ),
                            GridView.builder(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20.h, horizontal: 20.w),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, // Number of columns
                                crossAxisSpacing:
                                    14.w, // Spacing between columns
                                mainAxisSpacing: 24.h, // Spacing between rows
                              ),
                              itemCount: myColors.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12.w, vertical: 12.h),
                                    decoration: BoxDecoration(
                                        color: myColors[index],
                                        borderRadius: BorderRadius.circular(8),
                                        boxShadow: [
                                          BoxShadow(
                                              spreadRadius: 0,
                                              blurRadius: 16,
                                              offset: const Offset(0, 4),
                                              color: Colors.black
                                                  .withOpacity(0.12))
                                        ],
                                        border: Border.all(
                                            color: MyColors.buttonColor
                                                .withOpacity(0.12))),
                                    child: Column(
                                      children: [
                                        Text(
                                          'Do 100 pushups daily for 1 hour',
                                          style: textTheme.headlineSmall!
                                              .copyWith(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16.sp,
                                                  color: MyColors.buttonColor),
                                        ),
                                        SizedBox(
                                          height: 15.h,
                                        ),
                                        Row(
                                          children: [
                                            Row(
                                              children: [
                                                SvgPicture.asset(
                                                  MyImgs.miniBadge,
                                                  height: 20.h,
                                                  colorFilter: ColorFilter.mode(
                                                      MyColors.buttonColor
                                                          .withOpacity(0.4),
                                                      BlendMode.srcIn),
                                                ),
                                                SizedBox(
                                                  width: 8.w,
                                                ),
                                                Text(
                                                  '12',
                                                  style: textTheme.titleLarge!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 12.sp,
                                                          color: MyColors
                                                              .buttonColor),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 12.w,
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.access_time,
                                                  color: MyColors.buttonColor
                                                      .withOpacity(0.4),
                                                ),
                                                SizedBox(
                                                  width: 8.w,
                                                ),
                                                Text(
                                                  '2 days left',
                                                  style: textTheme.titleLarge!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 12.sp,
                                                          color: MyColors
                                                              .buttonColor),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                              MyImgs.calender,
                                              height: 20.h,
                                              colorFilter: ColorFilter.mode(
                                                  MyColors.buttonColor
                                                      .withOpacity(0.4),
                                                  BlendMode.srcIn),
                                            ),
                                            SizedBox(
                                              width: 8.w,
                                            ),
                                            Text(
                                              '07:30 PM - 09:30 PM ',
                                              style: textTheme.titleLarge!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 12.sp,
                                                      color:
                                                          MyColors.buttonColor),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        index == 1
                                            ? Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                      '25%',
                                                      style: textTheme
                                                          .titleLarge!
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize: 12.sp,
                                                              color: MyColors
                                                                  .buttonColor),
                                                    ),
                                                  ),
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    child:
                                                        LinearProgressIndicator(
                                                      minHeight: 8.h,
                                                      value: 0.5,
                                                      valueColor:
                                                          const AlwaysStoppedAnimation<
                                                                  Color>(
                                                              MyColors
                                                                  .primary2), // Color of the progress indicator
                                                      backgroundColor: Colors
                                                          .black
                                                          .withOpacity(0.1),
                                                    ),
                                                  )
                                                ],
                                              )
                                            : CustomButton(
                                                text: "START",
                                                onPressed: () {
                                                  // Get.to(() =>
                                                  //     const StartChallengeScreen());
                                                },
                                                height: 32.h,
                                                color: MyColors.finishedColor ==
                                                        myColors[index]
                                                    ? const Color(0xff4ECB71)
                                                    : MyColors.buttonColor,
                                                borderColor: MyColors
                                                            .finishedColor ==
                                                        myColors[index]
                                                    ? const Color(0xff4ECB71)
                                                    : MyColors.primary2,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w700,
                                              )
                                      ],
                                    ));
                              },
                            ),
                          ],
                        ))
                      ],
                    )))
          ],
        ),
      ),
    );
  }
}
