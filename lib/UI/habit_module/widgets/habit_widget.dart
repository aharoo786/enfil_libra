import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../values/my_colors.dart';

class HabitWidget extends StatelessWidget {
  const HabitWidget(
      {super.key,
      required this.text,
      this.showContainer = true,
      this.icon,
      required this.onTap});
  final String text;
  final String? icon;
  final VoidCallback onTap;

  final bool showContainer;
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 70.h,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          border: Border.all(color: MyColors.buttonColor.withOpacity(0.12)),
          boxShadow: [
            BoxShadow(
                spreadRadius: 0,
                blurRadius: 16,
                offset: const Offset(0, 4),
                color: Colors.black.withOpacity(0.12))
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                showContainer
                    ? Container(
                        height: 56.h,
                        width: 56.h,
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: MyColors.primary2)),
                        child: SvgPicture.asset(icon!),
                      )
                    : SizedBox(),
                SizedBox(
                  width: showContainer ? 12.w : 8.w,
                ),
                Text(
                  text,
                  style: textTheme.headlineLarge!
                      .copyWith(fontWeight: FontWeight.w700, fontSize: 20.sp),
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios_outlined,
              color: Colors.black.withOpacity(0.4),
            ),
          ],
        ),
      ),
    );
  }
}
