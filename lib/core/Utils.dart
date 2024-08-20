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
