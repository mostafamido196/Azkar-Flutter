import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/FontSize.dart';
import '../../../../../core/Utils.dart';
import '../../../../../core/colors.dart';
import '../../../../../core/widgets/loading_widget.dart';
import '../../../domain/entities/Setting.dart';
import '../../bloc/azkar/setting/SettingBloc.dart';

class SettingWidget extends StatefulWidget {
  final Setting setting;
  final ValueChanged<Setting> onSettingChanged;
  final int pageFontSize;

  SettingWidget(
      {required this.setting,
      required this.onSettingChanged,
      required this.pageFontSize,
      Key? key})
      : super(key: key);

  @override
  _SettingWidgetState createState() => _SettingWidgetState();
}

class _SettingWidgetState extends State<SettingWidget> {
  int _fontSizeType = 2; // to constant initial font size

  bool isInitialedSize = true; // to initialize setting first time only

  late Setting setting;

  @override
  void initState() {
    super.initState();
    setting = widget.setting;
    _fontSizeType = widget.pageFontSize;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingBloc, SettingState>(
      builder: (context, state) {
        if (state is LoadedSettingState) {
          _initialSetting(state.setting);
          return _settingWidget(context);
        }
        _initialSetting(setting);
        return _settingWidget(context);
      },
    );
  }

