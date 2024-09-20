import 'package:azkar/core/utils/FontSize.dart';
import 'package:azkar/core/utils/notification_helper.dart';
import 'package:azkar/features/ziker/presentation/bloc/azkar/setting/SettingBloc.dart';
import 'package:azkar/features/ziker/presentation/widgets/SettingPageWidget/SettingWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/Utils.dart';
import '../../domain/entities/Setting.dart';


class SettingScreen extends StatefulWidget {
  SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  Setting setting = Setting(
    fontSize: FontSize.Median,
    noisy: true,
    vibrate: true,
    transfer: true,
    walkUp: TimeOfDay(hour: 6, minute: 30),
    isWalkUp: true,
    sleep: TimeOfDay(hour: 22, minute: 0),
    isSleep: true,
    morning: TimeOfDay(hour: 9, minute: 0),
    isMorning: true,
    evening: TimeOfDay(hour: 17, minute: 0),
    isEvening: true,
    fager: TimeOfDay(hour: 4, minute: 30),
    isFager: true,
    duher: TimeOfDay(hour: 12, minute: 30),
    isDuher: true,
    aser: TimeOfDay(hour: 16, minute: 0),
    isAser: true,
    magrep: TimeOfDay(hour: 18, minute: 10),
    isMagrep: true,
    isha: TimeOfDay(hour: 19, minute: 0),
    isIsha: true,
  );
  int _fontSizeType = 2;
  bool isInitialedSize = true; // to initialize setting first time only

  void _updateSetting(Setting newSetting) {
    setState(() {
      setting = newSetting;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: _buildAppbar(context),
          body: _buildBody(),
        ) );
  }

  AppBar _buildAppbar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () async {
          _done();
        },
      ),
      title: BlocBuilder<SettingBloc, SettingState>(
        builder: (context, state) {
          if (state is LoadingSettingState) {
            // return const Text('الإعدادات');
          } else if (state is LoadedSettingState) {
            _initialSetting(state.setting);
            return Text(
              'الإعدادات',
              style: TextStyle(fontSize: Utils().fontSize(_fontSizeType)),
            );
          } else if (state is ErrorSettingState) {
            return Text(
              'الإعدادات',
              style: TextStyle(fontSize: Utils().fontSize(FontSize.Median)),
            );
          }
          return const Text('الإعدادات');
        },
      ),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              _done();
            },
            child: Text('تم',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: Utils().fontSize(_fontSizeType)))),
      ],
    );
  }

  Widget _buildBody() {
    return SettingWidget(
        setting: setting,
        onSettingChanged: _updateSetting,
        pageFontSize: _fontSizeType);
  }

  void _done() async {
    BlocProvider.of<SettingBloc>(context)//.updateSetting(setting);
        .add(UpdateSettingEvent(setting: setting));

    //when the updateEvent is done will start getSettingEvent
    final settingBloc = context.read<SettingBloc>();
    await for (final state in settingBloc.stream) {
      if (state is MessageUpdateSettingState) {
        settingBloc.add(GetOldSettingEvent());
        break;
      }
    }
    pushNotification();
    //
    Navigator.pop(context);
  }

  void _initialSetting(Setting setting) {
    if (isInitialedSize) {
      isInitialedSize = false;
      this.setting = setting;
      _fontSizeType = _getItemSelected(setting.fontSize);
      _initialSizeState(setting.fontSize);
    }
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

  void pushNotification() {
    DateTime now = DateTime.now();
    _setTimeNotification(id: 1, time: setting.walkUp, turnOn: setting.isWalkUp,now:now);
    _setTimeNotification(id: 2, time: setting.sleep, turnOn: setting.isSleep,now:now);
    _setTimeNotification(id: 3, time: setting.morning, turnOn: setting.isMorning,now:now);
    _setTimeNotification(id: 4, time: setting.evening, turnOn: setting.isEvening,now:now);
    _setTimeNotification(id: 5, time: setting.fager, turnOn: setting.isFager,now:now);
    _setTimeNotification(id: 6, time: setting.duher, turnOn: setting.isDuher,now:now);
    _setTimeNotification(id: 7, time: setting.aser, turnOn: setting.isAser,now:now);
    _setTimeNotification(id: 8, time: setting.magrep, turnOn: setting.isMorning,now:now);
    _setTimeNotification(id: 9, time: setting.isha, turnOn: setting.isIsha,now:now);
  }

  void _setTimeNotification({required int id, required TimeOfDay time, required bool turnOn,required now}) {
    if (!turnOn) return;
    NotificationHelper.scheduledDailyNotification(id: id, title: "صحيح الأذكار", body: _body(id:id), selectedTime: _selectedTime(time,now));
  }

  DateTime _selectedTime(TimeOfDay time,DateTime now) {
    return DateTime(now.year, now.month, now.day, time.hour, time.minute);
  }

  String _body({required int id}) {
    if(id == 1)       return "أذكار الإستيقاظ";
    else if( id == 2) return 'أذكار النوم';
    else if( id == 3) return 'أذكار الصباح';
    else if( id == 4) return 'أذكار المساء';
    else if( id == 5) return 'أذكار دبر صلاة الفجر';
    else if( id == 6) return 'أذكار دبر صلاة الظهر';
    else if( id == 7) return 'أذكار دبر صلاة العصر';
    else if( id == 8) return 'أذكار دبر صلاة المغرب';
    else if( id == 9) return 'أذكار دبر صلاة العشاء';
    else return '';
  }
}
