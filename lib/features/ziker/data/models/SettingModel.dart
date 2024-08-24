import 'dart:ffi';

import 'package:azkar/features/ziker/domain/repositories/SettingRepository.dart';

import '../../../../core/FontSize.dart';
import '../../domain/entities/Setting.dart';

class SettingResponse extends Setting {
  SettingResponse({
    required FontSize fontSize,
    required bool noisy,
    required bool vibrate,
    required bool notify,
    required bool transfer,
  }) : super(
            fontSize: fontSize, noisy: noisy, vibrate: vibrate, notify: notify,transfer:transfer );

  @override
  factory SettingResponse.fromJson(Map<String, dynamic> json) {
    return SettingResponse(
      fontSize: _retrieveFont(json['fontSize']) , // Convert int to FontSize
      noisy: json['noisy'],
      vibrate: json['vibrate'],
      notify: json['notify'],
      transfer: json['transfer'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'fontSize': _storeFont(fontSize), // Convert FontSize to int
      'noisy': noisy,
      'vibrate': vibrate,
      'notify': notify,
      'transfer': transfer,
    };
  }

  int _storeFont(FontSize fontSize) {
    switch (fontSize) {
      case FontSize.Small:
        return 1;
      case FontSize.Median:
        return 2;
      case FontSize.Large:
        return 3;
    }
  }


  static  FontSize _retrieveFont(int i) {
    switch (i) {
      case 1:
        return FontSize.Small;
      case 2:
        return FontSize.Median;
    }
    return FontSize.Large;
  }
}
