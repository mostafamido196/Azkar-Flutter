import 'dart:ffi';

import 'package:equatable/equatable.dart';

import '../../../../core/FontSize.dart';

class Setting extends Equatable {
  FontSize fontSize;
  bool noisy;
  bool vibrate;
  bool transfer;

  Setting(
      {required this.fontSize,
      required this.noisy,
      required this.vibrate,
      required this.transfer});

  @override
  List<Object?> get props => [fontSize, noisy, vibrate, transfer];
}
