import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../values/my_colors.dart';
import '../../values/my_imgs.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final int index;
  final Function(int) onIndexChanged;

  CustomBottomNavigationBar(
      {required this.index, required this.onIndexChanged});

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(200),
        boxShadow: [
          BoxShadow(
            spreadRadius: 0,
            blurRadius: 16,
            offset: const Offset(0, 4),
            color: Colors.black.withOpacity(0.16),
          ),
        ],
      ),
      margin: EdgeInsets.only(bottom: 8.h, left: 20.w, right: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(MyImgs.home, MyImgs.homeDim, 0),
          _buildNavItem(MyImgs.reward, MyImgs.rewardDim, 1),
          _buildNavItem(MyImgs.calender, MyImgs.calenderDim, 2),
          _buildNavItem(MyImgs.bigBadge, MyImgs.homeDim, 3),
        ],
      ),
    );
  }

  Widget _buildNavItem(String activeIcon, String inactiveIcon, int index) {
    bool isSelected = index == widget.index;
    return InkWell(
      onTap: () {
        widget.onIndexChanged(index);
      },
      borderRadius: BorderRadius.circular(200),
      child: Container(
        height: 45.h,
        width: 45.h,
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: isSelected ? MyColors.buttonColor : Colors.white,
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          activeIcon,
          colorFilter: ColorFilter.mode(
              isSelected ? Colors.white : MyColors.hintText, BlendMode.srcIn),
        ),
      ),
    );
  }
}
