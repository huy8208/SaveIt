import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

class Notifications extends ChangeNotifier {
  static final _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static final onNotification = BehaviorSubject<String?>();

  static Future initizlize({bool initSchedule = false}) async {
    AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    IOSInitializationSettings iosInitializationSettings =
        IOSInitializationSettings();

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: androidInitializationSettings,
            iOS: iosInitializationSettings);

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (payload) async {},
    );
  }

  static _notificationDetails() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'id',
      'channel',
      channelDescription: 'Description',
      importance: Importance.max,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    NotificationDetails(iOS: IOSNotificationDetails());
    await _flutterLocalNotificationsPlugin.show(
        0, 'plain title', 'plain body', platformChannelSpecifics,
        payload: 'item x');
  }

  static Future instantNotify({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async =>
      _flutterLocalNotificationsPlugin.show(
        id,
        title,
        body,
        await _notificationDetails(),
        payload: payload,
      );

  static Future cancelNotification() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }
}
