import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
class SocialCard extends StatelessWidget {
  final String icon;
  const SocialCard({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.symmetric(horizontal: 34.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
              spreadRadius: 0,
              blurRadius: 4,
              offset: const Offset(2, 2),
              color: Colors.black.withOpacity(0.2))
        ],
      ),
      child: SvgPicture.asset(icon),
    );
  }
}
