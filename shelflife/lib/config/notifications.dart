import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shelflife/classes/models/expiration.dart';
import 'package:shelflife/main.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService instance = NotificationService._internal();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationService._internal();

  Future<void> init() async {
    tzdata.initializeTimeZones();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(
      settings: initializationSettings,
    );

    final androidPlugin = flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    await androidPlugin?.requestNotificationsPermission();
    await androidPlugin?.requestExactAlarmsPermission();

    final bool? granted = await androidPlugin?.canScheduleExactNotifications();

    if (granted == false) {
      await androidPlugin?.requestExactAlarmsPermission();
    }
  }

  Future<void> scheduleDailyMorningNotification({
    required String title,
    required String body,
  }) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
          'shelflife_daily_channel',
          'Daily Expirations',
          channelDescription: 'Daily reminders of expiring products!',
          importance: Importance.max,
          priority: Priority.high,
        );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    tz.setLocalLocation(tz.getLocation('Europe/Belgrade'));

    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      15,
      10,
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id: 99,
      title: title,
      body: body,
      scheduledDate: scheduledDate,
      notificationDetails: platformChannelSpecifics,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> showNotification({
    required String title,
    required String body,
  }) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
          'shelflife_expiration_channel',
          "Expirations",
          channelDescription: "Notifications for expiring products!",
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker',
        );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      id: 1,
      title: title,
      body: body,
      notificationDetails: platformChannelSpecifics,
    );
  }

  Future<void> scheduleExpirationAlarm(Expiration e) async {
    final plugin = flutterLocalNotificationsPlugin;
    tz.setLocalLocation(tz.getLocation('Europe/Belgrade'));

    final remindDay = e.expirationDate.subtract(const Duration(days: 15));
    final when = tz.TZDateTime(
      tz.local,
      remindDay.year,
      remindDay.month,
      remindDay.day,
      10, // 10 in the morning
      00,
    );

    if (when.isBefore(tz.TZDateTime.now(tz.local))) return;

    await plugin.zonedSchedule(
      id: e.id,
      title: 'Expires in 15 days'.tr,
      body:
          '${e.productBrand} ${e.productName} ${"expires on".tr} ${e.expirationDate.day}.${e.expirationDate.month}.',
      scheduledDate: when,
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          'shelflife_alarm_channel',
          'Expiration alarms',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  void cancelAlarm(int id) {
    final plugin = flutterLocalNotificationsPlugin;
    try {
      plugin.cancel(id: id);
    } finally {}
  }
}
