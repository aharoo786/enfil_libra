import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../values/dimens.dart';
import '../values/my_colors.dart';

class CustomTextFieldBorder extends StatelessWidget {
  final double? height;
  final double? width;
  final double? roundCorner;
  final Color? bordercolor;
  final Color? background;
  final String text;
  final int length;
  final double verticalPadding;
  final TextInputType keyboardType;
  final dynamic inputFormatters;
  bool? Readonly = false;
  bool autoFocus;
  final Widget? icon;
  final suffixIcon;
  final InputBorder? border;
  final String? errorText;
  final FocusNode? focusNode;
  final String? suffixtext;
  final Color? hintColor;
  final Color? textColor;
  final Color? cursorColor;
  final TextAlign? textAlign;
  final int? maxlines;
  final Color? color;
  final bool? isObscure;
  final double? fontSize;
  final FontWeight? fontWeight;

  final bool isListOfInputFormatters;
  final Function(String)? onFieldSubmitted;
  final List<BoxShadow>? boxShadow;

  TextEditingController? controller;
  FormFieldValidator<String>? validator;
  ValueChanged<String>? onChanged;

  CustomTextFieldBorder(
      {Key? key,
      this.height,
      this.width,
      this.roundCorner,
      this.suffixIcon,
      this.bordercolor,
      this.background,
      this.controller,
      this.border,
      this.maxlines,
      required this.text,
      this.validator,
      this.onChanged,
      this.errorText,
      this.Readonly,
      this.autoFocus = false,
      this.focusNode,
      this.hintColor,
      this.icon,
      this.color,
      this.suffixtext,
      required this.length,
      required this.keyboardType,
      required this.inputFormatters,
      this.isObscure,
      this.textColor,
      this.cursorColor,
      this.onFieldSubmitted,
      this.verticalPadding = 0.0,
      this.boxShadow = const [],
      this.isListOfInputFormatters = false,
      this.fontSize,
      this.fontWeight,
      this.textAlign})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    var mediaQuery = MediaQuery.of(context).size;

    return Container(
      height: height ?? 52.h,
      width: width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: bordercolor == null
            ? null
            : Border.all(color: bordercolor ?? Colors.transparent, width: 1),
        borderRadius: roundCorner == null
            ? BorderRadius.circular(12)
            : BorderRadius.circular(roundCorner!),
        boxShadow: boxShadow,
        color: background ?? MyColors.textFieldColor,
        // borderRadius: BorderRadius.circular(roundCorner ?? 48)
      ),
      child: TextFormField(
        obscuringCharacter: '*',
        maxLength: length,
        // cursorHeight: 24.h,
        maxLines: maxlines ?? 1,
        autofocus: autoFocus,
        focusNode: focusNode,
        validator: (value) {
          if (value == "" || value!.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
        style: textTheme.headlineSmall!.copyWith(
            fontSize: fontSize ?? 16.sp,
            height: 1,
            color: textColor ?? MyColors.textColor,
            fontWeight: fontWeight ?? FontWeight.w500),
        controller: controller,
        keyboardType: keyboardType,
        textAlign: textAlign ?? TextAlign.start,
        onChanged: onChanged,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        cursorColor: cursorColor ?? MyColors.black,
        inputFormatters: isListOfInputFormatters
            ? inputFormatters
            : <TextInputFormatter>[inputFormatters],
        textInputAction: TextInputAction.next,
        readOnly: Readonly == true ? true : false,
        obscureText: isObscure ?? false,
        onFieldSubmitted: onFieldSubmitted,
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 10.w, vertical: verticalPadding),
          border: border ?? InputBorder.none,

          errorText: errorText,
          counterText: "",
          enabledBorder: border ?? InputBorder.none,
          // focusedBorder: UnderlineInputBorder(
          //   borderSide: BorderSide(color: color ?? MyColors.purple, width: 2),
          // ),
          errorBorder: OutlineInputBorder(
            borderRadius: roundCorner == null
                ? BorderRadius.circular(12)
                : BorderRadius.circular(roundCorner!),
            borderSide: const BorderSide(color: MyColors.red500, width: 0.5),
          ),
          hintText: text,
          suffixIcon: suffixIcon,

          hintStyle: TextStyle(
              color: hintColor ?? MyColors.hintText,
              fontWeight: FontWeight.w300,
              fontSize: fontSize ?? 16.sp),
          // contentPadding: EdgeInsets.only(left: 15, top: 9),
          prefixIcon: icon != null
              ? Padding(
                  padding: EdgeInsets.all(Dimens.size10.w),
                  child: icon,
                )
              : null,
          errorStyle: TextStyle(fontSize: 0),
          suffixText: suffixtext,
          focusColor: MyColors.green50,
        ),
      ),
    );
  }
}
