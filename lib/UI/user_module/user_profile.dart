import 'package:enfil_libre/UI/values/my_imgs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../values/my_colors.dart';
import '../widgets/app_bar_widget.dart';

class UserProfile extends StatelessWidget {
  UserProfile({super.key});
  final List<Map<String, dynamic>> profileList = [
    {"text": "Security Settings", "icon": MyImgs.lock},
    {"text": "About Us", "icon": MyImgs.aboutUs},
    {"text": "Rate us", "icon": MyImgs.rateUs},
    {"text": "Logout", "icon": MyImgs.logout},
  ];

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return Scaffold(
      backgroundColor: MyColors.splashColor,
      appBar: HelpingWidgets().appBarWidget(() {
        Get.back();
      },
          text: "My Account",
          color: MyColors.splashColor,
          statusBarColor: MyColors.splashColor),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(
              height: 30.h,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 64.h,
                        width: 64.h,
                        decoration:  BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 12,
                                  offset: const Offset(2,2),
                                  color: Colors.black.withOpacity(0.04)
                              )
                            ],
                            color: Colors.white,
                            border: Border.all(
                                color: MyColors.purpleColor.withOpacity(0.2)),

                            image: DecorationImage(
                                image: AssetImage(MyImgs.dummyDp),
                                fit: BoxFit.cover)),
                      ),
                      // Image.asset(MyImgs.dummyDp,scale: 3,),
                      SizedBox(
                        width: 12.w,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Admin",
                              style: textTheme.headlineLarge!.copyWith(
                                  fontSize: 20.sp, fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            Text(
                              "admin123@gmail.com",
                              style: textTheme.headlineLarge!.copyWith(
                                  fontSize: 14.sp, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                      SvgPicture.asset(MyImgs.editIcon),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Expanded(
                child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => Container(
                          height: 52.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 12,
                                offset: const Offset(2,2),
                                color: Colors.black.withOpacity(0.04)
                              )
                            ],
                            color: Colors.white,
                            border: Border.all(
                                color: MyColors.purpleColor.withOpacity(0.2)),
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 20.w,
                              ),
                              SvgPicture.asset(profileList[index]["icon"]),
                              SizedBox(
                                width: 12.w,
                              ),
                              Expanded(
                                  child: Text(
                                profileList[index]["text"],
                                style: textTheme.headlineLarge!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.sp),
                              ))
                            ],
                          ),
                        ),
                    separatorBuilder: (context, index) => SizedBox(
                          height: 8.h,
                        ),
                    itemCount: profileList.length)),
            // SvgPicture.asset(MyImgs.myAccount)
          ],
        ),
      ),
    );
  }
}
