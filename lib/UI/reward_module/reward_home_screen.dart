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

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Column(
        children: [
          // Container(
          //   margin: EdgeInsets.symmetric(horizontal: 20.w),
          //   padding: EdgeInsets.all(20.h),
          //   decoration: BoxDecoration(
          //       color: Colors.white,
          //       boxShadow: [
          //         BoxShadow(
          //             spreadRadius: 0,
          //             blurRadius: 12,
          //             offset: const Offset(2, 2),
          //             color: Colors.black.withOpacity(0.04))
          //       ],
          //       border: Border.all(color: MyColors.borderColor),
          //       borderRadius: BorderRadius.circular(12)),
          //   child: Column(
          //     children: [
          //       // Row(
          //       //   children: [
          //       //     Container(
          //       //       height: 64.h,
          //       //       width: 64.h,
          //       //       decoration: BoxDecoration(
          //       //           shape: BoxShape.circle,
          //       //           boxShadow: [
          //       //             BoxShadow(
          //       //                 blurRadius: 12,
          //       //                 offset: const Offset(2, 2),
          //       //                 color: Colors.black.withOpacity(0.04))
          //       //           ],
          //       //           color: Colors.white,
          //       //           border: Border.all(
          //       //               color: MyColors.purpleColor.withOpacity(0.2)),
          //       //           image:
          //       //               authController.userModel!.data.user.image == null
          //       //                   ? const DecorationImage(
          //       //                       image: AssetImage(MyImgs.dummyDp),
          //       //                       fit: BoxFit.cover)
          //       //                   : DecorationImage(
          //       //                       image: NetworkImage(authController
          //       //                           .userModel!.data.user.image),
          //       //                       fit: BoxFit.cover)),
          //       //     ),
          //       //     // Image.asset(MyImgs.dummyDp,scale: 3,),
          //       //     SizedBox(
          //       //       width: 12.w,
          //       //     ),
          //       //     Expanded(
          //       //       child: Column(
          //       //         crossAxisAlignment: CrossAxisAlignment.start,
          //       //         children: [
          //       //           Text(
          //       //             "${authController.userModel!.data.user.firstName} ${authController.userModel!.data.user.lastName}",
          //       //             style: textTheme.headlineLarge!.copyWith(
          //       //                 fontSize: 20.sp, fontWeight: FontWeight.w700),
          //       //           ),
          //       //           SizedBox(
          //       //             height: 8.h,
          //       //           ),
          //       //           Text(
          //       //             authController.userModel!.data.user.email,
          //       //             style: textTheme.headlineLarge!.copyWith(
          //       //                 fontSize: 14.sp, fontWeight: FontWeight.w400),
          //       //           ),
          //       //         ],
          //       //       ),
          //       //     ),
          //       //   ],
          //       // ),
          //       // SizedBox(height: 10.h),
          //       Container(
          //         width: double.infinity,
          //         child: Column(
          //           children: [
          //             Text(
          //               "Current Streak",
          //               style: textTheme.headlineLarge!.copyWith(
          //                   fontSize: 32.sp,
          //                   fontWeight: FontWeight.w700,
          //                   color: Colors.white),
          //             ),
          //             SizedBox(height: 10.h),
          //             Text(
          //               "Total Rewards Earned",
          //               style: textTheme.headlineLarge!.copyWith(
          //                   fontSize: 16.sp,
          //                   fontWeight: FontWeight.w700,
          //                   color: Colors.white.withOpacity(0.6)),
          //             ),
          //           ],
          //         ),
          //       ),
          //
          //       // Row(
          //       //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //       //   children: [
          //       //     Column(
          //       //       children: [
          //       //         Container(
          //       //           height: 60.h,
          //       //           width: 60.h,
          //       //           padding: EdgeInsets.all(12.h),
          //       //           decoration: const BoxDecoration(
          //       //             shape: BoxShape.circle,
          //       //             color: Color(0xffFFEFEA),
          //       //           ),
          //       //           child: SvgPicture.asset(MyImgs.bigBadge),
          //       //         ),
          //       //         Text(
          //       //           "22",
          //       //           style: textTheme.headlineLarge!.copyWith(
          //       //               fontSize: 32.sp, fontWeight: FontWeight.w700),
          //       //         ),
          //       //         Text(
          //       //           "BADGES",
          //       //           style: textTheme.headlineLarge!.copyWith(
          //       //               fontSize: 14.sp, fontWeight: FontWeight.w500),
          //       //         ),
          //       //       ],
          //       //     ),
          //       //     SizedBox(
          //       //       height: 84.h,
          //       //       child: VerticalDivider(
          //       //         thickness: 1.w,
          //       //         color: Colors.black.withOpacity(0.2),
          //       //       ),
          //       //     ),
          //       //     Column(
          //       //       children: [
          //       //         Container(
          //       //           height: 60.h,
          //       //           width: 60.h,
          //       //           padding: EdgeInsets.all(12.h),
          //       //           decoration: const BoxDecoration(
          //       //             shape: BoxShape.circle,
          //       //             color: Color(0xffDFEAFF),
          //       //           ),
          //       //           child: SvgPicture.asset(
          //       //             MyImgs.starFill,
          //       //           ),
          //       //         ),
          //       //         Text(
          //       //           "22",
          //       //           style: textTheme.headlineLarge!.copyWith(
          //       //               fontSize: 32.sp, fontWeight: FontWeight.w700),
          //       //         ),
          //       //         Text(
          //       //           "BADGES",
          //       //           style: textTheme.headlineLarge!.copyWith(
          //       //               fontSize: 14.sp, fontWeight: FontWeight.w500),
          //       //         ),
          //       //       ],
          //       //     ),
          //       //   ],
          //       // )
          //     ],
          //   ),
          // ),
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
              child: GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            // Number of cross-axis (horizontal) children to include in the GridView
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 13.h,
                childAspectRatio: 0.93,
                crossAxisSpacing: 13.w),
            // Provide a builder function that generates the items dynamically
            itemBuilder: (context, index) {
              // Return a simple Container with some text inside
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
                      "Gold",
                      style: textTheme.headlineLarge!.copyWith(
                          fontSize: 20.sp, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              );
            },
            // Set the total number of items in the GridView
            itemCount: 20,
          ))
        ],
      ),
    );
  }
}
