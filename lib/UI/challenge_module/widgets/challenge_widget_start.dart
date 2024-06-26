import 'package:enfil_libre/data/models/get_user_challenges/get_user_challenges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../controllers/challenge_controller/challenge_contoller.dart';
import '../../../data/models/get_challenges_model/get_challenges_model.dart';
import '../../values/my_colors.dart';
import '../../values/my_imgs.dart';
import '../../widgets/custom_button.dart';
import '../start_challege/start_challege_screen.dart';

class ChallengeWidgetStart extends StatelessWidget {
  ChallengeWidgetStart({super.key, required this.index, this.challenge});

  final int index;
  final Challenges? challenge;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
            color: MyColors.pendingColor,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                  spreadRadius: 0,
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                  color: Colors.black.withOpacity(0.12))
            ],
            border: Border.all(color: MyColors.buttonColor.withOpacity(0.12))),
        child: Column(
          children: [
            Text(
              challenge!.name,
              style: textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 16.sp,
                  color: MyColors.buttonColor),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
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
                          MyColors.buttonColor.withOpacity(0.4),
                          BlendMode.srcIn),
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      challenge!.rewardPoint,
                      style: textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp,
                          color: MyColors.buttonColor),
                    ),
                  ],
                ),
                // SizedBox(
                //   width: 12.w,
                // ),
                // Row(
                //   children: [
                //     Icon(
                //       Icons.access_time,
                //       color: MyColors.buttonColor.withOpacity(0.4),
                //     ),
                //     SizedBox(
                //       width: 8.w,
                //     ),
                //     Text(
                //       '2 days left',
                //       style: textTheme.titleLarge!.copyWith(
                //           fontWeight: FontWeight.w600,
                //           fontSize: 12.sp,
                //           color: MyColors.buttonColor),
                //     ),
                //   ],
                // ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            // Row(
            //   children: [
            //     SvgPicture.asset(
            //       MyImgs.calender,
            //       height: 20.h,
            //       colorFilter: ColorFilter.mode(
            //           MyColors.buttonColor.withOpacity(0.4), BlendMode.srcIn),
            //     ),
            //     SizedBox(
            //       width: 8.w,
            //     ),
            //     Text(
            //       '07:30 PM - 09:30 PM ',
            //       style: textTheme.titleLarge!.copyWith(
            //           fontWeight: FontWeight.w600,
            //           fontSize: 12.sp,
            //           color: MyColors.buttonColor),
            //     ),
            //   ],
            // ),
            const Spacer(),
            CustomButton(
              text: "START",
              onPressed: () {
                Get.find<ChallengeController>().startChallenge.value = true;
                Get.to(() => StartChallengeScreen(challenges: challenge!));

                // Get.find<ChallengeController>()
                //     .getUserChallengeHistory(challenge!.id.toString());
              },
              height: 32.h,
              color: MyColors.buttonColor,
              borderColor: MyColors.primary2,
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
            )
          ],
        ));
  }
}
