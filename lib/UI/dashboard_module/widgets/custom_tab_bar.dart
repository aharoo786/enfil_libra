import 'dart:async';
import 'dart:ffi';

import 'package:enfil_libre/UI/dashboard_module/widgets/create_new_challenge.dart';
import 'package:enfil_libre/UI/dashboard_module/widgets/overview_score_widget.dart';
import 'package:enfil_libre/controllers/auth_controller/auth_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:shimmer/shimmer.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../controllers/home_controller/home_controller.dart';
import '../../../data/models/dashboard_module/overview_model.dart';
import '../../values/my_colors.dart';
import '../../values/my_imgs.dart';
import '../../widgets/radial_axis.dart';
import 'custom_progress_widget.dart';
import 'cutomProgressWidgetShimmer.dart';

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({super.key});

  @override
  CustomTabBarState createState() => CustomTabBarState();
}

class CustomTabBarState extends State<CustomTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  AuthController authController = Get.find();
  final HomeController homeController = Get.find();

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
                ///Reward Tab
                Obx(() {
                  if (homeController.isUpcomingRewardsLoad.value) {
                    if (homeController.upcomingRewardsModel!.data[0].name !=
                        null) {
                      return RefreshIndicator(
                        onRefresh: () {
                          Future.wait([
                            homeController.getUpcomingRewards(),
                            homeController.getUserStreak()
                          ]);
                          return Future(() => true);
                        },
                        color: MyColors.buttonColor,
                        child: ListView(
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
                                Obx(() => homeController
                                        .isUpcomingRewardsLoad.value
                                    ? homeController.upcomingRewardsModel!
                                                .data[0].name !=
                                            null
                                        ? SizedBox(
                                            height: 190.h,
                                            child: ListView.separated(
                                              scrollDirection: Axis.horizontal,
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 20.h),
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                var reward = homeController
                                                    .upcomingRewardsModel!
                                                    .data[index];
                                                return Container(
                                                  width: 374.w,
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 20.w),
                                                  padding: EdgeInsets.only(
                                                      top: 12.h,
                                                      left: 12.w,
                                                      right: 12.w,
                                                      bottom: 25.w),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      color: Colors.white,
                                                      boxShadow: [
                                                        BoxShadow(
                                                            spreadRadius: 0,
                                                            blurRadius: 16,
                                                            offset:
                                                                const Offset(
                                                                    0, 4),
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.12))
                                                      ]),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              reward.name!,
                                                              style: textTheme
                                                                  .headlineSmall!
                                                                  .copyWith(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      fontSize:
                                                                          20.sp,
                                                                      color: MyColors
                                                                          .buttonColor),
                                                              maxLines: 2,
                                                            ),
                                                          ),
                                                          SvgPicture.asset(
                                                              MyImgs.rewardBig)
                                                        ],
                                                      ),
                                                      const Spacer(),
                                                      Row(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              SvgPicture.asset(
                                                                MyImgs.calender,
                                                                height: 20.h,
                                                                colorFilter: const ColorFilter
                                                                    .mode(
                                                                    MyColors
                                                                        .primary2,
                                                                    BlendMode
                                                                        .srcIn),
                                                              ),
                                                              SizedBox(
                                                                width: 8.w,
                                                              ),
                                                              Text(
                                                                '${reward.remainingDays} days left',
                                                                style: textTheme.titleLarge!.copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        12.sp,
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
                                                              SvgPicture.asset(
                                                                MyImgs
                                                                    .miniBadge,
                                                                height: 20.h,
                                                                colorFilter: const ColorFilter
                                                                    .mode(
                                                                    MyColors
                                                                        .primary2,
                                                                    BlendMode
                                                                        .srcIn),
                                                              ),
                                                              SizedBox(
                                                                width: 8.w,
                                                              ),
                                                              Text(
                                                                reward
                                                                    .totalPoint!,
                                                                style: textTheme.titleLarge!.copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        12.sp,
                                                                    color: MyColors
                                                                        .buttonColor),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                      const Spacer(),
                                                      Align(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: Text(
                                                          '${(reward.percentageCompleted.toInt())}/100',
                                                          style: textTheme
                                                              .titleLarge!
                                                              .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  fontSize:
                                                                      12.sp,
                                                                  color: MyColors
                                                                      .buttonColor),
                                                        ),
                                                      ),
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        child:
                                                            LinearProgressIndicator(
                                                          value: (reward
                                                                  .percentageCompleted /
                                                              100),
                                                          valueColor:
                                                              const AlwaysStoppedAnimation<
                                                                      Color>(
                                                                  MyColors
                                                                      .primary2),
                                                          // Color of the progress indicator
                                                          backgroundColor:
                                                              Colors.black
                                                                  .withOpacity(
                                                                      0.1),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                              separatorBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return SizedBox(width: 16.w);
                                              },
                                              itemCount: homeController
                                                  .upcomingRewardsModel!
                                                  .data
                                                  .length,
                                            ),
                                          )
                                        : const SizedBox.shrink()
                                    : Shimmer.fromColors(
                                        baseColor: MyColors.shimmerBaseColor,
                                        highlightColor:
                                            MyColors.shimmerHighlightColor,
                                        child: Container(
                                          height: 140.h,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 20.w),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: MyColors.shimmerBaseColor,
                                              boxShadow: [
                                                BoxShadow(
                                                    spreadRadius: 0,
                                                    blurRadius: 16,
                                                    offset: const Offset(0, 4),
                                                    color: Colors.black
                                                        .withOpacity(0.12))
                                              ]),
                                        ),
                                      )),
                                Obx(() => homeController.isUserStreakLoad.value
                                    ? Column(
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 20.w),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 36.w),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                      spreadRadius: 0,
                                                      blurRadius: 16,
                                                      offset:
                                                          const Offset(0, 4),
                                                      color: Colors.black
                                                          .withOpacity(0.12))
                                                ]),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      height: 36.h,
                                                      width: 36.h,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4),
                                                          color: MyColors
                                                              .splashColor),
                                                      child: SvgPicture.asset(
                                                          MyImgs.bigBadge),
                                                    ),
                                                    SizedBox(
                                                      width: 16.w,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          '${homeController.userStreakModel!.data.fantastic} days perfect!',
                                                          style: textTheme
                                                              .headlineSmall!
                                                              .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  fontSize:
                                                                      20.sp,
                                                                  color: MyColors
                                                                      .buttonColor),
                                                        ),
                                                        Text(
                                                          'Fantastic performance',
                                                          style: textTheme
                                                              .bodySmall!
                                                              .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize:
                                                                      14.sp,
                                                                  color: MyColors
                                                                      .hintText),
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
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 20.w),
                                            padding: EdgeInsets.only(
                                                top: 16.h,
                                                left: 13.w,
                                                right: 13.w,
                                                bottom: 28.w),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                      spreadRadius: 0,
                                                      blurRadius: 16,
                                                      offset:
                                                          const Offset(0, 4),
                                                      color: Colors.black
                                                          .withOpacity(0.12))
                                                ]),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      height: 36.h,
                                                      width: 36.h,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4),
                                                          color: MyColors
                                                              .splashColor),
                                                      child: SvgPicture.asset(
                                                          MyImgs.bigBadge),
                                                    ),
                                                    SizedBox(
                                                      width: 16.w,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          '21 days streak',
                                                          style: textTheme
                                                              .headlineSmall!
                                                              .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  fontSize:
                                                                      20.sp,
                                                                  color: MyColors
                                                                      .buttonColor),
                                                        ),
                                                        Text(
                                                          'Fantastic performance',
                                                          style: textTheme
                                                              .bodySmall!
                                                              .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize:
                                                                      14.sp,
                                                                  color: MyColors
                                                                      .hintText),
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
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemBuilder:
                                                          (context, index) {
                                                        var streak =
                                                            homeController
                                                                .userStreakModel!
                                                                .data
                                                                .steak[index];
                                                        String dayName =
                                                            DateFormat('EEEE')
                                                                .format(
                                                                    streak.day);
                                                        return Column(
                                                          children: [
                                                            Text(
                                                              dayName.substring(
                                                                  0, 2),
                                                              style: textTheme
                                                                  .bodySmall!
                                                                  .copyWith(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontSize:
                                                                          14.sp,
                                                                      color: MyColors
                                                                          .hintText),
                                                            ),
                                                            Expanded(
                                                              child: Checkbox(
                                                                  shape:
                                                                      const CircleBorder(),
                                                                  activeColor:
                                                                      MyColors
                                                                          .buttonColor,
                                                                  value: streak
                                                                      .achieved,
                                                                  onChanged:
                                                                      (value) {}),
                                                            )
                                                          ],
                                                        );
                                                      },
                                                      itemCount: homeController
                                                          .userStreakModel!
                                                          .data
                                                          .steak
                                                          .length),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                    : Shimmer.fromColors(
                                        baseColor: MyColors.shimmerBaseColor,
                                        highlightColor:
                                            MyColors.shimmerHighlightColor,
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 160.h,
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 20.w),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  color:
                                                      MyColors.shimmerBaseColor,
                                                  boxShadow: [
                                                    BoxShadow(
                                                        spreadRadius: 0,
                                                        blurRadius: 16,
                                                        offset:
                                                            const Offset(0, 4),
                                                        color: Colors.black
                                                            .withOpacity(0.12))
                                                  ]),
                                            ),
                                            SizedBox(
                                              height: 16.h,
                                            ),
                                            Container(
                                              height: 160.h,
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 20.w),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  color:
                                                      MyColors.shimmerBaseColor,
                                                  boxShadow: [
                                                    BoxShadow(
                                                        spreadRadius: 0,
                                                        blurRadius: 16,
                                                        offset:
                                                            const Offset(0, 4),
                                                        color: Colors.black
                                                            .withOpacity(0.12))
                                                  ]),
                                            ),
                                          ],
                                        ),
                                      )),
                              ],
                            )
                          ],
                        ),
                      );
                    } else {
                      return CreateNewChallenge();
                    }
                  } else {
                    return Shimmer.fromColors(
                      baseColor: MyColors.shimmerBaseColor,
                      highlightColor: MyColors.shimmerHighlightColor,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 40.h,
                          ),
                          Container(
                            height: 140.h,
                            margin: EdgeInsets.symmetric(horizontal: 20.w),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: MyColors.shimmerBaseColor,
                                boxShadow: [
                                  BoxShadow(
                                      spreadRadius: 0,
                                      blurRadius: 16,
                                      offset: const Offset(0, 4),
                                      color: Colors.black.withOpacity(0.12))
                                ]),
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          Container(
                            height: 160.h,
                            margin: EdgeInsets.symmetric(horizontal: 20.w),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: MyColors.shimmerBaseColor,
                                boxShadow: [
                                  BoxShadow(
                                      spreadRadius: 0,
                                      blurRadius: 16,
                                      offset: const Offset(0, 4),
                                      color: Colors.black.withOpacity(0.12))
                                ]),
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          Container(
                            height: 160.h,
                            margin: EdgeInsets.symmetric(horizontal: 20.w),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: MyColors.shimmerBaseColor,
                                boxShadow: [
                                  BoxShadow(
                                      spreadRadius: 0,
                                      blurRadius: 16,
                                      offset: const Offset(0, 4),
                                      color: Colors.black.withOpacity(0.12))
                                ]),
                          ),
                        ],
                      ),
                    );
                  }
                }),

                /// Overview Tab
                RefreshIndicator(
                  onRefresh: () {
                    Future.wait([
                      homeController.getOverview(),
                      homeController.getRecentTasks(),
                      homeController.getOverviewScore()
                    ]);
                    return Future(() => true);
                  },
                  color: MyColors.buttonColor,
                  child: ListView(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Overview',
                                  style: textTheme.headlineSmall!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20.sp,
                                      color: MyColors.buttonColor),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Obx(() => homeController
                                        .isOverviewScoreModelLoad.value
                                    ? Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 16,
                                                spreadRadius: 0,
                                                offset: const Offset(0, 4),
                                                color: Colors.black
                                                    .withOpacity(0.12),
                                              )
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            OverviewScoreWidget(
                                                percent:
                                                    "${homeController.overviewScoreModel!.data.weeklyRewards}%",
                                                scoreText: "Weekly Score"),
                                            OverviewScoreWidget(
                                                percent:
                                                    "+${homeController.overviewScoreModel!.data.monthlyRewards}%",
                                                scoreText: "Month"),
                                            OverviewScoreWidget(
                                                percent:
                                                    "+${homeController.overviewScoreModel!.data.yearlyRewards}%",
                                                scoreText: "Year"),
                                            OverviewScoreWidget(
                                                percent:
                                                    "${homeController.overviewScoreModel!.data.totalRewards}",
                                                scoreText: "Total Points"),
                                            RadialAxisWidget(
                                              progressBarValue: homeController
                                                  .overviewScoreModel!
                                                  .data
                                                  .completedPercentage,
                                            )
                                          ],
                                        ),
                                      )
                                    : shimmerWidget(65)),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Score',
                                      style: textTheme.headlineSmall!.copyWith(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16.sp,
                                          color: MyColors.buttonColor),
                                    ),
                                    Obx(
                                      () => Container(
                                        width: 85.w,
                                        height: 28.h,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.w),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: MyColors.buttonColor,
                                                width: 1.h),
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        child: DropdownButton<String>(
                                          value: homeController
                                              .selectedFilterType.value,
                                          elevation: 4,
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              color: MyColors.buttonColor),
                                          isExpanded: true,
                                          icon: const Icon((Icons
                                              .keyboard_arrow_down_outlined)),
                                          dropdownColor: Colors.white,
                                          underline: const SizedBox(),
                                          focusColor: Colors.white,
                                          items: [
                                            ...homeController.filterType
                                                .map((value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(
                                                  value,
                                                  style: TextStyle(
                                                      fontSize: 12.sp),
                                                ),
                                              );
                                            }).toList(),
                                          ],
                                          onChanged: (data) {
                                            homeController.selectedFilterType
                                                .value = data!;
                                            homeController.getOverview();
                                            //  authController.selectedGender = data;
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                // SvgPicture.asset(MyImgs.chart),
                                Center(
                                  child: Obx(() => homeController
                                          .isOverviewLoad.value
                                      ? SizedBox(
                                          height: 225,
                                          child: SfCartesianChart(
                                            primaryXAxis: const CategoryAxis(
                                              interval: 1,
                                            ),
                                            primaryYAxis: const NumericAxis(
                                              minimum: 0,
                                              maximum: 100,
                                              interval: 20,
                                            ),
                                            series: <CartesianSeries>[
                                              LineSeries<Map<String, dynamic>,
                                                  String>(
                                                dataSource: homeController
                                                    .overViewDataList,
                                                xValueMapper:
                                                    (Map<String, dynamic> data,
                                                            _) =>
                                                        data["key"],
                                                yValueMapper:
                                                    (Map<String, dynamic> data,
                                                            _) =>
                                                        data["value"],
                                                dataLabelSettings:
                                                    const DataLabelSettings(
                                                  isVisible: false,
                                                  textStyle: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blue,
                                                  ),
                                                  labelAlignment:
                                                      ChartDataLabelAlignment
                                                          .top,
                                                  useSeriesColor: false,
                                                ),
                                                markerSettings:
                                                    const MarkerSettings(
                                                  isVisible: true,
                                                  shape: DataMarkerType.circle,
                                                  borderWidth: 2,
                                                  color: MyColors.buttonColor,
                                                  borderColor:
                                                      MyColors.buttonColor,
                                                ),
                                                enableTooltip: true,
                                                color: MyColors.primary2,
                                              )
                                            ],
                                            tooltipBehavior:
                                                TooltipBehavior(enable: true),
                                          ),
                                        )
                                      : shimmerWidget(225)),
                                ),

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
                          Obx(
                            () => ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  if (homeController.isRecentTaskLoad.value) {
                                    if (homeController.recentTasksModel?.data ==
                                            null ||
                                        homeController
                                            .recentTasksModel!.data.isEmpty) {
                                      return Padding(
                                        padding: EdgeInsets.only(top: 100.h),
                                        child: const Center(
                                          child: Text(
                                            "No Recent Tasks yet",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                      );
                                    }

                                    var overview = homeController
                                        .recentTasksModel!.data[index];
                                    return CustomProgressWidget(
                                      name: overview.name,
                                      endedAt: overview.endedAt,
                                      earnedRewards: overview.earnRewards,
                                      totalRewards: overview.totalRewards,
                                      percentage: overview.percentageCompleted,
                                      id: overview.id,
                                      numberOfDays: overview.days,
                                      videoUrl: overview.description,
                                      description: overview.description,
                                      startedAt: overview.startedAt,
                                    );
                                  } else {
                                    return const CustomProgressBarWidgetShimmer();
                                  }
                                },
                                separatorBuilder: (context, index) => SizedBox(
                                      height: 16.h,
                                    ),
                                itemCount: homeController.isRecentTaskLoad.value
                                    ? homeController
                                            .recentTasksModel!.data.isEmpty
                                        ? 1
                                        : homeController.recentTasksModel!.data
                                                    .length >
                                                3
                                            ? 3
                                            : homeController
                                                .recentTasksModel!.data.length
                                    : 4),
                          )
                        ],
                      ),
                    ],
                  ),
                ),

                ///Task Tab
                RefreshIndicator(
                  onRefresh: () {
                    Future.wait([homeController.getRecentTasks()]);
                    return Future(() => true);
                  },
                  color: MyColors.buttonColor,
                  child: ListView(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20.w),
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
                          Obx(
                            () => ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                if (homeController.isRecentTaskLoad.value) {
                                  if (homeController.recentTasksModel?.data ==
                                          null ||
                                      homeController
                                          .recentTasksModel!.data.isEmpty) {
                                    return Padding(
                                      padding: EdgeInsets.only(top: 200.h),
                                      child: const Center(
                                        child: Text(
                                          "No Tasks yet",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    );
                                  }

                                  var overview = homeController
                                      .recentTasksModel!.data[index];
                                  return CustomProgressWidget(
                                    name: overview.name,
                                    endedAt: overview.endedAt,
                                    earnedRewards: overview.earnRewards,
                                    totalRewards: overview.totalRewards,
                                    percentage: overview.percentageCompleted,
                                    id: overview.id,
                                    numberOfDays: overview.days,
                                    videoUrl: overview.videoUrl,
                                    description: overview.description,
                                    startedAt: overview.startedAt,
                                  );
                                } else {
                                  return const CustomProgressBarWidgetShimmer();
                                }
                              },
                              separatorBuilder: (context, index) => SizedBox(
                                height: 16.h,
                              ),
                              itemCount: homeController.isRecentTaskLoad.value
                                  ? homeController
                                          .recentTasksModel!.data.isEmpty
                                      ? 1
                                      : homeController
                                          .recentTasksModel!.data.length
                                  : 4,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
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

  shimmerWidget(double height) {
    return Shimmer.fromColors(
      baseColor: MyColors.shimmerBaseColor,
      highlightColor: MyColors.shimmerHighlightColor,
      child: Container(
        height: height.h,
        // margin: EdgeInsets.symmetric(horizontal: 20.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: MyColors.shimmerBaseColor,
            boxShadow: [
              BoxShadow(
                  spreadRadius: 0,
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                  color: Colors.black.withOpacity(0.12))
            ]),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double y;
}
