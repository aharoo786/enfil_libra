import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../values/my_colors.dart';
import '../../values/my_imgs.dart';
class CustomProgressWidget extends StatelessWidget {
  const CustomProgressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(12.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          border: Border.all(color: Colors.black),
          boxShadow: [
            BoxShadow(
                spreadRadius: 0,
                blurRadius: 16,
                offset: const Offset(0, 4),
                color: Colors.black.withOpacity(0.12))
          ]
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Your next reward',
                style: textTheme.headlineSmall!
                    .copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                    color: MyColors.buttonColor),
              ),   Text(
                '50/100',
                style: textTheme.headlineSmall!
                    .copyWith(
                    fontWeight: FontWeight.w300,
                    fontSize: 16.sp,
                    color: MyColors.buttonColor),
              ),
             // SvgPicture.asset(MyImgs.rewardBig)
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    MyImgs.calender,
                    height: 20.h,
                    colorFilter:
                     ColorFilter.mode(
                        MyColors.buttonColor.withOpacity(0.4),
                        BlendMode.srcIn),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Text(
                    '2 days left',
                    style: textTheme.titleLarge!
                        .copyWith(
                        fontWeight:
                        FontWeight.w600,
                        fontSize: 12.sp,
                        color:
                        MyColors.buttonColor),
                  ),
                ],
              ),
              SizedBox(
                width: 12.w,
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    MyImgs.miniBadge,
                    height: 20.h,
                    colorFilter:
                     ColorFilter.mode(
                        MyColors.buttonColor.withOpacity(0.4),
                        BlendMode.srcIn),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Text(
                    '12',
                    style: textTheme.titleLarge!
                        .copyWith(
                        fontWeight:
                        FontWeight.w600,
                        fontSize: 12.sp,
                        color:
                        MyColors.buttonColor),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 5.h,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '25%',
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
              value: 0.5,
              valueColor: const AlwaysStoppedAnimation<
                  Color>(
                  MyColors
                      .primary2), // Color of the progress indicator
              backgroundColor:
              Colors.black.withOpacity(0.1),
            ),
          ),
        ],
      ),
    );
  }
}