  Widget _settingWidget(BuildContext context) {
    return  Container(
        color: AppColors.c2Read,
        margin: const EdgeInsets.only(top: 6),
        child: SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 20, right: 6, left: 6),
      child: Column(
        children: <Widget>[
          _fontSetting(context),
          _counterSetting(context),
          _notifySleepAndWolkUpSetting(context),
          _notifyPraysSetting(context),
        ],
      ),
    ));
  }

  void _handleRadioValueChange(int? value) {
    setState(() {
      setting.fontSize = _getFontType(value!);
    });
    widget.onSettingChanged(setting);
  }

  Widget _fontSetting(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 2),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(children: <Widget>[
          _titleSettingRow('إعدادات الخطوط'),
          _testFontBorerRow(),
          _fontRadioRow(),
          _spaceBottom()
        ]));
  }

  Widget _counterSetting(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 6),
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
          _spaceBottom()
        ]));
  }

  Widget _notifySleepAndWolkUpSetting(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 6),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(children: <Widget>[
          _titleSettingRow('إعدادات إشعارات النوم والاستيقاظ'),
          _walkUpNotifySettingRow(),
          _spaceBetween(),
          _sleepNotifySettingRow(),
          _spaceBottom()
        ]));
  }

  Widget _notifyPraysSetting(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 8),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(children: <Widget>[
          _titleSettingPrayNotificationRow('إعدادات إشعارات دبر الصلوات'),
          _fagrNotifySettingRow(),
          _spaceBetween(),
          _duhrNotifySettingRow(),
          _spaceBetween(),
          _aserNotifySettingRow(),
          _spaceBetween(),
          _magrepNotifySettingRow(),
          _spaceBetween(),
          _ishaaNotifySettingRow(),
          _spaceBottom(),
        ]));
  }

  Widget _titleSettingRow(String title) {
    return Container(
        padding: const EdgeInsets.all(8.0),
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
              fontSize: Utils().fontSize(_fontSizeType) + 2,
            )));
  }

  Widget _titleSettingPrayNotificationRow(String title) {
    return Container(
        decoration: const BoxDecoration(
          color: AppColors.c4Actionbar,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              width: double.infinity,
              alignment: Alignment.center,
              child: Text(title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Utils().fontSize(_fontSizeType) + 2,
                  )),
            ),
            Container(
                color: AppColors.bgReloudColor,
                padding: const EdgeInsets.all(4.0),
                child: GestureDetector(
                    onTap: () {
                      // Handle the tap event here
                    },
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(right: 12),
                          child: Image.asset(
                            'assets/images/reload.png',
                            width: 22,
                            height: 22,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                            padding: const EdgeInsets.only(right: 12),
                            child: Text("تحميل اوقات الصلوات",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Utils().fontSize(_fontSizeType),
                                )))
                      ],
                    )))
          ],
        ));
  }

  Widget _radioButton(BuildContext context, int index) {
    return Wrap(
      direction: Axis.vertical,
      children: <Widget>[
        GestureDetector(
            onTap: () {
              _handleRadioValueChange(index);
            },
            child: SizedBox(
                height: 28,
                child: Row(children: [
                  Radio<int>(
                    value: index,
                    groupValue: _getFontIndex(setting.fontSize),
                    onChanged: (value) {
                      _handleRadioValueChange(value);

                      setState(() {
                        setting.fontSize = _getFontType(index);
                      });
                      widget.onSettingChanged(setting);
                    },
                  ),
                  Text(
                    _getTypeSizeArabic(index),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: Utils().fontSize(_fontSizeType)),
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
        style: TextStyle(
            fontSize: Utils().fontSize(setting.fontSize),
            color: AppColors.c4Actionbar),
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
      padding: const EdgeInsets.only( right: 8, left: 8),
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
      padding: const EdgeInsets.only( right: 8, left: 8),
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
      padding: const EdgeInsets.only( right: 8, left: 8),
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
      padding: const EdgeInsets.only( right: 8, left: 8),
      alignment: Alignment.centerRight,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(child: _tv('الاستيقاظ من النوم')),
              _walkUpNotifySwitcher()
            ],
          ),
          _pickerWalkUpRow()
        ],
      ),
    );
  }

  Widget _fagrNotifySettingRow() {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.only( right: 8, left: 8),
      alignment: Alignment.centerRight,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(child: _tv('صلاة الفجر')),
              _fagrNotifySwitcher()
            ],
          ),
          _pickerFagrRow()
        ],
      ),
    );
  }

  Widget _duhrNotifySettingRow() {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.only( right: 8, left: 8),
      alignment: Alignment.centerRight,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(child: _tv('صلاة الظهر')),
              _duherNotifySwitcher()
            ],
          ),
          _pickerDuherRow()
        ],
      ),
    );
  }

  Widget _aserNotifySettingRow() {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.only( right: 8, left: 8),
      alignment: Alignment.centerRight,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(child: _tv('صلاة العصر')),
              _aserNotifySwitcher()
            ],
          ),
          _pickerAserRow()
        ],
      ),
    );
  }

  Widget _magrepNotifySettingRow() {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.only( right: 8, left: 8),
      alignment: Alignment.centerRight,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(child: _tv('صلاة المغرب')),
              _magrepNotifySwitcher()
            ],
          ),
          _pickerMagrepRow()
        ],
      ),
    );
  }

  Widget _ishaaNotifySettingRow() {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.only( right: 8, left: 8),
      alignment: Alignment.centerRight,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(child: _tv('صلاة العشاء')),
              _ishaNotifySwitcher()
            ],
          ),
          _pickerIshaRow()
        ],
      ),
    );
  }

  Widget _sleepNotifySettingRow() {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.only( right: 8, left: 8),
      alignment: Alignment.centerRight,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(child: _tv('النوم')),
              _sleepNotifySwitcher()
            ],
          ),
          _pickerSleepRow()
        ],
      ),
    );
  }

  Widget _tv(String str) {
    return Text(
      str,
      style: TextStyle(
          fontSize: Utils().fontSize(_fontSizeType),
          color: AppColors.c4Actionbar),
    );
  }

  Widget _spaceBottom() {
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
        _fontSizeType = 2;
        break;
      case FontSize.Small:
        _fontSizeType = 1;
        break;
      case FontSize.Large:
        _fontSizeType = 3;
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

  int _getFontIndex(FontSize fontSize) {
    switch (fontSize) {
      case FontSize.Large:
        return 3;
      case FontSize.Median:
        return 2;
    }
    return 1;
  }

  Widget _transferSwitcher() {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: Switch(
        value: setting.transfer,
        onChanged: (value) {
          setState(() {
            setting.transfer = value;
          });
          widget.onSettingChanged(setting);

          // BlocProvider.of<SettingBloc>(context)
          //     .add(UpdateSettingEvent(setting: setting));
        },
        activeTrackColor: AppColors.switch_track_selector,
        activeColor: AppColors.c4Actionbar,
      ),
    );
  }

  Widget _vibrateSwitcher() {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: Switch(
        value: setting.vibrate,
        onChanged: (value) {
          setState(() {
            setting.vibrate = value;
          });
          widget.onSettingChanged(setting);
          // BlocProvider.of<SettingBloc>(context)
          //     .add(UpdateSettingEvent(setting: setting));
        },
        activeTrackColor: AppColors.switch_track_selector,
        activeColor: AppColors.c4Actionbar,
      ),
    );
  }

  Widget _noiseSwitcher() {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: Switch(
        value: setting.noisy,
        onChanged: (value) {
          setState(() {
            setting.noisy = value;
          });
          widget.onSettingChanged(setting);
          // BlocProvider.of<SettingBloc>(context)
          //     .add(UpdateSettingEvent(setting: setting));
        },
        activeTrackColor: AppColors.switch_track_selector,
        activeColor: AppColors.c4Actionbar,
      ),
    );
  }

  Widget _walkUpNotifySwitcher() {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: Switch(
        value: setting.isWalkUp,
        onChanged: (value) {
          setState(() {
            setting.isWalkUp = value;
          });
          widget.onSettingChanged(setting);
        },
        activeTrackColor: AppColors.switch_track_selector,
        activeColor: AppColors.c4Actionbar,
      ),
    );
  }

  Widget _fagrNotifySwitcher() {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: Switch(
        value: setting.isFager,
        onChanged: (value) {
          setState(() {
            setting.isFager = value;
          });
          widget.onSettingChanged(setting);
        },
        activeTrackColor: AppColors.switch_track_selector,
        activeColor: AppColors.c4Actionbar,
      ),
    );
  }

  Widget _duherNotifySwitcher() {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: Switch(
        value: setting.isDuher,
        onChanged: (value) {
          setState(() {
            setting.isDuher = value;
          });
          widget.onSettingChanged(setting);
        },
        activeTrackColor: AppColors.switch_track_selector,
        activeColor: AppColors.c4Actionbar,
      ),
    );
  }

  Widget _aserNotifySwitcher() {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: Switch(
        value: setting.isAser,
        onChanged: (value) {
          setState(() {
            setting.isAser = value;
          });
          widget.onSettingChanged(setting);
        },
        activeTrackColor: AppColors.switch_track_selector,
        activeColor: AppColors.c4Actionbar,
      ),
    );
  }

  Widget _magrepNotifySwitcher() {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: Switch(
        value: setting.isMagrep,
        onChanged: (value) {
          setState(() {
            setting.isMagrep = value;
          });
          widget.onSettingChanged(setting);
        },
        activeTrackColor: AppColors.switch_track_selector,
        activeColor: AppColors.c4Actionbar,
      ),
    );
  }

  Widget _ishaNotifySwitcher() {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: Switch(
        value: setting.isIsha,
        onChanged: (value) {
          setState(() {
            setting.isIsha = value;
          });
          widget.onSettingChanged(setting);
        },
        activeTrackColor: AppColors.switch_track_selector,
        activeColor: AppColors.c4Actionbar,
      ),
    );
  }

  Widget _sleepNotifySwitcher() {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: Switch(
        value: setting.isSleep,
        onChanged: (value) {
          setState(() {
            setting.isSleep = value;
          });
          widget.onSettingChanged(setting);
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
      _fontSizeType = _getItemSelected(setting.fontSize);
      _initialSizeState(setting.fontSize);
    }
  }

  Future<void> _selectWalkUpTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: setting.walkUp,
    );
    if (picked != null && picked != setting.walkUp) {
      setState(() {
        setting.walkUp = picked;
      });
      widget.onSettingChanged(setting);
    }
  }

  Future<void> _selectFagerTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: setting.fager,
    );
    if (picked != null && picked != setting.fager) {
      setState(() {
        setting.fager = picked;
      });
      widget.onSettingChanged(setting);
    }
  }

  Future<void> _selectDuherTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: setting.duher,
    );
    if (picked != null && picked != setting.duher) {
      setState(() {
        setting.duher = picked;
      });
      widget.onSettingChanged(setting);
    }
  }

  Future<void> _selectAserTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: setting.aser,
    );
    if (picked != null && picked != setting.aser) {
      setState(() {
        setting.aser = picked;
      });
      widget.onSettingChanged(setting);
    }
  }

  Future<void> _selectMagrapTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: setting.magrep,
    );
    if (picked != null && picked != setting.magrep) {
      setState(() {
        setting.magrep = picked;
      });
      widget.onSettingChanged(setting);
    }
  }

  Future<void> _selectIshaTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: setting.isha,
    );
    if (picked != null && picked != setting.isha) {
      setState(() {
        setting.isha = picked;
      });
      widget.onSettingChanged(setting);
    }
  }

  Future<void> _selectSleepTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: setting.sleep,
    );
    if (picked != null && picked != setting.sleep) {
      setState(() {
        setting.sleep = picked;
      });
      widget.onSettingChanged(setting);
    }
  }

  Widget _pickerWalkUpRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          setting.walkUp.format(context).replaceArabicNumbers(),
          style: TextStyle(fontSize: Utils().fontSize(_fontSizeType)),
        ),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: () => _selectWalkUpTime(context),
          child: const Padding(
            padding: EdgeInsets.only(left: 16),
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

  Widget _pickerFagrRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          setting.fager.format(context).replaceArabicNumbers(),
          style: TextStyle(fontSize: Utils().fontSize(_fontSizeType)),
        ),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: () => _selectFagerTime(context),
          child: const Padding(
            padding: EdgeInsets.only(left: 16),
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

  Widget _pickerDuherRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          setting.duher.format(context).replaceArabicNumbers(),
          style: TextStyle(fontSize: Utils().fontSize(_fontSizeType)),
        ),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: () => _selectDuherTime(context),
          child: const Padding(
            padding: EdgeInsets.only(left: 16),
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

  Widget _pickerAserRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          setting.aser.format(context).replaceArabicNumbers(),
          style: TextStyle(fontSize: Utils().fontSize(_fontSizeType)),
        ),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: () => _selectAserTime(context),
          child: const Padding(
            padding: EdgeInsets.only(left: 16),
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

  Widget _pickerMagrepRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          setting.magrep.format(context).replaceArabicNumbers(),
          style: TextStyle(fontSize: Utils().fontSize(_fontSizeType)),
        ),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: () => _selectMagrapTime(context),
          child: const Padding(
            padding: EdgeInsets.only(left: 16),
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

  Widget _pickerIshaRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          setting.isha.format(context).replaceArabicNumbers(),
          style: TextStyle(fontSize: Utils().fontSize(_fontSizeType)),
        ),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: () => _selectIshaTime(context),
          child: const Padding(
            padding: EdgeInsets.only(left: 16),
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

  Widget _pickerSleepRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          setting.sleep.format(context).replaceArabicNumbers(),
          style: TextStyle(fontSize: Utils().fontSize(_fontSizeType)),
        ),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: () => _selectSleepTime(context),
          child: const Padding(
            padding: EdgeInsets.only(left: 16),
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

  bool _ifNotNull(TimeOfDay? time) {
    if (time == null) return false;
    return true;
  }
}
