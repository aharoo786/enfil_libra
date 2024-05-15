import 'package:enfil_libre/UI/values/my_colors.dart';
import 'package:enfil_libre/UI/values/my_imgs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../values/dimens.dart';

class HomeBottomSheets {
  showUpdateUserBottomSheet(BuildContext context) {
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
            child: DefaultTabController(
              length: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: 20.w),
                    child: Text(
                      "Notification",
                      style: textTheme.headlineLarge!
                          .copyWith(fontSize: 20.sp, fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  SizedBox(
                    height: 30.h,
                    child: TabBar(
                        // padding: const EdgeInsets.only(right: 100),

                        labelColor: MyColors.buttonColor,
                        labelPadding: EdgeInsets.only(left: 28.w),
                        isScrollable: true,
                        unselectedLabelColor: Colors.black.withOpacity(0.4),
                        indicatorSize: TabBarIndicatorSize.label,
                        labelStyle: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.w700),
                        indicatorColor: MyColors.buttonColor,
                        tabAlignment: TabAlignment.start,
                        tabs: const [
                          Tab(
                            text: "All",
                          ),
                          Tab(
                            text: "Unread",
                          ),
                        ]),
                  ),
                  Expanded(
                      child: TabBarView(
                    children: [
                      ListView.separated(

                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                ListTile(
                                  leading: Image.asset(MyImgs.newChat,scale: 3,),
                                  title: RichText(
                                    text: TextSpan(
                                        text: "Abdullah Akram",
                                        style: textTheme.titleLarge!.copyWith(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w700),
                                        children: [
                                          TextSpan(
                                            text:
                                                " mentioned you in a comment in a thread:",
                                            style: textTheme.titleLarge!
                                                .copyWith(
                                                    fontSize: 16.sp,
                                                    fontWeight:
                                                        FontWeight.w400),
                                          )
                                        ]),
                                  ),
                                  subtitle: Text(
                                    "02 days ago",
                                    style: textTheme.titleLarge!.copyWith(
                                        fontSize: 12.sp,
                                        color: Colors.black.withOpacity(0.4),
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Divider(height: 1.h,color: Colors.black.withOpacity(0.2),),
                                )
                              ],
                            );
                          },
                          separatorBuilder:
                              (BuildContext context, int index) => SizedBox(
                                    height: 12.h,
                                  ),
                          padding: EdgeInsets.symmetric(vertical: 20.h),
                          itemCount: 8),
                      ListView.separated(

                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                ListTile(
                                  leading: Image.asset(MyImgs.newChat,scale: 3,),
                                  title: RichText(
                                    text: TextSpan(
                                        text: "Abdullah Akram",
                                        style: textTheme.titleLarge!.copyWith(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w700),
                                        children: [
                                          TextSpan(
                                            text:
                                                " mentioned you in a comment in a thread:",
                                            style: textTheme.titleLarge!
                                                .copyWith(
                                                    fontSize: 16.sp,
                                                    fontWeight:
                                                        FontWeight.w400),
                                          )
                                        ]),
                                  ),
                                  subtitle: Text(
                                    "02 days ago",
                                    style: textTheme.titleLarge!.copyWith(
                                        fontSize: 12.sp,
                                        color: Colors.black.withOpacity(0.4),
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Divider(height: 1.h,color: Colors.black.withOpacity(0.2),),
                                )
                              ],
                            );
                          },
                          separatorBuilder:
                              (BuildContext context, int index) => SizedBox(
                                    height: 12.h,
                                  ),
                          padding: EdgeInsets.symmetric(vertical: 20.h),
                          itemCount: 8),

                    ],
                  ))
                ],
              ),
            ));
      },
    );
  }
}
