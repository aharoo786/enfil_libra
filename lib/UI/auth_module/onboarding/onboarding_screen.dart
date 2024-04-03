import 'package:enfil_libre/UI/auth_module/onboarding/welcom_screen.dart';
import 'package:enfil_libre/UI/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../values/my_colors.dart';
import '../../values/my_imgs.dart';

class WalkThroughScreen extends StatefulWidget {
  const WalkThroughScreen({super.key});

  @override
  _WalkThroughScreenState createState() => _WalkThroughScreenState();
}

class _WalkThroughScreenState extends State<WalkThroughScreen> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          elevation: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: MyColors.bodyBackground),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(color: MyColors.bodyBackground),
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: Column(
            children: [
              // SizedBox(
              //   height: 40.h,
              // ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Get.offAll(() => const WelcomeScreen());
                  },
                  child: Text(
                    "Skip",
                    style: textTheme.headlineSmall!
                        .copyWith(color: MyColors.buttonColor),
                  ),
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              Expanded(
                //height: MediaQuery.of(context).size.height / 1.3,
                child: PageView(
                  physics: const ClampingScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  children: [
                    _photos(
                        photo: MyImgs.onBoarding1,
                        headline: "Discover your journey",
                        subtitle:
                            "Explore a world of challenges tailored to your growth. Engage in daily tasks, track your progress, and unlock rewards on your path to personal excellence", textTheme: textTheme),
                    _photos(
                        photo: MyImgs.onBoarding2,
                        headline: "Empower your mindset",
                        subtitle:
                            "Access a treasure trove of resources designed to enhance your personal development journey. From insightful articles to motivating videos, find the tools you need to thrive", textTheme: textTheme),
                    _photos(
                        photo: MyImgs.onBoarding3,
                        headline: "Craft your routine",
                        subtitle:
                            "Create morning rituals that set the tone for success. Customize your routine, track your habits, and receive gentle reminders to stay focused and aligned with your goals", textTheme: textTheme),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(40),
        child: CustomButton(
          text: _currentPage == 2 ? "Get Started" : "Next",
          onPressed: () {
            if (_currentPage == 2) {
              Get.offAll(() => const WelcomeScreen());
            } else {
              setState(() {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease,
                );
              });
            }
            // Get.to(() => ChooseProfilePage());
          },
        ),
      ),
    );
  }

  Widget _photos(
      {required String photo,
      required String headline,
      required String subtitle,
        required TextTheme textTheme
      
      }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          SvgPicture.asset(photo),
          SizedBox(
            height: 50.h,
          ),
          Text(
            headline,
            textAlign: TextAlign.center,
            style: textTheme
                .headlineSmall!
                .copyWith(fontWeight: FontWeight.w700, fontSize: 40.sp),
          ),
          SizedBox(
            height: 15.h,
          ),
          Text(
            subtitle,
            style: textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 16.sp,
                  color: MyColors.black.withOpacity(0.6),
                ),
            textAlign: TextAlign.center,
            // overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
