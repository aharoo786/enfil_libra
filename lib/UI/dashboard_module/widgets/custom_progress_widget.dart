import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../controllers/challenge_controller/challenge_contoller.dart';
import '../../../data/models/get_challenges_model/get_challenges_model.dart';
import '../../challenge_module/start_challege/start_challege_screen.dart';
import '../../values/my_colors.dart';
import '../../values/my_imgs.dart';

class CustomProgressWidget extends StatelessWidget {
  const CustomProgressWidget(
      {super.key,
      this.name,
      this.percentage,
      this.earnedRewards,
      this.totalRewards,
      required this.endedAt,
      required this.id,
      required this.numberOfDays,
      required this.videoUrl,
      required this.description,
      required this.startedAt});
  final String? name;
  final String numberOfDays;
  final String videoUrl;
  final String description;
  final int id;
  final String? earnedRewards;
  final String? totalRewards;
  final String endedAt;
  final String startedAt;
  final int? percentage;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return GestureDetector(
      onTap: () {
        Get.find<ChallengeController>().startChallenge.value = false;

        Get.to(() => StartChallengeScreen(
              challenges: Challenges(
                id: id,
                name: name!,
                rewardPoint: totalRewards!,
                numberOfDay: numberOfDays,
                videoUrl: videoUrl,
                description: description,
                startedDate: startedAt,
                endedDate: endedAt,
              ),
            ));

        Get.find<ChallengeController>().getUserChallengeHistory(id.toString());
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        padding: EdgeInsets.all(12.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            border: Border.all(color: Colors.black),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name ?? 'Your next reward',
                  style: textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                      color: MyColors.buttonColor),
                ),
                Text(
                  '${earnedRewards ?? "0"}/${totalRewards ?? "100"}',
                  style: textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.w300,
                      fontSize: 16.sp,
                      color: MyColors.buttonColor),
                ),
                // SvgPicture.asset(MyImgs.rewardBig)
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      MyImgs.calender,
                      height: 20.h,
                      colorFilter: ColorFilter.mode(
                          MyColors.buttonColor.withOpacity(0.4),
                          BlendMode.srcIn),
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      endedAt ?? '2 days left',
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
                      colorFilter: ColorFilter.mode(
                          MyColors.buttonColor.withOpacity(0.4),
                          BlendMode.srcIn),
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      earnedRewards ?? "0",
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
              height: 5.h,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                '${percentage ?? "0"}%',
                style: textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 12.sp,
                    color: MyColors.buttonColor),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: LinearProgressIndicator(
                minHeight: 8.h,
                value: percentage == null ? 0.0 : percentage! / 100,
                valueColor: const AlwaysStoppedAnimation<Color>(
                    MyColors.primary2), // Color of the progress indicator
                backgroundColor: Colors.black.withOpacity(0.1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
