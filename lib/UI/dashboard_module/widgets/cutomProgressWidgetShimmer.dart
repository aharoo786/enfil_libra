import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../values/my_colors.dart';

class CustomProgressBarWidgetShimmer extends StatelessWidget {
 final  double horizontalPadding;
  const CustomProgressBarWidgetShimmer({super.key,this.horizontalPadding=0});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: MyColors.shimmerBaseColor,
      highlightColor: MyColors.shimmerHighlightColor,
      child: Container(
        height: 100.h,
        margin: EdgeInsets.symmetric(horizontal: horizontalPadding.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: MyColors.shimmerBaseColor,
            boxShadow: [
              BoxShadow(
                  spreadRadius: 0,
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                  color: Colors.black.withOpacity(0.12))
            ]),
      ),
    );
  }
}
