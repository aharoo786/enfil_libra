import 'package:enfil_libre/controllers/auth_controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../values/my_colors.dart';
import '../../values/my_imgs.dart';
import 'custom_progress_widget.dart';

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({super.key});

  @override
  CustomTabBarState createState() => CustomTabBarState();
}

class CustomTabBarState extends State<CustomTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  AuthController authController = Get.find();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    _tabController.addListener(_onTabChanged);
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return GetBuilder<AuthController>(builder: (context) {
      return Column(
        children: [
          SizedBox(
            height: 20.w,
          ),
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SizedBox(
                height: 60.h,
                child: TabBar(
                  controller: _tabController,
                  padding: EdgeInsets.only(left: 33.w, right: 33.w),
                  labelColor: MyColors.buttonColor,
                  unselectedLabelColor: Colors.black.withOpacity(0.4),
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor: MyColors.buttonColor,
                  tabs: [
                    Tab(
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            MyImgs.rewardSmall,
                            colorFilter: ColorFilter.mode(
                                _tabController.index == 0
                                    ? MyColors.buttonColor
                                    : MyColors.buttonColor.withOpacity(0.4),
                                BlendMode.srcIn),
                          ),
                          Text(
                            "Reward",
                            style: textTheme.bodyMedium!.copyWith(
                                color: _tabController.index == 0
                                    ? MyColors.buttonColor
                                    : MyColors.buttonColor.withOpacity(0.4),
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                    Tab(
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            MyImgs.overview,
                            colorFilter: ColorFilter.mode(
                                _tabController.index == 1
                                    ? MyColors.buttonColor
                                    : MyColors.buttonColor.withOpacity(0.4),
                                BlendMode.srcIn),
                          ),
                          Text(
                            "Overview",
                            style: textTheme.bodyMedium!.copyWith(
                                fontSize: 16.sp,
                                color: _tabController.index == 1
                                    ? MyColors.buttonColor
                                    : MyColors.buttonColor.withOpacity(0.4),
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                    Tab(
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            MyImgs.task,
                            colorFilter: ColorFilter.mode(
                                _tabController.index == 2
                                    ? MyColors.buttonColor
                                    : MyColors.buttonColor.withOpacity(0.4),
                                BlendMode.srcIn),
                          ),
                          Text(
                            "Task",
                            style: textTheme.bodyMedium!.copyWith(
                                fontSize: 16.sp,
                                color: _tabController.index == 2
                                    ? MyColors.buttonColor
                                    : MyColors.buttonColor.withOpacity(0.4),
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 33.w,
                right: 33.w,
                top: 50.h,
                child: Divider(
                  // Horizontal divider
                  color: MyColors.buttonColor
                      .withOpacity(0.4), // Color of the divider
                  thickness: 2.h, // Thickness of the divider
                ),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.w),
                      child: Text(
                        'Dashboard',
                        style: textTheme.headlineSmall!.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 20.sp,
                            color: MyColors.buttonColor),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20.w),
                      padding: EdgeInsets.only(
                          top: 12.h, left: 12.w, right: 12.w, bottom: 25.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 0,
                                blurRadius: 16,
                                offset: Offset(0, 4),
                                color: Colors.black.withOpacity(0.12))
                          ]),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Your next reward',
                                style: textTheme.headlineSmall!.copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20.sp,
                                    color: MyColors.buttonColor),
                              ),
                              SvgPicture.asset(MyImgs.rewardBig)
                            ],
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          Row(
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    MyImgs.calender,
                                    height: 20.h,
                                    colorFilter: const ColorFilter.mode(
                                        MyColors.primary2, BlendMode.srcIn),
                                  ),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  Text(
                                    '2 days left',
                                    style: textTheme.titleLarge!.copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12.sp,
                                        color: MyColors.buttonColor),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 12.w,
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    MyImgs.miniBadge,
                                    height: 20.h,
                                    colorFilter: const ColorFilter.mode(
                                        MyColors.primary2, BlendMode.srcIn),
                                  ),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  Text(
                                    '12',
                                    style: textTheme.titleLarge!.copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12.sp,
                                        color: MyColors.buttonColor),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              '50/100',
                              style: textTheme.titleLarge!.copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12.sp,
                                  color: MyColors.buttonColor),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: LinearProgressIndicator(
                              value: 0.5,
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                  MyColors
                                      .primary2), // Color of the progress indicator
                              backgroundColor: Colors.black.withOpacity(0.1),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 20.w),
                      padding: EdgeInsets.symmetric(vertical: 36.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 0,
                                blurRadius: 16,
                                offset: const Offset(0, 4),
                                color: Colors.black.withOpacity(0.12))
                          ]),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 36.h,
                                width: 36.h,
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: MyColors.splashColor),
                                child: SvgPicture.asset(MyImgs.bigBadge),
                              ),
                              SizedBox(
                                width: 16.w,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '3 days perfect!',
                                    style: textTheme.headlineSmall!.copyWith(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20.sp,
                                        color: MyColors.buttonColor),
                                  ),
                                  Text(
                                    'Fantastic performance',
                                    style: textTheme.bodySmall!.copyWith(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.sp,
                                        color: MyColors.hintText),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 20.w),
                      padding: EdgeInsets.only(
                          top: 16.h, left: 13.w, right: 13.w, bottom: 28.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 0,
                                blurRadius: 16,
                                offset: const Offset(0, 4),
                                color: Colors.black.withOpacity(0.12))
                          ]),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 36.h,
                                width: 36.h,
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: MyColors.splashColor),
                                child: SvgPicture.asset(MyImgs.bigBadge),
                              ),
                              SizedBox(
                                width: 16.w,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '21 days streak',
                                    style: textTheme.headlineSmall!.copyWith(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20.sp,
                                        color: MyColors.buttonColor),
                                  ),
                                  Text(
                                    'Fantastic performance',
                                    style: textTheme.bodySmall!.copyWith(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.sp,
                                        color: MyColors.hintText),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 24.h,
                          ),
                          SizedBox(
                            height: 45.h,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) => Column(
                                      children: [
                                        Text(
                                          'Mo',
                                          style: textTheme.bodySmall!.copyWith(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14.sp,
                                              color: MyColors.hintText),
                                        ),
                                        Expanded(
                                          child: Checkbox(
                                              shape: const CircleBorder(),
                                              activeColor: MyColors.buttonColor,
                                              value: true,
                                              onChanged: (value) {}),
                                        )
                                      ],
                                    ),
                                itemCount: 7),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal:20.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Dashboard',
                              style: textTheme.headlineSmall!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20.sp,
                                  color: MyColors.buttonColor),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            SvgPicture.asset(MyImgs.chart),
                            SizedBox(
                              height: 20.h,
                            ),
                            Text(
                              'Recent task',
                              style: textTheme.headlineSmall!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20.sp,
                                  color: MyColors.buttonColor),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) =>
                              const CustomProgressWidget(),
                          separatorBuilder: (context, index) => SizedBox(
                                height: 16.h,
                              ),
                          itemCount: 4)
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding:  EdgeInsets.only(left: 20.w),
                      child: Text(
                        'All Tasks',
                        style: textTheme.headlineSmall!.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 20.sp,
                            color: MyColors.buttonColor),
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
                )
              ],
            ),
          )
        ],
      );
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _tabController.removeListener(_onTabChanged);

    super.dispose();
  }

  void _onTabChanged() {
    authController.update();
  }
}
