import 'dart:ffi';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/FontSize.dart';

class Setting extends Equatable {
  FontSize fontSize;
  bool noisy;
  bool vibrate;
  bool transfer;
  TimeOfDay? walkUp;
  TimeOfDay? sleep;
  TimeOfDay? fager;
  TimeOfDay? duher;
  TimeOfDay? aser;
  TimeOfDay? magrep;
  TimeOfDay? isha;

  Setting(
      {required this.fontSize,
      required this.noisy,
      required this.vibrate,
      required this.transfer,
      required this.walkUp,
      required this.sleep,
      required this.fager,
      required this.duher,
      required this.aser,
      required this.magrep,
      required this.isha,

      });

  @override
  List<Object?> get props => [fontSize, noisy, vibrate, transfer,walkUp,sleep,fager,duher,aser,magrep,isha];
}
