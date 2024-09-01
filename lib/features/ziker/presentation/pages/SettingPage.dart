import 'package:azkar/core/FontSize.dart';
import 'package:azkar/features/ziker/presentation/bloc/azkar/setting/SettingBloc.dart';
import 'package:azkar/features/ziker/presentation/widgets/SettingPageWidget/SettingWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/Utils.dart';
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
    walkUp: TimeOfDay.now(),
    sleep: TimeOfDay.now(),
    fager: TimeOfDay.now(),
    duher: TimeOfDay.now(),
    aser: TimeOfDay.now(),
    magrep: TimeOfDay.now(),
    isha: TimeOfDay.now(),
  );
  int _fontSizeType = 2;
  bool isInitialedSize = true; // to initialize setting first time only

  void _updateSetting(Setting newSetting) {
    print('_updateSetting: ${setting.walkUp.toString()}');
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
        ));
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
            return const Text('الإعدادات');
          } else if (state is LoadingSettingState) {
            return const Text('الإعدادات');
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
        pageFontSize: _fontSizeType
    );
  }

  void _done() async {
    print('done: setting: ${setting}');
    BlocProvider.of<SettingBloc>(context)
        .add(UpdateSettingEvent(setting: setting));

    //when the updateEvent is done will start getSettingEvent
    final settingBloc = context.read<SettingBloc>();
    await for (final state in settingBloc.stream) {
      if (state is MessageUpdateSettingState) {
        settingBloc.add(GetOldSettingEvent());
        break;
      }
    }
    //
    Navigator.pop(context);
  }

  void _initialSetting(Setting setting) {
  print('data come from bloc setting: $setting');
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
}
