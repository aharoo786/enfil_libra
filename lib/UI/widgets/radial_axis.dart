import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../values/dimens.dart';
import '../values/my_colors.dart';

class RadialAxisWidget extends StatelessWidget {
  const RadialAxisWidget(
      {required this.progressBarValue,
      this.backgroundColor = Colors.white,
      this.minutes = "0",
      Key? key})
      : super(key: key);
  final Color backgroundColor;
  final String minutes;
  final int progressBarValue;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 33.h,
          width: 33.h,
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: backgroundColor),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "$progressBarValue%",
                style: textTheme.headlineMedium!.copyWith(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: backgroundColor == MyColors.black
                        ? MyColors.textColor2
                        : MyColors.textColor),
              ),
            ],
          ),
        ),
        Container(
          height: 55.h,
          width: 55.h,
          decoration: const BoxDecoration(shape: BoxShape.circle),
          alignment: Alignment.center,
          child: SfRadialGauge(axes: <RadialAxis>[
            // Create primary radial axis
            RadialAxis(
              minimum: 0,
              maximum: 100,
              showLabels: false,
              showTicks: false,
              startAngle: 270,
              endAngle: 270,
              radiusFactor: 0.7,
              axisLineStyle: AxisLineStyle(
                thickness: 0.2,
                color: backgroundColor == MyColors.black
                    ? Colors.white
                    : MyColors.black.withOpacity(0.1),
                thicknessUnit: GaugeSizeUnit.factor,
              ),
              pointers: <GaugePointer>[
                RangePointer(
                  value: progressBarValue.toDouble(),
                  width: 0.20,
                  color: MyColors.buttonColor,
                  pointerOffset: 0,
                  sizeUnit: GaugeSizeUnit.factor,
                )
              ],
            ),
            // Create secondary radial axis for segmented line
            RadialAxis(
              minimum: 0,
              interval: 1,
              maximum: 4,
              showLabels: false,
              showTicks: false,
              showAxisLine: false,
              tickOffset: -0.05,
              offsetUnit: GaugeSizeUnit.factor,
              minorTicksPerInterval: 0,
              startAngle: 270,
              endAngle: 270,
              radiusFactor: 0.7,
              majorTickStyle: MajorTickStyle(
                  length: 0.3,
                  thickness: 1,
                  lengthUnit: GaugeSizeUnit.factor,
                  color: Colors.white.withOpacity(0.5)),
            )
          ]),
        ),
      ],
    );
  }
}
