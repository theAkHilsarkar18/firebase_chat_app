import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/standalone.dart';
import 'package:timezone/timezone.dart';

class NotificationHelper {
  NotificationHelper._();

  static NotificationHelper notificationHelper = NotificationHelper._();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static AndroidNotificationChannel channel = const AndroidNotificationChannel(
    "Chat-App",
    "A message from Chat App",
    importance: Importance.high,
    playSound: true,
  );

  // creating notification channel
  Future<void> notificationPlugin() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
    // Android Initialization
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    // iOS Initialization
    DarwinInitializationSettings darwinInitializationSettings =
        const DarwinInitializationSettings();

    // Initializing android and iOS settings
    InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: darwinInitializationSettings,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void showNotification(String title, String body) {
    flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'chat1',
          'Simple Chat Message',
          channelDescription:
              'By enabling this channel you can get simple local notifications',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
    );
  }

  Future<void> showScheduledNotification() async {
    await initializeTimeZone();
    var location = getLocation('Asia/Kolkata');
    var now = TZDateTime.now(location).add(const Duration(seconds: 5));
    await flutterLocalNotificationsPlugin.zonedSchedule(
      1,
      'Scheduled Title',
      'Scheduled Body',
      now,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'chat-schedule1',
          'schedule Simple Chat Message',
          channelDescription: 'channel description',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
