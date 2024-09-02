import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test1/firebase_options.dart';
import 'package:test1/pages/noification_screen.dart';
import 'package:test1/screens/share_screen.dart';
import 'package:test1/servises/notification_servises.dart';

final navigatorkey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await NotificationServises().initNotiication();
  runApp(MultiProvider(
    providers: [Provider(create: (context) => NotificationServises())],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ShareDemo(),
      navigatorKey: navigatorkey,
      routes: {
        NotificationScreen.route: (context) => const NotificationScreen(),
      },
    );
  }
}
