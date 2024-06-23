import 'package:enfil_libre/UI/challenge_module/start_challege/start_challege_screen.dart';
import 'package:enfil_libre/UI/challenge_module/widgets/challenge_widget.dart';
import 'package:enfil_libre/UI/widgets/custom_button.dart';
import 'package:enfil_libre/controllers/challenge_controller/challenge_contoller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shimmer/shimmer.dart';

import '../../challenge_module/widgets/challenge_widget_start.dart';
import '../../values/my_colors.dart';
import '../../values/my_imgs.dart';
import '../widgets/custom_progress_widget.dart';

class MyChallengesScreen extends StatelessWidget {
  MyChallengesScreen({super.key, this.tabIndex = 0});
  final int tabIndex;
  final ChallengeController challengeController = Get.find();
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: MyColors.splashColor,
      body: DefaultTabController(
        length: 4,
        initialIndex: tabIndex,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.h,
            ),
            Expanded(
                child: Container(
                    decoration: const BoxDecoration(
                        // boxShadow: [
                        //   BoxShadow(
                        //       spreadRadius: 4,
                        //       blurRadius: 4,
                        //       offset: const Offset(0, 0),
                        //       color: Colors.black.withOpacity(0.08))
                        // ],
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(32),
                            topRight: Radius.circular(32))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 40.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20.w),
                          child: Text(
                            'My Challenges',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 20.sp,
                                color: MyColors.buttonColor),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        SizedBox(
                          height: 30.h,
                          child: TabBar(
                              // padding: const EdgeInsets.only(right: 100),

                              labelColor: MyColors.buttonColor,
                              labelPadding: EdgeInsets.only(left: 28.w),
                              isScrollable: true,
                              unselectedLabelColor:
                                  Colors.black.withOpacity(0.4),
                              indicatorSize: TabBarIndicatorSize.label,
                              labelStyle: TextStyle(
                                  fontSize: 16.sp, fontWeight: FontWeight.w700),
                              indicatorColor: MyColors.buttonColor,
                              tabAlignment: TabAlignment.start,
                              tabs: const [
                                Tab(
                                  text: "All",
                                ),
                                Tab(
                                  text: "In progress",
                                ),
                                Tab(
                                  text: "Finished",
                                ),
                                Tab(
                                  text: "Failed",
                                ),
                              ]),
                        ),
                        Expanded(
                            child: TabBarView(
                          children: [
                            ///Alll Tab
                            Obx(() => challengeController.isChallengesLoad.value
                                ? RefreshIndicator(
                                    onRefresh: () {
                                      Future.wait([
                                        challengeController
                                            .getChallengesScreen(),
                                      ]);
                                      return Future(() => true);

                                    },
                              color: MyColors.buttonColor,
                                    child: GridView.builder(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 20.h, horizontal: 20.w),
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2, // Number of columns
                                        crossAxisSpacing:
                                            14.w, // Spacing between columns
                                        mainAxisSpacing:
                                            24.h, // Spacing between rows
                                      ),
                                      itemCount: challengeController
                                          .challengesModel!.data.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        var userChallenge = challengeController
                                            .challengesModel!.data[index];
                                        return ChallengeWidgetStart(
                                          index: index,
                                          challenge: userChallenge,
                                        );
                                      },
                                    ),
                                  )
                                : RefreshIndicator(
                                onRefresh: () {
                                  Future.wait([
                                    challengeController
                                        .getChallengesScreen(),
                                  ]);
                                  return Future(() => true);

                                },
                                color: MyColors.buttonColor,
                                child: shimmerChallenge())),

                            /// in Progress
                            Obx(() => challengeController.isUserChallenges.value
                                ? RefreshIndicator(
                                    onRefresh: () {
                                      Future.wait([
                                        challengeController
                                            .getUserChallengesFunc(),
                                      ]);
                                      return Future(() => true);
                                    },
                              color: MyColors.buttonColor,
                                    child: GridView.builder(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 20.h, horizontal: 20.w),
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2, // Number of columns
                                        crossAxisSpacing:
                                            14.w, // Spacing between columns
                                        mainAxisSpacing:
                                            24.h, // Spacing between rows
                                      ),
                                      itemCount:
                                          challengeController.inProgress.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        var userChallenge = challengeController
                                            .inProgress[index];
                                        return ChallengeWidget(
                                          index: index,
                                          userChallenges: userChallenge,
                                        );
                                      },
                                    ),
                                  )
                                : shimmerChallenge()),

                            ///Finished
                            Obx(() => challengeController.isUserChallenges.value
                                ? RefreshIndicator(
                                    onRefresh: () {
                                      Future.wait([
                                        challengeController
                                            .getUserChallengesFunc(),
                                      ]);
                                      return Future(() => true);
                                    },
                              color: MyColors.buttonColor,
                                    child: GridView.builder(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 20.h, horizontal: 20.w),
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2, // Number of columns
                                        crossAxisSpacing:
                                            14.w, // Spacing between columns
                                        mainAxisSpacing:
                                            24.h, // Spacing between rows
                                      ),
                                      itemCount: challengeController
                                          .finishedList.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        var userChallenge = challengeController
                                            .finishedList[index];
                                        return ChallengeWidget(
                                          index: index,
                                          userChallenges: userChallenge,
                                        );
                                      },
                                    ),
                                  )
                                : shimmerChallenge()),

                            ///Pending
                            Obx(() => challengeController.isUserChallenges.value
                                ? RefreshIndicator(
                                    onRefresh: () {
                                      Future.wait([
                                        challengeController
                                            .getUserChallengesFunc(),
                                      ]);
                                      return Future(() => true);
                                    },
                              color: MyColors.buttonColor,
                                    child: GridView.builder(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 20.h, horizontal: 20.w),
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2, // Number of columns
                                        crossAxisSpacing:
                                            14.w, // Spacing between columns
                                        mainAxisSpacing:
                                            24.h, // Spacing between rows
                                      ),
                                      itemCount: challengeController
                                          .pendingList.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        var userChallenge = challengeController
                                            .pendingList[index];
                                        return ChallengeWidget(
                                          index: index,
                                          userChallenges: userChallenge,
                                        );
                                      },
                                    ),
                                  )
                                : shimmerChallenge()),
                          ],
                        ))
                      ],
                    )))
          ],
        ),
      ),
    );
  }

  Widget shimmerChallenge() {
    return Shimmer.fromColors(
        baseColor: MyColors.shimmerBaseColor,
        highlightColor: MyColors.shimmerHighlightColor,
        child: GridView.builder(
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of columns
            crossAxisSpacing: 14.w, // Spacing between columns
            mainAxisSpacing: 24.h, // Spacing between rows
          ),
          itemCount: 8,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              color: MyColors.shimmerBaseColor,
            );
          },
        ));
  }
}
