import 'package:enfil_libre/UI/widgets/app_bar_widget.dart';
import 'package:enfil_libre/UI/widgets/custom_button.dart';
import 'package:enfil_libre/UI/widgets/toasts.dart';
import 'package:enfil_libre/controllers/challenge_controller/challenge_contoller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shimmer/shimmer.dart';
import 'package:signature/signature.dart';

import '../../values/my_colors.dart';
import '../../values/my_imgs.dart';
import '../video_player/video_player.dart';

class StartChallengeScreen extends StatelessWidget {
  StartChallengeScreen({super.key});

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
                  child: Obx(() {
                    if (challengeController.isChallengesLoad.value) {
                      var challenge =
                          challengeController.challengesModel!.data[0];
                      return Column(
                        children: [
                          HelpingWidgets().bodyAppBar(challenge.name),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            challenge.description,
                            style: textTheme.headlineSmall!.copyWith(
                                fontWeight: FontWeight.w700, fontSize: 24.sp),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          SizedBox(
                            height: 175.h,
                            width: MediaQuery.of(context).size.width,
                            child: PlayVideoFromYoutube(
                              url: challenge.videoUrl,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20.h,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12.w, vertical: 24.h),
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 20.w),
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
                                            '${challenge.numberOfDay} days',
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
                                              Text(
                                                '02 days',
                                                style: textTheme.titleLarge!
                                                    .copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12.sp,
                                                  color: MyColors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 12.w,
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
                                              Text(
                                                '02 days',
                                                style: textTheme.titleLarge!
                                                    .copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12.sp,
                                                  color: MyColors.black,
                                                ),
                                              ),
                                            ],
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
                                            challenge.rewardPoint,
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
                                Expanded(
                                  child: ListView.separated(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.w, vertical: 20.h),
                                      physics: const BouncingScrollPhysics(),
                                      // shrinkWrap: true,
                                      itemBuilder: (context, index) =>
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 12.w),
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
                                                      colorFilter:
                                                          const ColorFilter
                                                                  .mode(
                                                              MyColors
                                                                  .buttonColor,
                                                              BlendMode.srcIn),
                                                    ),
                                                    SizedBox(
                                                      width: 8.w,
                                                    ),
                                                    Text(
                                                      'End date',
                                                      style: textTheme
                                                          .titleLarge!
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize: 16.sp,
                                                              color: MyColors
                                                                  .black),
                                                    ),
                                                  ],
                                                ),
                                                Checkbox(
                                                    shape: const CircleBorder(),
                                                    activeColor:
                                                        const Color(0xff4ECB71),
                                                    value: true,
                                                    onChanged: (value) {}),
                                              ],
                                            ),
                                          ),
                                      separatorBuilder: (context, index) =>
                                          SizedBox(
                                            height: 16.h,
                                          ),
                                      itemCount: 4),
                                )
                              ],
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: Column(
                            children: [
                              HelpingWidgets().bodyAppBar("Title"),
                              // SizedBox(
                              //   height: 20.h,
                              // ),
                              // Container(
                              //   height: 40.h,
                              //   width: double.infinity,
                              //   color: Colors.white,
                              // ),
                              SizedBox(
                                height: 10.h,
                              ),

                              Container(
                                height: 30.h,
                                width: double.infinity,
                                color: Colors.white,
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Container(
                                height: 175.h,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.white,
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Container(
                                      height: 140.h,
                                      width: double.infinity,
                                      color: Colors.white,
                                    ),
                                    Expanded(
                                      child: ListView.separated(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 20.h,
                                        ),
                                        physics: const BouncingScrollPhysics(),
                                        itemBuilder: (context, index) =>
                                            Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 12.w,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                spreadRadius: 0,
                                                blurRadius: 16,
                                                offset: const Offset(0, 4),
                                                color: Colors.black
                                                    .withOpacity(0.12),
                                              ),
                                            ],
                                          ),
                                          child: Container(
                                            height: 30.h,
                                            width: double.infinity,
                                            color: Colors.white,
                                          ),
                                        ),
                                        separatorBuilder: (context, index) =>
                                            SizedBox(
                                          height: 16.h,
                                        ),
                                        itemCount: 4,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  })))
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding:
            EdgeInsets.only(bottom: 40.h, left: 55.w, right: 55.w, top: 10.h),
        child:  Obx(
            ()=>  challengeController.isChallengesLoad.value? CustomButton(
              text: "Start",
              onPressed: () {
                signatureControllerController.clear();
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Container(
                          // height: 400,
                          // width: 400,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12)),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "I commit to following the challenge and going to the end",
                                style: textTheme.headlineSmall!.copyWith(
                                    fontSize: 20.sp, fontWeight: FontWeight.w700),
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
                              CustomButton(text: "Start", onPressed: () {
                                if(signatureControllerController.isEmpty){
                                  CustomToast.failToast(msg: "Please provide signature");
                                }
                                else{
                                  challengeController.addChallenge(challengeController.challengesModel!.data[0].id.toString());
                                }
                              })
                            ],
                          ),
                        ),
                      );
                    });
              })              :Shimmer.fromColors(baseColor: MyColors.shimmerBaseColor, highlightColor: MyColors.shimmerHighlightColor, child: CustomButton(text: '', onPressed: () {  },color: MyColors.shimmerBaseColor,))

        )
      ),
    );
  }
}
