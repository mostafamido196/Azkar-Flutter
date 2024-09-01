import 'dart:ffi';

import 'package:azkar/features/ziker/domain/repositories/SettingRepository.dart';
import 'package:flutter/material.dart';

import '../../../../core/FontSize.dart';
import '../../domain/entities/Setting.dart';

class SettingResponse extends Setting {
  SettingResponse(
      {required FontSize fontSize,
      required bool noisy,
      required bool vibrate,
      required bool transfer,
      required TimeOfDay? walkUp,
      required TimeOfDay? sleep,
      required TimeOfDay? fager,
      required TimeOfDay? duher,
      required TimeOfDay? aser,
      required TimeOfDay? magrep,
      required TimeOfDay? isha})
      : super(
            fontSize: fontSize,
            noisy: noisy,
            vibrate: vibrate,
            transfer: transfer,
            walkUp: walkUp,
            sleep: sleep,
            fager: fager,
            duher: duher,
            aser: aser,
            magrep: magrep,
            isha: isha);

  @override
  factory SettingResponse.fromJson(Map<String, dynamic> json) {
    print('retrive: json: $json');
    return SettingResponse(
      fontSize: _retrieveFont(json['fontSize']),
      // Convert int to FontSize
      noisy: json['noisy'],
      vibrate: json['vibrate'],
      transfer: json['transfer'],
      walkUp: json['walkUp'],
      sleep: json['sleep'],
      fager: json['fager'],
      duher: json['duher'],
      aser: json['aser'],
      magrep: json['magrep'],
      isha: json['isha'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    print('store: json: walkUp: hour${walkUp?.hour}, min${walkUp?.minute}');
    return {
      'fontSize': _storeFont(fontSize), // Convert FontSize to int
      'noisy': noisy,
      'vibrate': vibrate,
      'transfer': transfer,
      'walkUp': walkUp,
      'sleep': sleep,
      'fager': fager,
      'duher': duher,
      'aser': aser,
      'magrep': magrep,
      'isha': isha,
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

  static FontSize _retrieveFont(int i) {
    switch (i) {
      case 1:
        return FontSize.Small;
      case 2:
        return FontSize.Median;
    }
    return FontSize.Large;
  }
}
