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
    "Bronze",
    "Gold",
    "Silver",
    "100 points",
    "200 points",
    "300 points",
    "400 points",
    "500 points",
    "600 points",
  ];
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
          Expanded(
              child: RefreshIndicator(
            onRefresh: () async {
              await homeController.getUsersRewards(); // Await the Future
            },
            color: MyColors.buttonColor,
            child: GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 13.h,
                  childAspectRatio: 0.93,
                  crossAxisSpacing: 13.w),
              itemBuilder: (context, index) {
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
                        child: Container(
                          height: 60.h,
                          width: 60.h,
                          padding: EdgeInsets.all(12.h),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: MyColors.primary2),
                              color: Colors.white),
                          child: SvgPicture.asset(MyImgs.medal),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        pointsList[index],
                        style: textTheme.headlineLarge!.copyWith(
                            fontSize: 20.sp, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                );
              },
              itemCount: pointsList.length,
            ),
          ))
        ],
      ),
    );
  }
}
