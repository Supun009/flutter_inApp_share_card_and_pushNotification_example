import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:test1/main.dart';
import 'package:test1/pages/noification_screen.dart';

class NotificationServises {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Define notification channel parameters
  final AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'channel_id', // Unique channel ID
    'Channel name',
    description: 'Channel description', // Channel description
    importance: Importance.defaultImportance, // Importance level
  );

  //init notifi
  Future initialize() async {
    // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    //     FlutterLocalNotificationsPlugin();

    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings('@drawable/ic_luncher');

    final InitializationSettings initializationSettings =
        InitializationSettings(android: androidInitializationSettings);

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);

    final platform =
        _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(channel);
  }

  //nistant notification
  Future intantNitification(String title, String body) async {
    var android = const AndroidNotificationDetails('channel_id', 'Channel name',
        channelDescription: 'Channel description',
        priority: Priority.high,
        icon: '@drawable/ic_luncher',
        ticker: 'ticker',
        playSound: true);

    var notificationDetails = NotificationDetails(android: android);

    await _flutterLocalNotificationsPlugin
        .show(0, title, body, notificationDetails, payload: "Hellow to app");
  }

  //nistant notification
  Future schedualNotification() async {
    var interval = RepeatInterval.everyMinute;
    var android = const AndroidNotificationDetails('channel_id', 'Channel name',
        channelDescription: 'Channel description',
        priority: Priority.high,
        icon: '@drawable/ic_luncher',
        ticker: 'ticker');

    var notificationDetails = NotificationDetails(android: android);

    await _flutterLocalNotificationsPlugin.periodicallyShow(0,
        'Notiication demo', 'Notification body', interval, notificationDetails,
        payload: "Hellow to app");
  }

  void handleMessages(RemoteMessage? message) {
    if (message == null) return;

    navigatorkey.currentState?.pushNamed(
      NotificationScreen.route,
      arguments: message,
    );
  }

  Future initPushNotification() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.getInitialMessage().then(handleMessages);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessages);
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;

      intantNitification(notification.title!, notification.body!);
    });
  }

  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotiication() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    debugPrint('token is : $fCMToken');

    await initialize();
    await initPushNotification();
  }
}
