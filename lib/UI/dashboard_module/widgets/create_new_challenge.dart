import 'package:enfil_libre/UI/dashboard_module/dashboard_screen/dashboard_screen.dart';
import 'package:enfil_libre/controllers/home_controller/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../values/my_colors.dart';
import '../../values/my_imgs.dart';
import '../../widgets/custom_button.dart';

class CreateNewChallenge extends StatelessWidget {
  Future<void> Function() onRefresh;
  CreateNewChallenge({super.key, required this.onRefresh});
  final HomeController homeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.splashColor,
      body: RefreshIndicator(
        onRefresh: onRefresh,
        color: MyColors.buttonColor ,
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    height: 650.h,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 60.h,
                        ),
                        Text(
                          'Start Challenge',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 32.sp,
                              color: MyColors.buttonColor),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'Let\'s start your journey to personal growth by creating your first Challenge.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 20.sp,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Expanded(
                            child: SvgPicture.asset(MyImgs.createHabitVector)),
                        SizedBox(
                          height: 60.h,
                        ),
                        CustomButton(
                          text: "+ Start new Challenge",
                          width: 220.w,
                          onPressed: () {
                            Get.offAll(() => DashboardScreen(
                                  index: 1,
                                ));
                          },
                          color: Colors.white,
                          textColor: MyColors.buttonColor,
                        ),
                        SizedBox(
                          height: 60.h,
                        ),
                      ],
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
