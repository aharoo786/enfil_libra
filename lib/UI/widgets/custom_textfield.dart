import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../values/dimens.dart';
import '../values/my_colors.dart';

class CustomTextField extends StatelessWidget {
  final double? height;
  final double? width;
  final double? roundCorner;
  final Color? borderColor;
  final Color? backgroundColor;
  final String hintText;
  final int maxLength;
  final TextInputType keyboardType;
  final TextInputFormatter inputFormatter;
  final bool readOnly;
  final Widget? icon;
  final Widget? suffixIcon;
  final InputBorder? border;
  final String? errorText;
  final FocusNode? focusNode;
  final String? suffixText;
  final Color? hintColor;
  final Color? textColor;
  final Color? cursorColor;
  final int? maxLines;
  final bool? obscureText;
  final Function(String)? onFieldSubmitted;

  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;

  const CustomTextField({
    Key? key,
    this.height,
    this.width,
    this.roundCorner,
    this.borderColor,
    this.backgroundColor,
    required this.hintText,
    required this.maxLength,
    required this.keyboardType,
    required this.inputFormatter,
    this.controller,
    this.border,
    this.maxLines,
    this.validator,
    this.onChanged,
    this.errorText,
    this.readOnly = false,
    this.focusNode,
    this.icon,
    this.suffixIcon,
    this.suffixText,
    this.hintColor,
    this.textColor,
    this.cursorColor,
    this.obscureText,
    this.onFieldSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    var mediaQuery = MediaQuery.of(context).size;

    return Container(
      height: height ?? 60.h,
      width: width ?? mediaQuery.width,
      decoration: BoxDecoration(
        color: backgroundColor ?? MyColors.textFieldColor,
        borderRadius: BorderRadius.circular(roundCorner ?? 16),
      ),
      child: TextFormField(
        maxLength: maxLength,
        maxLines: maxLines ?? 1,
        focusNode: focusNode,
        validator: (value) => value!.isEmpty ? 'Please enter some text' : null,
        style: TextStyle(
          color: textColor ?? MyColors.textColor,
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
        controller: controller,
        keyboardType: keyboardType,
        textAlign: TextAlign.start,
        onChanged: onChanged,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        cursorColor: cursorColor ?? MyColors.black,
        inputFormatters: <TextInputFormatter>[inputFormatter],
        textInputAction: TextInputAction.next,
        readOnly: readOnly,
        obscureText: obscureText ?? false,
        onFieldSubmitted: onFieldSubmitted,
        decoration: InputDecoration(
          // contentPadding:
          //     EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          border: border ?? const UnderlineInputBorder(),
          errorText: errorText,
          counterText: "",

          enabledBorder: const UnderlineInputBorder(),
          focusedBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: borderColor ?? Colors.black, width: 2),
          ),
          // hintText: hintText.tr,
          suffixIcon: suffixIcon,
          // hintStyle: TextStyle(
          //   color: hintColor ?? MyColors.hintText,
          //   fontWeight: FontWeight.normal,
          //   fontSize: 16.sp,
          // ),
          prefixIcon: icon != null
              ? Padding(padding: EdgeInsets.all(Dimens.size13.w), child: icon)
              : null,
          errorStyle: const TextStyle(fontSize: 0),
          suffixText: suffixText,
          // errorBorder: InputBorder.none,

          floatingLabelAlignment: FloatingLabelAlignment.start,
          focusColor: MyColors.green50,

          labelText: hintText,

          labelStyle: TextStyle(
            color: hintColor ?? MyColors.hintText,
            fontWeight: FontWeight.w400,
            fontSize: 16.sp,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
      ),
    );
  }
}
