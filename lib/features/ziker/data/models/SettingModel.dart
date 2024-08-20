import 'dart:ffi';

import 'package:azkar/features/ziker/domain/repositories/SettingRepository.dart';

import '../../../../core/FontSize.dart';
import '../../domain/entities/Setting.dart';

class SettingResponse extends Setting {
  SettingResponse(
    FontSize fontSize,
    Bool noisy,
    Bool vibrate,
    Bool notify,
  ) : super(fontSize, noisy, vibrate, notify);
}
