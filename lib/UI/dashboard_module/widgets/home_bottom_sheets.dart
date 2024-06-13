import 'package:enfil_libre/UI/values/my_colors.dart';
import 'package:enfil_libre/UI/values/my_imgs.dart';
import 'package:enfil_libre/controllers/home_controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../../values/dimens.dart';

class HomeBottomSheets {
  HomeController homeController = Get.find();
  showUpdateUserBottomSheet(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    homeController.getNotificationList();
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
                    padding: EdgeInsets.only(left: 20.w),
                    child: Text(
                      "Notification",
                      style: textTheme.headlineLarge!.copyWith(
                          fontSize: 20.sp, fontWeight: FontWeight.w700),
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
                      notificationTabWidget(textTheme),
                      notificationTabWidget(textTheme, unread: true),
                    ],
                  ))
                ],
              ),
            ));
      },
    );
  }

  Widget shimmerEffect() {
    return Shimmer.fromColors(
        baseColor: MyColors.shimmerBaseColor,
        highlightColor: MyColors.shimmerHighlightColor,
        child: Column(
          children: [
            ListTile(
              leading: Image.asset(
                MyImgs.newChat,
                scale: 3,
              ),
              title: Column(
                children: [
                  Container(
                    height: 20.h,
                    color: MyColors.shimmerBaseColor,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Container(
                    height: 20.h,
                    color: MyColors.shimmerBaseColor,
                  ),
                ],
              ),
              subtitle: Container(
                height: 10.h,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Divider(
                height: 1.h,
                color: Colors.black.withOpacity(0.2),
              ),
            )
          ],
        ));
  }

  Widget notificationTabWidget(TextTheme textTheme, {bool unread = false}) {
    // HomeController homeController = Get.find();
    return Obx(
      () => ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            if (homeController.isNotificationLoad.value) {
              var notification =
                  Get.find<HomeController>().getAllNotifications!.data[index];
              var now = DateTime.now();
              var timeString = "Today";
              var time = DateTime(
                      notification.createdAt.year,
                      notification.createdAt.month,
                      notification.createdAt.day) ==
                  DateTime(now.year, now.month, now.day);
              if (!time) {
                timeString =
                    "${now.difference(notification.createdAt).inDays} days ago";
              }
              if (unread) {
                if (notification.readAt == null) {
                  return Column(
                    children: [
                      ListTile(
                        onTap: () {
                          homeController.readNotificationList(notification.id);
                        },
                        leading: Image.asset(
                          MyImgs.newChat,
                          scale: 3,
                        ),
                        title: Text(
                          notification.data.message,
                          style: textTheme.titleLarge!.copyWith(
                              fontSize: 16.sp, fontWeight: FontWeight.w400),
                        ),
                        subtitle: Text(
                          timeString,
                          style: textTheme.titleLarge!.copyWith(
                              fontSize: 12.sp,
                              color: Colors.black.withOpacity(0.4),
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Divider(
                          height: 1.h,
                          color: Colors.black.withOpacity(0.2),
                        ),
                      )
                    ],
                  );
                } else {
                 return  const SizedBox.shrink();
                }
              } else {
                return Column(
                  children: [
                    ListTile(
                      leading: Image.asset(
                        MyImgs.newChat,
                        scale: 3,
                      ),
                      title: Text(
                        notification.data.message,
                        style: textTheme.titleLarge!.copyWith(
                            fontSize: 16.sp, fontWeight: FontWeight.w400),
                      ),
                      subtitle: Text(
                        timeString,
                        style: textTheme.titleLarge!.copyWith(
                            fontSize: 12.sp,
                            color: Colors.black.withOpacity(0.4),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Divider(
                        height: 1.h,
                        color: Colors.black.withOpacity(0.2),
                      ),
                    )
                  ],
                );
              }
            } else {
              return shimmerEffect();
            }
          },
          separatorBuilder: (BuildContext context, int index) => SizedBox(
                height: 12.h,
              ),
          padding: EdgeInsets.symmetric(vertical: 20.h),
          itemCount: homeController.isNotificationLoad.value
              ? homeController.getAllNotifications!.data.length
              : 6),
    );
  }
}
