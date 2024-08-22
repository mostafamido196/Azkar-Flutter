import 'dart:ffi';

import 'package:equatable/equatable.dart';

import '../../../../core/FontSize.dart';


class Setting extends Equatable {
  final FontSize fontSize;
  final bool noisy;
  final bool vibrate;
  final bool notify;

   Setting({required this.fontSize,required  this.noisy,required  this.vibrate,required  this.notify});

  @override
  List<Object?> get props => [fontSize,noisy,vibrate,notify];
}
