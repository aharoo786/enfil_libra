import 'package:enfil_libre/UI/widgets/toasts.dart';
import 'package:enfil_libre/controllers/auth_controller/auth_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../../helper/permissions.dart';
import '../../../helper/validators.dart';
import '../../values/dimens.dart';
import '../../values/my_colors.dart';
import '../../values/my_imgs.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield_border.dart';

class UserProfileBottomSheets {
  showUpdateUserBottomSheet(BuildContext context, AuthController authController,
      List<String> genderList) {
    var textTheme = Theme.of(context).textTheme;
    showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(32.r), topLeft: Radius.circular(32.r))),
      //isScrollControlled: true,
      context: context,
      builder: (context) {
        return SizedBox(
            height: 650.h,
            width: double.infinity,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Dimens.size30.h,
                    ),
                    Center(
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          GetBuilder<AuthController>(builder: (cont) {
                            return Container(
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
                                    image: authController
                                                .getUserProfile!.data.image ==
                                            null
                                        ? authController.profileImage == null
                                            ? const DecorationImage(
                                                image:
                                                    AssetImage(MyImgs.dummyDp),
                                                fit: BoxFit.cover)
                                            : DecorationImage(
                                                image: FileImage(
                                                  File(authController
                                                      .profileImage!.path),
                                                ),
                                                fit: BoxFit.cover)
                                        : DecorationImage(
                                            image: NetworkImage(authController
                                                .getUserProfile!.data.image),
                                            fit: BoxFit.cover)));
                          }),
                          GestureDetector(
                            onTap: () {
                              selectMediaBottomSheet(
                                  _getFromGallery, _getFromCamera, context);
                            },
                            child: Container(
                              height: 24.h,
                              width: 24.h,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: MyColors.splashColor),
                              child: const Icon(
                                Icons.edit,
                                color: MyColors.buttonColor,
                                size: 15,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Dimens.size20.h,
                    ),
                    LayoutBuilder(builder: (context, constraints) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "First Name",
                                style: textTheme.headlineLarge!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18.sp,
                                ),
                              ),
                              SizedBox(height: 12.h),
                              CustomTextFieldBorder(
                                bordercolor:
                                    MyColors.purpleColor.withOpacity(0.2),
                                width: constraints.maxWidth / 2.1,

                                // controller: loginPassword,
                                keyboardType: TextInputType.text,
                                validator: (value) =>
                                    Validators.passwordValidator(value!),
                                text: "First Name",
                                length: 30,
                                controller:
                                    authController.updateFirstNameController,
                                inputFormatters: FilteringTextInputFormatter
                                    .singleLineFormatter,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Last Name",
                                style: textTheme.headlineLarge!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18.sp,
                                ),
                              ),
                              SizedBox(height: 12.h),
                              CustomTextFieldBorder(
                                width: constraints.maxWidth / 2.1,
                                bordercolor:
                                    MyColors.purpleColor.withOpacity(0.2),

                                // controller: loginPassword,
                                keyboardType: TextInputType.text,
                                validator: (value) =>
                                    Validators.passwordValidator(value!),
                                text: "Last Name".tr,
                                length: 30,
                                controller:
                                    authController.updateLastNameController,
                                inputFormatters: FilteringTextInputFormatter
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
                      style: textTheme.headlineLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 18.sp,
                      ),
                    ),
                    SizedBox(height: 12.h),

                    CustomTextFieldBorder(
                      bordercolor: MyColors.purpleColor.withOpacity(0.2),

                      // controller: loginPassword,
                      keyboardType: TextInputType.text,
                      Readonly: true,
                      validator: (value) =>
                          Validators.passwordValidator(value!),
                      text: "Email".tr,
                      length: 30,
                      controller: authController.updateEmailController,
                      inputFormatters:
                          FilteringTextInputFormatter.singleLineFormatter,
                    ),

                    SizedBox(
                      height: Dimens.size25.h,
                    ),
                    Text(
                      "Gender",
                      style: textTheme.headlineLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 18.sp,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Container(
                      width: 374.w,
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: MyColors.purpleColor.withOpacity(0.2),
                              width: 1.h),
                          borderRadius: BorderRadius.circular(12)),
                      child: DropdownButton<String>(
                        value: genderList[0],
                        elevation: 4,
                        isExpanded: true,
                        icon: const Icon((Icons.keyboard_arrow_down_outlined)),
                        dropdownColor: Colors.white,
                        underline: SizedBox(),
                        focusColor: Colors.white,
                        items: [
                          ...genderList.map((value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(fontSize: 18),
                              ),
                            );
                          }).toList(),
                        ],
                        onChanged: (data) {
                          authController.selectedGender = data;
                        },
                      ),
                    ),
                    // Spacer(),
                    SizedBox(
                      height: 60.h,
                    ),
                    Center(
                      child: CustomButton(
                        text: "Update",
                        onPressed: () {
                          if (authController
                                  .updateLastNameController.text.isEmpty ||
                              authController
                                  .updateFirstNameController.text.isEmpty) {
                            CustomToast.failToast(
                                msg: "Please provide both names");
                          } else {
                            authController.updateUser();
                          }
                        },
                        width: 300.w,
                      ),
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
  }

  selectMediaBottomSheet(
      Function gallery, Function camera, BuildContext context) {
    Get.bottomSheet(Container(
      height: 150,
      color: MyColors.bodyBackground,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.photo_camera,
                  size: 30,
                ),
                onPressed: () {
                  Get.back();
                  camera(context);
                },
              ),
              Text("From Camera".tr)
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.photo,
                  size: 30,
                ),
                onPressed: () {
                  Get.back();
                  gallery(context);
                },
              ),
              Text("From Gallery".tr)
            ],
          ),
        ],
      ),
    ));
  }

  /// Get from Camera
  _getFromCamera(BuildContext context) async {
    PermissionOfPhotos().getFromCamera(context).then((value) async {
      if (value) {
        final pickedFile =
            await ImagePicker().pickImage(source: ImageSource.camera);
        if (pickedFile != null) {
          print("Picked File: ${pickedFile.path}");
          var imagePath = pickedFile.path;
          var imageName = imagePath.split("/").last;
          print("Image Name: $imageName");
          final dir1 = Directory.systemTemp;
          final targetPath1 =
              "${dir1.absolute.path}/dp${Get.find<AuthController>().i}.jpg";
          var compressedFile1 = await FlutterImageCompress.compressAndGetFile(
              imagePath, targetPath1,
              quality: 60);

          Get.find<AuthController>().profileImage =
              XFile(compressedFile1!.path);
          Get.find<AuthController>().i++;
          Get.find<AuthController>().update();
        }
      } else {
        print(value);
      }
    });
  }

  _getFromGallery(BuildContext context) async {
    PermissionOfPhotos().getFromGallery(context).then((value) async {
      if (value) {
        final pickedFile =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          print("Picked File: ${pickedFile.path}");
          var imagePath = pickedFile.path;
          var imageName = imagePath.split("/").last;
          print("Image Name: $imageName");
          final dir1 = Directory.systemTemp;
          final targetPath1 =
              "${dir1.absolute.path}/dp${Get.find<AuthController>().i}.jpg";
          var compressedFile1 = await FlutterImageCompress.compressAndGetFile(
              imagePath, targetPath1,
              quality: 60);
          Get.find<AuthController>().profileImage =
              XFile(compressedFile1!.path);
          Get.find<AuthController>().i++;
          Get.find<AuthController>().update();
        }
      } else {
        print(value);
      }
    });
  }
}
