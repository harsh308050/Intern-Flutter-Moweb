import 'dart:convert';

import 'package:UserMe/Screens/Home/homepage.dart';
import 'package:UserMe/Screens/Notification/model/NotificationModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import '../../Utils/SharedPrefHelper.dart';
import '../../Utils/utils.dart';
import '../../main.dart';

String? _initialPayload;
String? get initialPayload => _initialPayload;

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    tz.initializeTimeZones();

    tz.setLocalLocation(tz.getLocation('Asia/Kolkata'));

    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidInit);
    final androidPlugin = _notifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    await androidPlugin?.requestNotificationsPermission();
    await _notifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTap,
      onDidReceiveBackgroundNotificationResponse: _onNotificationTap,
    );
    final details = await _notifications.getNotificationAppLaunchDetails();
    if (details?.didNotificationLaunchApp ?? false) {
      _initialPayload = details!.notificationResponse?.payload;
    }
    await androidPlugin?.requestExactAlarmsPermission();
    await rescheduleAllNotifications();
  }

  Future<void> rescheduleAllNotifications() async {
    final data = sharedPrefGetData(sharedPrefKeys.notifications);
    if (data == null) return;

    AllNotifications all = AllNotifications.fromJson(jsonDecode(data));
    final now = DateTime.now();

    for (var n in all.notifications!) {
      if (n.type == "scheduled" && n.dateTime != null) {
        try {
          final scheduledDateTime = DateTime.parse(n.dateTime!);
          if (scheduledDateTime.isAfter(now)) {
            NotificationService().scheduleNotification(n);
          }
        } catch (e) {
          continue;
        }
      }
    }
  }

  static void _onNotificationTap(NotificationResponse response) {
    _initialPayload = response.payload;
  }

  void handleInitialNavigation() {
    if (_initialPayload == "schedule notification" ||
        _initialPayload == "open-notification-screen") {
      _initialPayload = null;

      navigatorKey.currentState?.push(
        MaterialPageRoute(
          builder: (_) => Homepage(isFromNotificationTap: true),
        ),
      );
    }
  }

  Future<void> showInstantNotification(Notifications model) async {
    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        'direct_channel',
        'Direct Notifications',
        importance: Importance.max,
        priority: Priority.high,
      ),
    );

    await _notifications.show(
      model.id!,
      model.title,
      model.description,
      details,
      payload: "open-notification-screen",
    );
  }

  Future<void> scheduleNotification(Notifications model) async {
    final parsedDateTime = DateTime.parse(model.dateTime!);

    final scheduledTime = tz.TZDateTime(
      tz.local,
      parsedDateTime.year,
      parsedDateTime.month,
      parsedDateTime.day,
      parsedDateTime.hour,
      parsedDateTime.minute,
      parsedDateTime.second,
    );

    final now = tz.TZDateTime.now(tz.local);

    if (scheduledTime.isBefore(now)) {
      return;
    }

    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        'scheduled_channel',
        'Scheduled Notifications',
        channelDescription: 'Channel for scheduled notifications',
        importance: Importance.max,
        priority: Priority.max,
        playSound: true,
        enableVibration: true,
      ),
    );

    await _notifications.zonedSchedule(
      model.id!,
      model.title ?? 'Notification',
      model.description ?? '',
      scheduledTime,
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: "schedule notification",
    );
  }
}
