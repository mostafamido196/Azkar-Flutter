import '../features/ziker/domain/entities/Ziker.dart';
import 'FontSize.dart';

class Utils {
  Utils._privateConstructor();
  static final Utils _instance = Utils._privateConstructor();
  factory Utils() {
    return _instance;
  }

  double fontSize(FontSize fontSize) {
    switch (fontSize) {
      case FontSize.Small:
        return 16;
      case FontSize.Large:
        return 20;
    }
    return 18;
  }

}

extension ArabicNumberReplacement on String {
  String replaceArabicNumbers() {
    return replaceAll("1", "١")
        .replaceAll("2", "٢")
        .replaceAll("3", "٣")
        .replaceAll("4", "٤")
        .replaceAll("5", "٥")
        .replaceAll("6", "٦")
        .replaceAll("7", "٧")
        .replaceAll("8", "٨")
        .replaceAll("9", "٩")
        .replaceAll("0", "٠")
        .replaceAll("AM", "صباحاً")
        .replaceAll("PM", "مسائاً");
  }
}
