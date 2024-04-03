import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../values/constants.dart';
import '../../values/dimens.dart';
import '../../values/my_colors.dart';
import '../../values/my_imgs.dart';
import '../widgets/custom_tab_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return Scaffold(
      backgroundColor: MyColors.splashColor,
      body: Column(
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
            child:const CustomTabBar()
          ))
        ],
      ),
    );
  }

  Widget containerWidget(
      String title, String subTitle, String image, ontap, context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return GestureDetector(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
            color: MyColors.containerColor,
            borderRadius: BorderRadius.circular(13)),
        padding: EdgeInsets.all(17.h),
        child: ListTile(
          leading: Image.asset(
            image,
            scale: 3,
          ),
          title: Text(
            title,
            style: textTheme.headline1!.copyWith(
                fontSize: 24.sp,
                fontFamily: Constants.poppinsFamily,
                fontWeight: FontWeight.w500),
          ),
          subtitle: Text(
            subTitle,
            style: textTheme.headline5!.copyWith(
                fontFamily: Constants.poppinsFamily,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
