import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../values/constants.dart';
import '../values/dimens.dart';
import '../values/my_colors.dart';

class HelpingWidgets {
  PreferredSizeWidget appBarWidget(onTap,
      {String? text, Color? color, Color? statusBarColor,Color? textColor}) {
    return AppBar(
      automaticallyImplyLeading: false,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: statusBarColor ?? MyColors.containerColor),
      backgroundColor: color ?? MyColors.bodyBackground,
      leadingWidth: 70.w,
      elevation: 0,
      title: text != null
          ? Text(
              text,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20.sp,
                  color: textColor??Colors.black,
                  fontFamily: Constants.KarlaFamily),
            )
          : null,
      centerTitle: true,
      leading: onTap == null
          ? null
          : GestureDetector(
              onTap: onTap,
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
              ),
            ),
    );
  }

  Widget appBarText(String text, {Color? color}) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 24.sp,
          fontWeight: FontWeight.w700,
          color: color ?? Colors.black,
          //  fontStyle: FontStyle.normal,
          fontFamily: "Karla"),
    );
  }

  Widget bodyAppBar(String text, {Color? color}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back_ios_rounded,
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: color ?? Colors.black,
                    //  fontStyle: FontStyle.normal,
                    fontFamily: "Karla"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
