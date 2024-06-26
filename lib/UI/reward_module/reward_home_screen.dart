import 'package:enfil_libre/controllers/auth_controller/auth_controller.dart';
import 'package:enfil_libre/controllers/home_controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shimmer/shimmer.dart';

import '../values/my_colors.dart';
import '../values/my_imgs.dart';

class RewardHomeScreen extends StatelessWidget {
  RewardHomeScreen({super.key});
  final AuthController authController = Get.find();
  final HomeController homeController = Get.find();
  final pointsList = [
    MyImgs.bronzeMedal,
    MyImgs.silverMedal,
    MyImgs.goldMedal,
  ];
  final pointsText = ["Bronze", "Silver", "Gold"];
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: MyColors.buttonColor,
            child: Column(
              children: [
                Obx(() => homeController.isUsersRewardsLoad.value
                    ? Text(
                        "${homeController.userRewardsModel!.data.reward} Coins",
                        style: textTheme.headlineLarge!.copyWith(
                            fontSize: 32.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      )
                    : Shimmer.fromColors(
                        baseColor: MyColors.shimmerBaseColor,
                        highlightColor: MyColors.shimmerHighlightColor,
                        child: Container(
                          height: 50.h,
                          width: 200.w,
                          color: MyColors.shimmerBaseColor,
                        ),
                      )),
                SizedBox(height: 10.h),
                Text(
                  "Total Rewards Earned",
                  style: textTheme.headlineLarge!.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white.withOpacity(0.6)),
                ),
                SizedBox(height: 35.h),
              ],
            ),
          ),
          SizedBox(
            height: 40.h,
          ),
          Obx(()=>homeController.rewardValue.value < 50?Padding(
            padding: EdgeInsets.only(top: 150.h),
            child: SvgPicture.asset(MyImgs.noBadge),
          ): Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  await homeController.getUsersRewards(); // Await the Future
                },
                color: MyColors.buttonColor,
                child: Obx(
                      () => GridView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 13.h,
                        childAspectRatio: 0.93,
                        crossAxisSpacing: 13.w),
                    itemBuilder: (context, index) {
                      if (homeController.isUsersRewardsLoad.value) {
                        return Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: MyColors.borderColor),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 0,
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                  color: Colors.black.withOpacity(0.12))
                            ],
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                child: SvgPicture.asset(pointsList[index]),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                pointsText[index],
                                style: textTheme.headlineLarge!.copyWith(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Shimmer.fromColors(
                            baseColor: MyColors.shimmerBaseColor,
                            highlightColor: MyColors.shimmerHighlightColor,
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: MyColors.shimmerBaseColor,
                                border:
                                Border.all(color: MyColors.borderColor),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                      spreadRadius: 0,
                                      blurRadius: 8,
                                      offset: const Offset(0, 4),
                                      color: Colors.black.withOpacity(0.12))
                                ],
                              ),
                            ));
                      }
                    },
                    itemCount: !homeController.isUsersRewardsLoad.value
                        ? 3
                        : homeController.rewardValue.value >= 50 &&
                        homeController.rewardValue.value < 100
                        ? 1
                        : homeController.rewardValue.value >= 100 &&
                        homeController.rewardValue.value < 150
                        ? 2
                        : pointsList.length,
                  ),
                ),
              )))

        ],
      ),
    );
  }
}
