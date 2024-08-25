import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  int? _selectedSize = 2; // to make test text widget
  double _textSize = 18.0; // to make test widget

  bool isInitialedSize = true; // to initialize setting first time only
  TimeOfDay _selectedTime = TimeOfDay.now(); // to use pick up time

  Setting setting = Setting(
      fontSize: FontSize.Median,
      noisy: true,
      vibrate: true,
      transfer: true);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<SettingBloc, SettingState>(
        builder: (context, state) {
          if (state is LoadedSettingState) {
            _initialSetting(state.setting);
            _selectedSize = _getItemSelected(setting.fontSize);
            _textSize = Utils().fontSize(setting.fontSize);
            return _settingWidget(context);
          }
          _initialSetting(setting);
          return _settingWidget(context);
        },
      ),
    );
  }

  Widget _settingWidget(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            _fontSetting(context),
            _counterSetting(context),
            _notifySetting(context)
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
          _textSize = Utils().fontSize(FontSize.Small);
          break;
        case 2:
          _textSize = Utils().fontSize(FontSize.Median);
          break;
        case 3:
          _textSize = Utils().fontSize(FontSize.Large);
          break;
      }
    });
  }

  Widget _fontSetting(BuildContext context) {
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

  Widget _counterSetting(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(right: 14, left: 14, top: 18),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(children: <Widget>[
          _titleSettingRow('إعدادات السبحة'),
          _transferSettingRow(),
          _spaceBetween(),
          _vibrateSettingRow(),
          _spaceBetween(),
          _noiseSettingRow(),
          _space()
        ]));
  }

  Widget _notifySetting(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(right: 14, left: 14, top: 18),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(children: <Widget>[
          _titleSettingRow('إعدادات الإشعارات'),
          _walkUpNotifySettingRow(),
          _spaceBetween(),
          _sleepNotifySettingRow(),
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
        child: Text(title,
            style: TextStyle(
              color: Colors.white,
              fontSize: Utils().fontSize(setting.fontSize)+2,
            )));
  }

  Widget _radioButton(BuildContext context, int index) {
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
                    onChanged: (value) {
                      _handleRadioValueChange(value);
                      BlocProvider.of<SettingBloc>(context)
                          .add(UpdateSettingEvent(setting:
                      Setting(
                        transfer: setting.transfer,
                        fontSize: _getFontType(index),
                        noisy: setting.noisy,
                        vibrate: setting.vibrate,
                      )
                      ));
                    },
                  ),
                  Text(
                    _getTypeSizeArabic(index),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: Utils().fontSize(setting.fontSize)),
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
      child: Text(
        'بسم الله الرحمن الرحيم',
        style: TextStyle(fontSize: _textSize, color: AppColors.c4Actionbar),
      ),
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

  Widget _transferSettingRow() {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.only(top: 6, bottom: 6, right: 8, left: 8),
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(child: _tv('الإنتقال للذكر التالي بعد انتهاء العد')),
          _transferSwitcher()
        ],
      ),
    );
  }

  Widget _vibrateSettingRow() {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.only(top: 6, bottom: 6, right: 8, left: 8),
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // Positions text at start and switcher at end
        children: <Widget>[
          Expanded(child: _tv('الإهتزاز عند الإنتقال للذكر التالي')),
          _vibrateSwitcher()
        ],
      ),
    );
  }

  Widget _noiseSettingRow() {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.only(top: 6, bottom: 6, right: 8, left: 8),
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // Positions text at start and switcher at end
        children: <Widget>[
          Expanded(child: _tv('تشغيل الصوت عند استخدام السبحة')),
          _noiseSwitcher()
        ],
      ),
    );
  }

  Widget _walkUpNotifySettingRow() {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.only(top: 6, bottom: 6, right: 8, left: 8),
      alignment: Alignment.centerRight,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(child: _tv('الاستيقاظ من النوم')),
              _sleepNotifySwitcher()
            ],
          ),
          _pickerWalkUpRow()
        ],
      ),
    );
  }

  Widget _sleepNotifySettingRow() {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.only(top: 6, bottom: 6, right: 8, left: 8),
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // Positions text at start and switcher at end
        children: <Widget>[
          Expanded(child: _tv('النوم')),
          _sleepNotifySwitcher()
        ],
      ),
    );
  }

  Widget _tv(String str) {
    return Text(
      str,
      style: TextStyle(
          fontSize: Utils().fontSize(setting.fontSize),
          color: AppColors.c4Actionbar),
    );
  }

  Widget _space() {
    return Container(
      height: 4,
      decoration: const BoxDecoration(
        color: AppColors.c4Actionbar, // Set the color here
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16.0), // Adjust the radius as needed
          bottomRight: Radius.circular(16.0),
        ),
      ),
    );
  }

  Widget _spaceBetween() {
    return Container(
      color: AppColors.c4Actionbar, // Set the color here
      height: 1,
    );
  }

  Widget _radioGroupBloc(BuildContext context) {
    return _radioGroup();
  }

  int _getItemSelected(FontSize fontSize) {
    switch (fontSize) {
      case FontSize.Small:
        return 1;
      case FontSize.Median:
        return 2;
      case FontSize.Large:
        return 3;
    }
  }

  Widget _radioGroup() {
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

  void _initialSizeState(FontSize fontSize) {
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

  FontSize _getFontType(int index) {
    switch (index) {
      case 1:
        return FontSize.Small;
      case 3:
        return FontSize.Large;
    }
    return FontSize.Median;
  }

  Widget _transferSwitcher() {
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: Switch(
        value: setting.transfer,
        onChanged: (value) {
          setState(() {
            setting.transfer = value;
          });
          BlocProvider.of<SettingBloc>(context)
              .add(UpdateSettingEvent(setting: setting));
        },
        activeTrackColor: AppColors.switch_track_selector,
        activeColor: AppColors.c4Actionbar,
      ),
    );
  }

  Widget _vibrateSwitcher() {
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: Switch(
        value: setting.vibrate,
        onChanged: (value) {
          setState(() {
            setting.vibrate = value;
          });
          BlocProvider.of<SettingBloc>(context)
              .add(UpdateSettingEvent(setting: setting));
        },
        activeTrackColor: AppColors.switch_track_selector,
        activeColor: AppColors.c4Actionbar,
      ),
    );
  }

  Widget _noiseSwitcher() {
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: Switch(
        value: setting.noisy,
        onChanged: (value) {
          setState(() {
            setting.noisy = value;
          });
          BlocProvider.of<SettingBloc>(context)
              .add(UpdateSettingEvent(setting: setting));
        },
        activeTrackColor: AppColors.switch_track_selector,
        activeColor: AppColors.c4Actionbar,
      ),
    );
  }

  Widget _walkUpNotifySwitcher() {
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: Switch(
        value: true, //setting.noisy,
        onChanged: (value) {
          // setState(() {
          //   setting.noisy = value;
          // });
          // BlocProvider.of<SettingBloc>(context)
          //     .add(UpdateSettingEvent(setting: setting));
        },
        activeTrackColor: AppColors.switch_track_selector,
        activeColor: AppColors.c4Actionbar,
      ),
    );
  }

  Widget _sleepNotifySwitcher() {
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: Switch(
        value: true, //setting.noisy,
        onChanged: (value) {
          // setState(() {
          //   setting.noisy = value;
          // });
          // BlocProvider.of<SettingBloc>(context)
          //     .add(UpdateSettingEvent(setting: setting));
        },
        activeTrackColor: AppColors.switch_track_selector,
        activeColor: AppColors.c4Actionbar,
      ),
    );
  }

  void _initialSetting(Setting setting) {
    if (isInitialedSize) {
      isInitialedSize = false;
      this.setting = setting;
      _initialSizeState(setting.fontSize);
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  Widget _pickerWalkUpRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          _selectedTime.format(context).replaceArabicNumbers(),
          style: TextStyle(fontSize: Utils().fontSize(setting.fontSize)),
        ),
        SizedBox(height: 16),
        GestureDetector(
          onTap: () => _selectTime(context),
          child: const Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Icon(
              Icons.edit,
              size: 24,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
