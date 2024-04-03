import 'package:enfil_libre/UI/values/my_imgs.dart';
import 'package:enfil_libre/UI/widgets/custom_button.dart';
import 'package:enfil_libre/controllers/auth_controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../helper/validators.dart';
import '../values/dimens.dart';
import '../values/my_colors.dart';
import '../widgets/app_bar_widget.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/custom_textfield_border.dart';

class UserProfile extends StatelessWidget {
  UserProfile({super.key});
  final List<Map<String, dynamic>> profileList = [
    {"text": "Security Settings", "icon": MyImgs.lock},
    {"text": "About Us", "icon": MyImgs.aboutUs},
    {"text": "Rate us", "icon": MyImgs.rateUs},
    {"text": "Logout", "icon": MyImgs.logout},
  ];
  List<String> genderList = ["Male", "Female", "Others"];

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    AuthController authController = Get.find();
    return Scaffold(
      backgroundColor: MyColors.splashColor,
      appBar: HelpingWidgets().appBarWidget(() {
        Get.back();
      },
          text: "My Account",
          color: MyColors.splashColor,
          statusBarColor: MyColors.splashColor),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(
              height: 30.h,
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Obx(
                () => Column(
                  children: [
                    if (authController.isUserDataLoad.value) Row(
                            children: [
                              Container(
                                height: 64.h,
                                width: 64.h,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 12,
                                          offset: const Offset(2, 2),
                                          color: Colors.black.withOpacity(0.04))
                                    ],
                                    color: Colors.white,
                                    border: Border.all(
                                        color: MyColors.purpleColor
                                            .withOpacity(0.2)),
                                    image: DecorationImage(
                                        image: AssetImage(MyImgs.dummyDp),
                                        fit: BoxFit.cover)),
                              ),
                              // Image.asset(MyImgs.dummyDp,scale: 3,),
                              SizedBox(
                                width: 12.w,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Admin",
                                      style: textTheme.headlineLarge!.copyWith(
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(
                                      height: 8.h,
                                    ),
                                    Text(
                                      "admin123@gmail.com",
                                      style: textTheme.headlineLarge!.copyWith(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(32.r),
                                              topLeft: Radius.circular(32.r))),
                                      //isScrollControlled: true,
                                      context: context,
                                      builder: (context) {
                                        return SizedBox(
                                             height: 650.h,
                                            width: double.infinity,
                                            child: SingleChildScrollView(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20.w),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                              
                                                  children: [
                                                    SizedBox(
                                                      height: Dimens.size30.h,
                                                    ),
                                                    Container(
                                                      height: 64.h,
                                                      width: 64.h,
                                                      decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          boxShadow: [
                                                            BoxShadow(
                                                                blurRadius: 12,
                                                                offset:
                                                                    const Offset(
                                                                        2, 2),
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.04))
                                                          ],
                                                          color: Colors.white,
                                                          border: Border.all(
                                                              color: MyColors
                                                                  .purpleColor
                                                                  .withOpacity(
                                                                      0.2)),
                                                          image: const DecorationImage(
                                                              image: AssetImage(
                                                                  MyImgs.dummyDp),
                                                              fit: BoxFit.cover)),
                                                    ),
                                                    SizedBox(
                                                      height: Dimens.size20.h,
                                                    ),
                                                    LayoutBuilder(builder:
                                                        (context, constraints) {
                                                      return Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                "First Name",
                                                                style: textTheme
                                                                    .headlineLarge!
                                                                    .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 18.sp,
                                                                ),
                                                              ),
                                                              SizedBox(height:12.h),
                                                              CustomTextFieldBorder(
                                                                bordercolor: MyColors
                                                                    .purpleColor
                                                                    .withOpacity(
                                                                        0.2),
                                                                width: constraints
                                                                        .maxWidth /
                                                                    2.1,
                                              
                                                                // controller: loginPassword,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .text,
                                                                validator: (value) =>
                                                                    Validators
                                                                        .passwordValidator(
                                                                            value!),
                                                                text: "First Name"
                                                                    .tr,
                                                                length: 30,
                                                                controller:
                                                                    authController
                                                                        .updateFirstNameController,
                                                                inputFormatters:
                                                                    FilteringTextInputFormatter
                                                                        .singleLineFormatter,
                                                              ),
                                                            ],
                                                          ),
                                                          Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                "Last Name",
                                                                style: textTheme
                                                                    .headlineLarge!
                                                                    .copyWith(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                                  fontSize: 18.sp,
                                                                ),
                                                              ),
                                                              SizedBox(height:12.h),
                                                              CustomTextFieldBorder(
                                                                width: constraints
                                                                        .maxWidth /
                                                                    2.1,
                                                                bordercolor: MyColors
                                                                    .purpleColor
                                                                    .withOpacity(0.2),
                                              
                                                                // controller: loginPassword,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .text,
                                                                validator: (value) =>
                                                                    Validators
                                                                        .passwordValidator(
                                                                            value!),
                                                                text: "Last Name".tr,
                                                                length: 30,
                                                                controller: authController
                                                                    .updateLastNameController,
                                                                inputFormatters:
                                                                    FilteringTextInputFormatter
                                                                        .singleLineFormatter,
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      );
                                                    }),
                                                    SizedBox(
                                                      height: Dimens.size25.h,
                                                    ),
                                                    Text(
                                                      "Email",
                                                      style: textTheme
                                                          .headlineLarge!
                                                          .copyWith(
                                                        fontWeight:
                                                        FontWeight
                                                            .w600,
                                                        fontSize: 18.sp,
                                                      ),
                                                    ),
                                                    SizedBox(height:12.h),
                                              
                                                    CustomTextFieldBorder(
                                                      bordercolor: MyColors
                                                          .purpleColor
                                                          .withOpacity(0.2),
                                              
                                                      // controller: loginPassword,
                                                      keyboardType:
                                                          TextInputType.text,
                                                      validator: (value) =>
                                                          Validators
                                                              .passwordValidator(
                                                                  value!),
                                                      text: "Email".tr,
                                                      length: 30,
                                                      controller: authController
                                                          .updateEmailController,
                                                      inputFormatters:
                                                          FilteringTextInputFormatter
                                                              .singleLineFormatter,
                                                    ),
                                              
                                                    SizedBox(
                                                      height: Dimens.size25.h,
                                                    ),
                                                    Text(
                                                      "Gender",
                                                      style: textTheme
                                                          .headlineLarge!
                                                          .copyWith(
                                                        fontWeight:
                                                        FontWeight
                                                            .w600,
                                                        fontSize: 18.sp,
                                                      ),
                                                    ),
                                                    SizedBox(height:12.h),
                                                    Container(
                                                      width: 374.w,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 8.w),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: MyColors
                                                                  .purpleColor
                                                                  .withOpacity(
                                                                      0.2),
                                                              width: 1.h),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12)),
                                                      child:
                                                          DropdownButton<String>(
                                                        value: genderList[0],
                                                        elevation: 4,
                                                        isExpanded: true,
                                                        icon: Icon((Icons
                                                            .keyboard_arrow_down_outlined)),
                                                        dropdownColor:
                                                            Colors.white,
                                                        underline: SizedBox(),
                                                        focusColor: Colors.white,
                                                        items: [
                                                          ...genderList
                                                              .map((value) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value: value,
                                                              child: Text(
                                                                value,
                                                                style: TextStyle(
                                                                    fontSize: 18),
                                                              ),
                                                            );
                                                          }).toList(),
                                                        ],
                                                        onChanged: (data) {},
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    CustomButton(
                                                      text: "Update",
                                                      onPressed: () {},
                                                      width: 300.w,
                                                    ),
                                                    SizedBox(
                                                      height: 40.h,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ));
                                      },
                                    );
                                  },
                                  child: SvgPicture.asset(MyImgs.editIcon)),
                            ],
                          ) else const CircularProgressIndicator(
                            color: MyColors.buttonColor,
                          )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Expanded(
                child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => Container(
                          height: 52.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 12,
                                  offset: const Offset(2, 2),
                                  color: Colors.black.withOpacity(0.04))
                            ],
                            color: Colors.white,
                            border: Border.all(
                                color: MyColors.purpleColor.withOpacity(0.2)),
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 20.w,
                              ),
                              SvgPicture.asset(profileList[index]["icon"]),
                              SizedBox(
                                width: 12.w,
                              ),
                              Expanded(
                                  child: Text(
                                profileList[index]["text"],
                                style: textTheme.headlineLarge!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.sp),
                              ))
                            ],
                          ),
                        ),
                    separatorBuilder: (context, index) => SizedBox(
                          height: 8.h,
                        ),
                    itemCount: profileList.length)),
            // SvgPicture.asset(MyImgs.myAccount)
          ],
        ),
      ),
    );
  }
}
