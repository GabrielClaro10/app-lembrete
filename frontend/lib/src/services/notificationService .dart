/*import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static Future<void> scheduleNotification(
    int id,
    String title,
    String body,
    DateTime scheduledDate,
  ) async {
    await _flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      TZDateTime.from(scheduledDate, local),
      NotificationDetails(
        android: AndroidNotificationDetails(
          'repeat_channel_id',
          'Repeat Notifications',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      androidAllowWhileIdle: true,
      payload: 'Custom_Sound',
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.wallClockTime,
    );
  }

  static Future<void> scheduleDailyNotification(
    int id,
    String title,
    String body,
    DateTime scheduledDate,
  ) async {
    await _flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      TZDateTime.from(scheduledDate, local).add(Duration(days: 1)),
      NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_channel_id',
          'Daily Notifications',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      androidAllowWhileIdle: true,
      payload: 'Custom_Sound',
      matchDateTimeComponents: DateTimeComponents.time,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.wallClockTime,
    );
  }

  static Future<void> showTestNotification() async {
    await _flutterLocalNotificationsPlugin.show(
      0,
      'Teste de Notificação',
      'Isso é um teste!',
      NotificationDetails(
        android: AndroidNotificationDetails(
          'test_channel',
          'Test Channel',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
    );
  }
}
*/
