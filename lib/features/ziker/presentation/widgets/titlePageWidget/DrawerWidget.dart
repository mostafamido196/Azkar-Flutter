import 'package:azkar/core/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topRight: Radius.circular(0))
        ),
        width: 260,
        child: Container(
          color: AppColors.c1Drawer,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              _buildHeader(),
              _buildFirstListTile(
                'assets/images/ic_menu.svg',
                'الأذكار',
                AppColors.c4Actionbar,
              ),
              _buildListTile(
                'assets/images/baseline_settings_24.svg',
                'الإعدادات',
                AppColors.white,
              ),
              _buildListTile(
                'assets/images/baseline_error_24_white.svg',
                'عن التطبيق',
                AppColors.white,
              ),
            ]
          ),
        ));
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.only(left: 14, bottom: 14, top: 14, right: 14),
      decoration: BoxDecoration(color: AppColors.c4Actionbar),
      child: const Text(
        "ۛ ּڝــحۡــۑْۧــحۡ اﻷذڪــٰٱڕ",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'typesetting',
          color: Colors.white,
          fontSize: 40,
        ),
      ),
    );
  }

  Widget _buildFirstListTile(String asset, String title, Color textColor) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ListTile(
        leading: SvgPicture.asset(
          asset,
          width: 16.0,
          height: 16.0,
        ),
        title: Text(title),
        textColor: textColor,
        onTap: () {
       //   Handle onTap
        },
      ),
    );
  }

  Widget _buildListTile(String asset, String title, Color textColor) {
    return ListTile(
      leading: SvgPicture.asset(
        asset,
        width: 24.0,
        height: 24.0,
      ),
      title: Text(title),
      textColor: textColor,
      onTap: () {
        // Handle onTap
      },
    );
  }
}
