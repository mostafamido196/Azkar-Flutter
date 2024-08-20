import 'dart:ffi';

import 'package:equatable/equatable.dart';

import '../../../../core/FontSize.dart';


class Setting extends Equatable {
  final FontSize fontSize;
  final Bool noisy;
  final Bool vibrate;
  final Bool notify;

   Setting(this.fontSize,this.noisy,this.vibrate,this.notify);

  @override
  List<Object?> get props => [fontSize,noisy,vibrate,notify];
}
