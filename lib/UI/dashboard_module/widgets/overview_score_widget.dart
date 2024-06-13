import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OverviewScoreWidget extends StatelessWidget {
  const OverviewScoreWidget(
      {super.key, required this.percent, required this.scoreText});
  final String percent;
  final String scoreText;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Text(
          percent,
          style: textTheme.headlineSmall!.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 12.sp,
          ),
        ),
        Text(
          scoreText,
          style: textTheme.headlineSmall!.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }
}
