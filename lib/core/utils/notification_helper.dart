import 'package:azkar/features/ziker/domain/entities/Setting.dart';
import 'package:azkar/features/ziker/presentation/pages/ZikerScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

import '../../features/ziker/domain/entities/PrayerTime.dart';
import '../../features/ziker/domain/usecases/GetPrayerTimesUsecase.dart';
import '../../features/ziker/domain/usecases/SetNewSettingUsecase.dart';
import '../../features/ziker/presentation/bloc/azkar/setting/SettingBloc.dart';
import '../../features/ziker/presentation/pages/MainScreen.dart';
import '../../injection_container.dart';
import 'FontSize.dart';
import 'location_helper.dart';

class NotificationHelper {
  static late final FlutterLocalNotificationsPlugin _notification;

  // Static getter to access the _notification instance
  static FlutterLocalNotificationsPlugin getNotificationInstance() {
    return _notification;
  }

  static init() {
    _notification = FlutterLocalNotificationsPlugin();
    _notification.initialize(
        const InitializationSettings(
            android: AndroidInitializationSettings('@mipmap/ic_launcher'),
            iOS: DarwinInitializationSettings()),
        onDidReceiveNotificationResponse:
            (NotificationResponse response) async {
      final payload = response.payload;
      if (payload != null) {}
    });
    tz.initializeTimeZones();
  }

  static scheduledDailyNotification(
      {required int id,
      required String title,
      required String body,
      required DateTime selectedTime}) async {
    // push notification
    await _notification.zonedSchedule(
      id, title, body,
      tz.TZDateTime.from(_dailySelectedTime(selectedTime), tz.local),
      _notificationDetails(),
      payload: body,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.wallClockTime,
      matchDateTimeComponents: DateTimeComponents
          .time, // This ensures daily repeat at the specified time
    );
  }

  static Future<void> requestPermissions() async {
    // Request iOS permissions
    final bool? iosGranted = await _notification
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);

    // Check for Android 13+ and request notification permission
    if (await Permission.notification.isDenied) {
      PermissionStatus status = await Permission.notification.request();
      if (status.isGranted) {
        // debugPrint('Notification permission granted');
      } else {
        // debugPrint('Notification permission denied');
      }
    }

    // debugPrint('iOS Permission Granted: $iosGranted');
  }

  static DateTime _dailySelectedTime(DateTime selectedTime) {
    // to make notification daily
    if (selectedTime.isBefore(DateTime.now())) {
      return selectedTime.add(const Duration(days: 1));
    }
    return selectedTime;
  }

  static NotificationDetails _notificationDetails() {
    var androidDetail = const AndroidNotificationDetails(
        'important_notification', 'my_channel',
        importance: Importance.max, priority: Priority.high);
    var iosDetail = const DarwinNotificationDetails();
    return NotificationDetails(android: androidDetail, iOS: iosDetail);
  }

  static void pushNotification(Setting setting) {
    DateTime now = DateTime.now();
    _setTimeNotification(
        id: 1, time: setting.walkUp, turnOn: setting.isWalkUp, now: now);
    _setTimeNotification(
        id: 2, time: setting.sleep, turnOn: setting.isSleep, now: now);
    _setTimeNotification(
        id: 3, time: setting.morning, turnOn: setting.isMorning, now: now);
    _setTimeNotification(
        id: 4, time: setting.evening, turnOn: setting.isEvening, now: now);
    _setTimeNotification(
        id: 5, time: setting.fager, turnOn: setting.isFager, now: now);
    _setTimeNotification(
        id: 6, time: setting.duher, turnOn: setting.isDuher, now: now);
    _setTimeNotification(
        id: 7, time: setting.aser, turnOn: setting.isAser, now: now);
    _setTimeNotification(
        id: 8, time: setting.magrep, turnOn: setting.isMagrep, now: now);
    _setTimeNotification(
        id: 9, time: setting.isha, turnOn: setting.isIsha, now: now);
  }

  static void _setTimeNotification(
      {required int id,
      required TimeOfDay time,
      required bool turnOn,
      required now}) {
    if (turnOn) {
      scheduledDailyNotification(
          id: id,
          title: "صحيح الأذكار",
          body: _body(id: id),
          selectedTime: _selectedTime(time, now));
    } else {
      cancelNotification(id);
    }
  }


  static DateTime _selectedTime(TimeOfDay time, DateTime now) {
    return DateTime(now.year, now.month, now.day, time.hour, time.minute);
  }

  static String _body({required int id}) {
    if (id == 1)
      return "أذكار الإستيقاظ";
    else if (id == 2)
      return 'أذكار النوم';
    else if (id == 3)
      return 'أذكار الصباح';
    else if (id == 4)
      return 'أذكار المساء';
    else if (id == 5)
      return 'أذكار دبر صلاة الفجر';
    else if (id == 6)
      return 'أذكار دبر صلاة الظهر';
    else if (id == 7)
      return 'أذكار دبر صلاة العصر';
    else if (id == 8)
      return 'أذكار دبر صلاة المغرب';
    else if (id == 9)
      return 'أذكار دبر صلاة العشاء';
    else
      return '';
  }

  static Future<void> cancelNotification(int notificationId) async {
    await _notification.cancel(notificationId);
  }

  static void firstTimeOnly(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final bool isFirstRun = prefs.getBool('isFirstRun') ?? true;
    if (isFirstRun) {
      try {
        final locationData = await LocationUtils.getCurrentCityAndCountry();
        final city = locationData['city'] ?? 'Cairo';
        final country = locationData['country'] ?? 'Egypt';

        // 1. Fetch Prayer Times from Usecase
        final prayerTimes =
            await sl<GetPrayerTimesUsecase>().call(city, country);
        if (prayerTimes.isError) return;
        final Setting setting =
            _getSettingWithNewPrayersTime(prayerTimes.data as PrayerTime);
        // 2. Save it to Settings using UpdateSettingUsecase
        await sl<UpdateSettingUsecase>().call(setting);

        // 3. Update SettingBloc
        context.read<SettingBloc>().add(GetOldSettingEvent());

        pushNotification(setting);
        await prefs.setBool('isFirstRun', false);
      } catch (e) {
        print("Error occurred while initializing settings: $e");
        // Handle any errors such as network issues or data parsing problems
      }
    }
  }

  static Setting _getSettingWithNewPrayersTime(PrayerTime prayerTimes) {
    return Setting(
      fontSize: FontSize.Median,
      noisy: true,
      vibrate: true,
      transfer: true,
      walkUp: TimeOfDay(hour: 6, minute: 30),
      isWalkUp: true,
      sleep: TimeOfDay(hour: 22, minute: 0),
      isSleep: true,
      morning: TimeOfDay(hour: 9, minute: 0),
      isMorning: true,
      evening: TimeOfDay(hour: 17, minute: 0),
      isEvening: true,
      fager: prayerTimes.fajr,
      isFager: true,
      duher: prayerTimes.dhuhr,
      isDuher: true,
      aser: prayerTimes.asr,
      isAser: true,
      magrep: prayerTimes.maghrib,
      isMagrep: true,
      isha: prayerTimes.isha,
      isIsha: true,
    );
  }
}
