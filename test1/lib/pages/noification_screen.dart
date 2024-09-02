import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  static const route = '/notification';

  @override
  Widget build(BuildContext context) {
    final RemoteMessage message =
        ModalRoute.of(context)!.settings.arguments as RemoteMessage;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificatios'),
      ),
      body: Column(
        children: [Text(message.notification?.title ?? 'No message')],
      ),
    );
  }
}
