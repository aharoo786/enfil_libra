import 'package:enfil_libre/data/models/get_challenges_model/get_challenges_model.dart';
import 'package:enfil_libre/data/models/get_user_challenges/get_user_challenges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../../../controllers/challenge_controller/challenge_contoller.dart';
import '../../values/constants.dart';
import '../../values/my_colors.dart';
import '../../values/my_imgs.dart';
import '../../widgets/custom_button.dart';
import '../start_challege/start_challege_screen.dart';

class ChallengeWidget extends StatelessWidget {
  ChallengeWidget({super.key, required this.index, this.userChallenges});

  final int index;
  final Record? userChallenges;

  final List<Color> myColors = [
    MyColors.pendingColor,
    MyColors.inProgressColor,
    MyColors.finishedColor,
    MyColors.finishedColor,
  ];
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        if (userChallenges!.status == Constants.process) {
          Get.find<ChallengeController>().startChallenge.value=false;
          Get.to(() => StartChallengeScreen(
                challenges: Challenges(
                  id: userChallenges!.id,
                  name: userChallenges!.name,
                  rewardPoint: userChallenges!.totalRewards,
                  numberOfDay: userChallenges!.days,
                  videoUrl: userChallenges!.videoUrl,
                  description: userChallenges!.description,
                  startedDate: userChallenges!.startedAt,
                  endedDate: userChallenges!.endedAt,
                ),
              ));

          Get.find<ChallengeController>()
              .getUserChallengeHistory(userChallenges!.id.toString());
        }
      },
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          decoration: BoxDecoration(
              color: userChallenges!.status == Constants.process
                  ? myColors[1]
                  : userChallenges!.status == Constants.completed
                      ? myColors[2]
                      : myColors[0],
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                    spreadRadius: 0,
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                    color: Colors.black.withOpacity(0.12))
              ],
              border:
                  Border.all(color: MyColors.buttonColor.withOpacity(0.12))),
          child: Column(
            children: [
              Text(
                userChallenges!.name,
                style: textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 16.sp,
                    color: MyColors.buttonColor),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
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
                        userChallenges!.earnRewards,
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
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          color: MyColors.buttonColor.withOpacity(0.4),
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Expanded(
                          child: Text(
                            userChallenges!.endedAt,
                            style: textTheme.titleLarge!.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 12.sp,
                                color: MyColors.buttonColor),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
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
                        MyColors.buttonColor.withOpacity(0.4), BlendMode.srcIn),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Expanded(
                    child: Text(
                      '${userChallenges!.startedAt} - ${userChallenges!.endedAt}',
                      style: textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp,
                          color: MyColors.buttonColor),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              userChallenges!.status == Constants.process
                  ? Column(
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            '${userChallenges!.percentageCompleted}%',
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
                            value: userChallenges!.percentageCompleted / 100,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                MyColors
                                    .primary2), // Color of the progress indicator
                            backgroundColor: Colors.black.withOpacity(0.1),
                          ),
                        )
                      ],
                    )
                  : CustomButton(
                      text: userChallenges!.status == Constants.completed
                          ? "Finished"
                          : "Failed",
                      onPressed: () {
                        Get.find<ChallengeController>().startChallenge.value=false;

                        Get.to(() => StartChallengeScreen(
                              challenges: Challenges(
                                id: userChallenges!.id,
                                name: userChallenges!.name,
                                rewardPoint: userChallenges!.totalRewards,
                                numberOfDay: userChallenges!.days,
                                videoUrl: userChallenges!.videoUrl,
                                description: userChallenges!.description,
                                startedDate: userChallenges!.startedAt,
                                endedDate: userChallenges!.endedAt,
                              ),
                              showReward: true,
                              earnedRewards: userChallenges!.earnRewards,
                            ));
                      },
                      height: 32.h,
                      color: const Color(0xff4ECB71),
                      borderColor: const Color(0xff4ECB71),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                    )
            ],
          )),
    );
  }
}
