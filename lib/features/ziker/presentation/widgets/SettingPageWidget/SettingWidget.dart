import 'package:flutter/material.dart';

import '../../../../../core/colors.dart';

class SettingWidget extends StatefulWidget {
  const SettingWidget({Key? key}) : super(key: key);

  @override
  _SettingWidgetState createState() => _SettingWidgetState();
}

class _SettingWidgetState extends State<SettingWidget> {
  String? _selectedSize;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            _fontSetting(context),
          ],
        ),
      ),
    );
  }

  Widget _fontSetting(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(right: 14, left: 14, top: 18),
        width: double.infinity,
        // padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(16.0), // Rounded corners
        ),
        child: Column(children: <Widget>[
          _titleSettingRow('إعدادات الخطوط'),
          _testFontBorerRow(),
          _fontRadioRow()
        ]));
  }

  Widget _titleSettingRow(String title) {
    return Container(
      padding: EdgeInsets.all(8.0),
      width: double.infinity,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: AppColors.c4Actionbar, // Background color
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0), // Top left corner
          topRight: Radius.circular(16.0), // Top right corner
        ), // Rounded corners
      ),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white, // Text color
          fontSize: 16.0, // Font size
        ),
      ),
    );
  }

  Widget _radioButtons(BuildContext context, int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedSize = _getValue(index);
          });
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Radio<String>(
              value: _getValue(index),
              groupValue: _selectedSize,
              onChanged: (String? value) {
                setState(() {
                  _selectedSize = value;
                });
              },
            ),
            SizedBox(width: 1.0), // Adjust this value to control the space
            Text(
              _getTypeSize(index),
              style: TextStyle(color: Colors.black, fontSize: 14.0),
            ),
          ],
        ),
      ),
    );
  }

  String _getValue(int index) {
    if (index == 1) {
      return 'small';
    } else if (index == 2) {
      return 'median';
    }
    return 'high';
  }

  String _getTypeSize(int index) {
    if (index == 1) {
      return 'صغير';
    } else if (index == 2) {
      return 'متوسط';
    }
    return 'كبير';
  }

  Widget _testFontBorerRow() {
    return Container(
      color: AppColors.c3,
      padding:
      const EdgeInsets.only(top: 6, bottom: 6, right: 8, left: 8),
      alignment: Alignment.centerRight,
      child: const Text(
        'بسم الله الرحمن الرحيم',
        style: TextStyle(fontSize: 18, color: AppColors.c4Actionbar),
      ),
    );
  }

  Widget _fontRadioRow() {
    return Container(
      color: AppColors.white,
      padding:
      const EdgeInsets.only(top: 6, bottom: 6, right: 8, left: 8),
      alignment: Alignment.centerRight,
      child: Row(
        children: <Widget>[
          const Text(
            'حجم الخط:',
            style: TextStyle(fontSize: 18, color: AppColors.c4Actionbar),
          ),
          _radioButtons(context, 1),
          _radioButtons(context, 2),
          _radioButtons(context, 3),
        ],
      ),
    );
  }

}
