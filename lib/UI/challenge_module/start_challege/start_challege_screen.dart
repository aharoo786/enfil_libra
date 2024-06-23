import 'package:enfil_libre/UI/widgets/app_bar_widget.dart';
import 'package:enfil_libre/UI/widgets/custom_button.dart';
import 'package:enfil_libre/UI/widgets/toasts.dart';
import 'package:enfil_libre/controllers/challenge_controller/challenge_contoller.dart';
import 'package:enfil_libre/data/models/get_challenges_model/get_challenges_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shimmer/shimmer.dart';
import 'package:signature/signature.dart';
import 'package:intl/intl.dart';

import '../../values/my_colors.dart';
import '../../values/my_imgs.dart';
import '../video_player/video_player.dart';

class StartChallengeScreen extends StatelessWidget {
  StartChallengeScreen(
      {super.key,
      required this.challenges,
      this.earnedRewards,
      this.fromStart = false,
      this.showReward = false});

  final Challenges challenges;
  bool fromStart;
  bool showReward;
  String? earnedRewards;

  final ChallengeController challengeController = Get.find();
  final SignatureController signatureControllerController = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.red,
    exportBackgroundColor: Colors.blue,
  );

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Scaffold(
        backgroundColor: MyColors.splashColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.h + kToolbarHeight,
            ),
            Expanded(
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 4,
                              blurRadius: 4,
                              offset: const Offset(0, 4),
                              color: Colors.black.withOpacity(0.08))
                        ],
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(32),
                            topRight: Radius.circular(32))),
                    child: ListView(
                      padding: EdgeInsets.only(
                          bottom: 10.h, left: 20.w, right: 20.w),
                      children: [
                        Column(
                          children: [
                            HelpingWidgets().bodyAppBar(challenges.name),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              challenges.description,
                              style: textTheme.headlineSmall!.copyWith(
                                  fontWeight: FontWeight.w700, fontSize: 20.sp),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Container(
                              height: 175.h,
                              width: MediaQuery.of(context).size.width,
                              padding: challenges.videoUrl == null
                                  ? EdgeInsets.symmetric(horizontal: 20.w)
                                  : null,
                              color: challenges.videoUrl == null
                                  ? Colors.black
                                  : Colors.transparent,
                              child: challenges.videoUrl == null
                                  ? const Center(child: Icon(Icons.play_arrow,color: Colors.white,size: 40,))
                                  : PlayVideoFromYoutube(
                                      url: challenges.videoUrl!,
                                    ),
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height: 20.h,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12.w, vertical: 24.h),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            spreadRadius: 0,
                                            blurRadius: 16,
                                            offset: const Offset(0, 4),
                                            color:
                                                Colors.black.withOpacity(0.12))
                                      ]),
                                  child: Column(
                                    children: [
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
                                            'Duration',
                                            style:
                                                textTheme.titleLarge!.copyWith(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12.sp,
                                              color: MyColors.buttonColor
                                                  .withOpacity(0.4),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 12.w,
                                          ),
                                          Text(
                                            '${challenges.numberOfDay} days',
                                            style:
                                                textTheme.titleLarge!.copyWith(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12.sp,
                                              color: MyColors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 15.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Row(
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
                                                  'Start date',
                                                  style: textTheme.titleLarge!
                                                      .copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12.sp,
                                                    color: MyColors.buttonColor
                                                        .withOpacity(0.4),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 12.w,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    challenges.startedDate,
                                                    style: textTheme.titleLarge!
                                                        .copyWith(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 12.sp,
                                                      color: MyColors.black,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // SizedBox(
                                          //   width: 12.w,
                                          // ),

                                          Expanded(
                                            child: Row(
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
                                                  'End date',
                                                  style: textTheme.titleLarge!
                                                      .copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12.sp,
                                                    color: MyColors.buttonColor
                                                        .withOpacity(0.4),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 12.w,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    challenges.endedDate,
                                                    style: textTheme.titleLarge!
                                                        .copyWith(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 12.sp,
                                                      color: MyColors.black,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 15.h,
                                      ),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            MyImgs.miniBadge,
                                            height: 20.h,
                                            colorFilter: const ColorFilter.mode(
                                                MyColors.primary2,
                                                BlendMode.srcIn),
                                          ),
                                          SizedBox(
                                            width: 8.w,
                                          ),
                                          Text(
                                            "Points you will earn",
                                            style:
                                                textTheme.titleLarge!.copyWith(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12.sp,
                                              color: MyColors.buttonColor
                                                  .withOpacity(0.4),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 12.w,
                                          ),
                                          Text(
                                            challenges.rewardPoint,
                                            style:
                                                textTheme.titleLarge!.copyWith(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12.sp,
                                              color: MyColors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                fromStart
                                    ? const SizedBox.shrink()
                                    : showReward
                                        ? Column(
                                            children: [
                                              SizedBox(
                                                height: 20.h,
                                              ),
                                              Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 16.w,
                                                      vertical: 21.h),
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
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 130.w),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SvgPicture.asset(
                                                              MyImgs.medal,
                                                              height: 100.h,
                                                            ),
                                                            Spacer(),
                                                            CustomButton(
                                                              text: "Finished",
                                                              onPressed: () {},
                                                              color: MyColors
                                                                  .finishedColor,
                                                              borderColor: MyColors
                                                                  .finishedColor,
                                                              textColor:
                                                                  const Color(
                                                                      0xff4ECB71),
                                                              width: 90.w,
                                                              height: 32.h,
                                                              fontSize: 12.sp,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(height: 5.h),
                                                      Text(
                                                        "You have earned",
                                                        style: textTheme
                                                            .headlineSmall!
                                                            .copyWith(
                                                                fontSize: 12.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.3)),
                                                      ),
                                                      Text(
                                                        "${earnedRewards ?? 0} Points",
                                                        style: textTheme
                                                            .headlineSmall!
                                                            .copyWith(
                                                          fontSize: 32.sp,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                      )
                                                    ],
                                                  )),
                                            ],
                                          )
                                        : Obx(() => challengeController
                                                .isUserChallengeHistoryLoad
                                                .value
                                            ? ListView.separated(
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                // shrinkWrap: true,
                                                itemBuilder: (context, index) {
                                                  var challengeHistory =
                                                      challengeController
                                                          .userChallengeHistory!
                                                          .data
                                                          .challengeHistories[index];
                                                  bool isAfter = compareDates(
                                                      challengeHistory.endedAt,
                                                      true);
                                                  bool isBefore = compareDates(
                                                      challengeHistory.endedAt,
                                                      false);

                                                  return GestureDetector(
                                                    onTap: () {
                                                      if (!isAfter &&
                                                          !isBefore) {
                                                        if (challengeHistory
                                                                .status ==
                                                            "1") {
                                                          CustomToast.failToast(
                                                              msg:
                                                                  "You have already subscribed");
                                                        } else {
                                                          signatureDialog(
                                                              context);
                                                        }
                                                      }
                                                    },
                                                    child: Container(
                                                      height: 52.h,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 12.w),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          color: Colors.white,
                                                          boxShadow: [
                                                            BoxShadow(
                                                                spreadRadius: 0,
                                                                blurRadius: 16,
                                                                offset:
                                                                    const Offset(
                                                                        0, 4),
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.12))
                                                          ]),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              SvgPicture.asset(
                                                                MyImgs.calender,
                                                                height: 20.h,
                                                                colorFilter: const ColorFilter
                                                                    .mode(
                                                                    MyColors
                                                                        .buttonColor,
                                                                    BlendMode
                                                                        .srcIn),
                                                              ),
                                                              SizedBox(
                                                                width: 8.w,
                                                              ),
                                                              Text(
                                                                DateFormat(
                                                                        "dd/MM/yyyy")
                                                                    .format(challengeHistory
                                                                        .endedAt),
                                                                style: textTheme.titleLarge!.copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    fontSize:
                                                                        16.sp,
                                                                    color: MyColors
                                                                        .black),
                                                              ),
                                                            ],
                                                          ),
                                                          checkWidget(
                                                              isAfter,
                                                              isBefore,
                                                              challengeHistory
                                                                  .status)
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                                separatorBuilder:
                                                    (context, index) =>
                                                        SizedBox(
                                                          height: 16.h,
                                                        ),
                                                itemCount: challengeController
                                                    .userChallengeHistory!
                                                    .data
                                                    .challengeHistories
                                                    .length)
                                            : Shimmer.fromColors(
                                                baseColor: Colors.grey[300]!,
                                                highlightColor:
                                                    Colors.grey[100]!,
                                                child: ListView.separated(
                                                  shrinkWrap: true,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  itemBuilder:
                                                      (context, index) =>
                                                          Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 12.w,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      color: Colors.white,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          spreadRadius: 0,
                                                          blurRadius: 16,
                                                          offset: const Offset(
                                                              0, 4),
                                                          color: Colors.black
                                                              .withOpacity(
                                                                  0.12),
                                                        ),
                                                      ],
                                                    ),
                                                    child: Container(
                                                      height: 30.h,
                                                      width: double.infinity,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  separatorBuilder:
                                                      (context, index) =>
                                                          SizedBox(
                                                    height: 16.h,
                                                  ),
                                                  itemCount: 4,
                                                ),
                                              ))
                              ],
                            ),
                          ],
                        ),
                      ],
                    )))
          ],
        ),
        bottomNavigationBar: fromStart
            ? Container(
                color: Colors.white,
                padding: EdgeInsets.only(
                    bottom: 40.h, left: 55.w, right: 55.w, top: 10.h),
                child: CustomButton(
                    text: "Start",
                    onPressed: () {
                      signatureDialog(context);
                    }))
            : null);
  }

  bool compareDates(DateTime challengeEndDate, bool isAfterTrue) {
    DateTime now = DateTime.now();
    DateTime currentDate = DateTime(now.year, now.month, now.day);
    DateTime challengeEndDateOnly = DateTime(
        challengeEndDate.year, challengeEndDate.month, challengeEndDate.day);
    bool isAfter;
    if (isAfterTrue) {
      isAfter = challengeEndDateOnly.isAfter(currentDate);
    } else {
      isAfter = challengeEndDateOnly.isBefore(currentDate);
    }

    return isAfter;
  }

  Widget checkWidget(bool isAfter, bool isBefore, String status) {
    if (isAfter) {
      return Padding(
        padding: EdgeInsets.only(right: 15.w),
        child: SvgPicture.asset(MyImgs.lockIcon),
      );
    } else if (status == "0" && isBefore) {
      return Padding(
        padding: EdgeInsets.only(right: 15.w),
        child: const Icon(
          Icons.clear,
          color: Colors.red,
        ),
      );
    } else {
      return Checkbox(
          shape: const CircleBorder(),
          activeColor: const Color(0xff4ECB71),
          value: status == "1" ? true : false,
          onChanged: (value) {});
    }
  }

  signatureDialog(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    signatureControllerController.clear();
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
              height: 350.h,
              width: 400,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "I commit to following the challenge and going to the end",
                    style: textTheme.headlineSmall!
                        .copyWith(fontSize: 20.sp, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 35.h,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Signature(
                      controller: signatureControllerController,
                      // width: 300,
                      height: 130.h,
                      backgroundColor: MyColors.inProgressColor,
                    ),
                  ),
                  SizedBox(
                    height: 35.h,
                  ),
                  CustomButton(
                      text: "Start",
                      onPressed: () {
                        if (signatureControllerController.isEmpty) {
                          CustomToast.failToast(
                              msg: "Please provide signature");
                        } else {
                          if (fromStart) {
                            challengeController.addChallenge(
                                challenges.id.toString(), challenges);
                          } else {
                            challengeController.getUserChallengeCheckIn(
                                challenges.id.toString());
                          }
                        }
                      })
                ],
              ),
            ),
          );
        });
  }
}
