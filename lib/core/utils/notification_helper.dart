import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class NotificationHelper {
  static final _notification = FlutterLocalNotificationsPlugin();

  static init() {
    _notification.initialize(const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings()));


    tz.initializeTimeZones();
  }

  static scheduledDailyNotification(
      {required int id,required  String title,required  String body,required  DateTime selectedTime}) async {
    // to make notification daily
    if (selectedTime.isBefore(DateTime.now())) {
      selectedTime = selectedTime.add(const Duration(days: 1));
    }

    // push notification
    await _notification.zonedSchedule(
        0,
        title,
        body,
        tz.TZDateTime.from(selectedTime, tz.local),
        _notificationDetails(),
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
}
