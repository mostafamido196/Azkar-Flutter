import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/FontSize.dart';
import '../../../../../core/Utils.dart';
import '../../../../../core/colors.dart';
import '../../../domain/entities/Setting.dart';
import '../../bloc/azkar/setting/SettingBloc.dart';

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
          _titleSettingRow(),
          _testFontBorerRow(),
          _fontRadioRow(),
          _space()
        ]));
  }

  Widget _titleSettingRow() {
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
      child: BlocBuilder<SettingBloc, SettingState>(
        builder: (context, state) {
          if (state is LoadedSettingState) {
            return Text('إعدادات الخطوط',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: Utils().fontSize(state.setting.fontSize),
                ));
          }
          return Text('إعدادات الخطوط',
              style: TextStyle(
                color: Colors.white,
                fontSize: Utils().fontSize(FontSize.Median),
              ));
        },
      ),
    );
  }

  Widget _radioButton(BuildContext context, int index, FontSize fontSize) {
    _initialSizeState(fontSize);
    return Wrap(
      direction: Axis.vertical,
      children: <Widget>[
        GestureDetector(
            onTap: () {
              _handleRadioValueChange(index);
            },
            child: Container(
                height: 28,
                child: Row(children: [
                  Radio<int>(
                    value: index,
                    groupValue: _selectedSize,
                    onChanged: (value){
                      _handleRadioValueChange(value);
                      BlocProvider.of<SettingBloc>(context)
                          .add(UpdateSettingEvent(setting: _getFontSetting(index)));

                    },
                  ),
                  Text(
                    _getTypeSizeArabic(index),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: Utils().fontSize(fontSize)),
                  ),
                ])))
      ],
    );
    // ),
    // ));
  }

  String _getTypeSizeArabic(int index) {
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
      child: BlocBuilder<SettingBloc, SettingState>(builder: (context, state) {
        if (state is LoadedSettingState) {
          return Text(
            'بسم الله الرحمن الرحيم',
            style: TextStyle(
                fontSize: Utils().fontSize(state.setting.fontSize),
                color: AppColors.c4Actionbar),
          );
        }
        return Text(
          'بسم الله الرحمن الرحيم',
          style: TextStyle(fontSize: _textSize, color: AppColors.c4Actionbar),
        );
      }),
    );
  }

  Widget _fontRadioRow() {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.only(top: 6, bottom: 6, right: 8, left: 8),
      alignment: Alignment.centerRight,
      child: Row(
        children: <Widget>[_tv('حجم الخط:'), _radioGroupBloc(context)],
      ),
    );
  }

  Widget _tv(String str) {
    return BlocBuilder<SettingBloc, SettingState>(
      builder: (context, state) {
        if (state is LoadedSettingState) {
          return Text(str,
              style: TextStyle(
                color: AppColors.c4Actionbar,
                fontSize: Utils().fontSize(state.setting.fontSize),
              ));
        }

        return Text(
          str,
          style: TextStyle(fontSize: 18.0, color: AppColors.c4Actionbar),
        );
      },
    );
  }

  Widget _space() {
    return Container(
      color: AppColors.c4Actionbar,
      height: 4,
    );
  }

  Widget _radioGroupBloc(BuildContext context) {
    return BlocBuilder<SettingBloc, SettingState>(
      builder: (context, state) {
        if (state is LoadedSettingState) {
          return _radioGroup(state.setting.fontSize);
        }

        return _radioGroup(FontSize.Median);
      },
    );
  }

  Widget _radioGroup(FontSize fontSize) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _radioButton(context, 1, fontSize),
        _radioButton(context, 2, fontSize),
        _radioButton(context, 3, fontSize),
      ],
    );
  }

  bool isInitialedSize = true;

  void _initialSizeState(FontSize fontSize) {
    if (isInitialedSize) {
      isInitialedSize = false;
      switch (fontSize) {
        case FontSize.Median:
          _selectedSize = 2;
          break;
        case FontSize.Small:
          _selectedSize = 1;
          break;
        case FontSize.Large:
          _selectedSize = 3;
          break;
      }
    }
  }

  FontSize _getFontType(int index) {
    switch (index) {
      case 1:
        return FontSize.Small;
      case 3:
        return FontSize.Large;
    }
    return FontSize.Median;
  }

  Setting _getFontSetting(int index) {
    return Setting(
        fontSize: _getFontType(index),
        noisy: false,
        vibrate: true,
        notify: true);
  }
}
