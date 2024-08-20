import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/colors.dart';

class SettingWidget extends StatefulWidget {
  const SettingWidget({Key? key}) : super(key: key);

  @override
  _SettingWidgetState createState() => _SettingWidgetState();
}

class _SettingWidgetState extends State<SettingWidget> {
  int? _selectedSize = 2;
  double _textSize = 18.0;

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

  void _handleRadioValueChange(int? value) {
    setState(() {
      _selectedSize = value!;
      switch (_selectedSize) {
        case 1:
          _textSize = 16.0;
          break;
        case 2:
          _textSize = 18.0;
          break;
        case 3:
          _textSize = 20.0;
          break;
      }
    });
  }
  Widget _fontSetting(BuildContext context) {
    return _content(context);
  }
  Widget _content(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(right: 14, left: 14, top: 18),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(children: <Widget>[
          _titleSettingRow('إعدادات الخطوط'),
          _testFontBorerRow(),
          _fontRadioRow(),
          _space()
        ]));
  }



  Widget _titleSettingRow(String title) {
    return Container(
      padding: EdgeInsets.all(8.0),
      width: double.infinity,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: AppColors.c4Actionbar,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
        ),
      ),
    );
  }

  Widget _radioButton(BuildContext context, int index) {
    return Wrap(
      direction: Axis.vertical,
      children: <Widget>[
        GestureDetector(
            onTap: () => _handleRadioValueChange(index),
            child: Container(
                height: 28,
                child: Row(children: [
                  Radio<int>(
                    value: index,
                    groupValue: _selectedSize,
                    onChanged: _handleRadioValueChange,
                  ),
                  Text(
                    _getTypeSize(index),
                    style: TextStyle(color: Colors.black, fontSize: 16.0),
                  ),
                ])))
      ],
    );
    // ),
    // ));
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
      padding: const EdgeInsets.only(top: 6, bottom: 6, right: 8, left: 8),
      alignment: Alignment.centerRight,
      child: Text(
        'بسم الله الرحمن الرحيم',
        style: TextStyle(
            fontSize: _textSize, color: AppColors.c4Actionbar),
      ),
    );
  }

  Widget _fontRadioRow() {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.only(top: 6, bottom: 6, right: 8, left: 8),
      alignment: Alignment.centerRight,
      child: Row(
        children: <Widget>[_tv('حجم الخط:'), _radioGroup(context)],
      ),
    );
  }

  Widget _tv(String str) {
    return Text(
      str,
      style: TextStyle(
          fontSize: 18.0, color: AppColors.c4Actionbar),
    );
  }

  Widget _space() {
    return Container(
      color: AppColors.c4Actionbar,
      height: 4,
    );
  }

  Widget _radioGroup(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _radioButton(context, 1),
        _radioButton(context, 2),
        _radioButton(context, 3),
      ],
    );
  }
}
