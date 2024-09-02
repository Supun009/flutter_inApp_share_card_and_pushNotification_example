import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test1/servises/notification_servises.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Home Page",
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Consumer<NotificationServises>(
            builder: (context, notficationServise, child) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      notficationServise.intantNitification(
                          "helloo", "thi is body");
                    },
                    child: const Text('Notification'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
