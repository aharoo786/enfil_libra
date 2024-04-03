import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../user_module/user_profile.dart';
import '../../values/my_colors.dart';
import '../../values/my_imgs.dart';
import '../../widgets/app_bar_widget.dart';
import '../home_screen/create_habit_screen.dart';
import '../home_screen/home_screen.dart';
import '../home_screen/my_challenges_screen.dart';
import '../home_screen/my_routines_screen.dart';
import '../widgets/custom_bottomNavigationBar.dart';

class DashboardScreen extends StatefulWidget {
  int? index;
  DashboardScreen({Key? key, this.index = 0}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreen();
}

class _DashboardScreen extends State<DashboardScreen> {
  // int _currentIndex = wi;
  final List<Widget> _widgetOption = [
    HomeScreen(),
    MyChallengesScreen(),
    CreateHabitScreen(),
    Container()
  ];

  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: MyColors.splashColor),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(top: 7),
          child: GestureDetector(
              onTap: () {
                Get.to(() => UserProfile());
              },
              child: SvgPicture.asset(MyImgs.profilIcons)),
        ),
        titleSpacing: 0,
        backgroundColor: MyColors.splashColor,
        title: HelpingWidgets()
            .appBarText("Hello 👋, Virginie ", color: MyColors.buttonColor),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications_none_outlined,
                color: MyColors.iconColor2,
                size: 36.w,
              ))
        ],
      ),
      body: _widgetOption.elementAt(widget.index!),
      bottomNavigationBar: CustomBottomNavigationBar(
        index: widget.index!,
        onIndexChanged: (index) {
          setState(() {
            widget.index = index;
          });

          if (widget.index! > 0) {
            // Navigate or perform other actions based on index
          }
        },
      ),
    );
  }
}