import 'package:azkar/features/ziker/domain/entities/Setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

import '../../features/ziker/domain/entities/PrayerTime.dart';
import '../../features/ziker/domain/usecases/GetPrayerTimesUsecase.dart';
import '../../features/ziker/domain/usecases/SetNewSettingUsecase.dart';
import '../../injection_container.dart';
import 'FontSize.dart';
import 'location_helper.dart';

class NotificationHelper {
  static final _notification = FlutterLocalNotificationsPlugin();

  static init() {
    _notification.initialize(const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings()));

    tz.initializeTimeZones();
  }

  static scheduledDailyNotification(
      {required int id,
      required String title,
      required String body,
      required DateTime selectedTime}) async {
    // to make notification daily
    if (selectedTime.isBefore(DateTime.now())) {
      selectedTime = selectedTime.add(const Duration(days: 1));
    }

    // push notification
    await _notification.zonedSchedule(0, title, body,
        tz.TZDateTime.from(selectedTime, tz.local), _notificationDetails(),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle);
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
        id: 8, time: setting.magrep, turnOn: setting.isMorning, now: now);
    _setTimeNotification(
        id: 9, time: setting.isha, turnOn: setting.isIsha, now: now);
  }

  static void _setTimeNotification(
      {required int id,
      required TimeOfDay time,
      required bool turnOn,
      required now}) {
    if (!turnOn) return;
    NotificationHelper.scheduledDailyNotification(
        id: id,
        title: "صحيح الأذكار",
        body: _body(id: id),
        selectedTime: _selectedTime(time, now));
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

  static void firstTimeOnly() async {
    print('firstTimeOnly');
    final prefs = await SharedPreferences.getInstance();
    final bool isFirstRun = prefs.getBool('isFirstRun') ?? true;
    if (isFirstRun) {
      print('is first time run');
      try {
        final locationData = await LocationUtils.getCurrentCityAndCountry();
        final city = locationData['city'] ?? 'Cairo';
        final country = locationData['country'] ?? 'Egypt';

        // 1. Fetch Prayer Times from Usecase
        final prayerTimes = await sl<GetPrayerTimesUsecase>().call(city, country);
        if (prayerTimes.isError) return;
        final Setting setting =
        _getSettingWithNewPrayersTime(prayerTimes.data as PrayerTime);
        // 2. Save it to Settings using UpdateSettingUsecase
        await sl<UpdateSettingUsecase>().call(setting);

        pushNotification(setting);
        await prefs.setBool('isFirstRun', false);
        print('every thisg is will');
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
