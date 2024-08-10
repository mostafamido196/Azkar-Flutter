import 'package:azkar/core/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DrawerWidget extends StatelessWidget {
  final bool isOpen;

  const DrawerWidget({
    required this.isOpen,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          left: isOpen ? 0 : -250,
          top: 0,
          bottom: 0,
          width: 250,
          child: Container(
            color: AppColors.c1Drawer,
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: AppColors.c4Actionbar,
                  ),
                  child: Text(
                    "ۛ ּڝــحۡــۑْۧــحۡ ا̍ﻷ̍ذڪــٰٱ̍ڕ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'typesetting',
                      color: Colors.white,
                      fontSize: 36,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.white, // Set your desired background color here
                    borderRadius: BorderRadius.circular(12.0), // Adjust the radius as needed
                  ),
                  child: ListTile(
                    leading: SvgPicture.asset(
                      'assets/images/ic_menu.svg',
                      width: 16.0,
                      height: 16.0,
                    ),
                    title: const Text('الأذكار'),
                    textColor: AppColors.c4Actionbar,
                    onTap: () {
                      // onToggle();
                    },
                  ),
                )

                ,
                Container(
                  child: ListTile(
                    leading: SvgPicture.asset(
                      'assets/images/baseline_settings_24.svg',
                      width: 24.0,
                      height: 24.0,
                      color: AppColors.white,
                    ),
                    title: const Text('الإعدادات'),
                    textColor: AppColors.white,
                    onTap: () {
                      // onToggle();
                    },
                  ),
                ),
                Container(
                  child: ListTile(
                    leading: SvgPicture.asset(
                      'assets/images/baseline_error_24_white.svg',
                      width: 24.0,
                      height: 24.0,
                    ),
                    title: const Text('عن التطبيق'),
                    textColor: AppColors.white,
                    onTap: () {
                      // onToggle();
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
