import 'package:flutter/material.dart';
import 'package:share/share.dart';

class ShareDemo extends StatefulWidget {
  const ShareDemo({super.key});

  @override
  State<ShareDemo> createState() => _ShareDemoState();
}

class _ShareDemoState extends State<ShareDemo> {
  void share(BuildContext context) {
    final RenderBox? box = context.findRenderObject() as RenderBox?;
    Share.share(text,
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }

  String text = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Share screen'),
        ),
        body: Container(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: "enter"),
                onChanged: (String txt) {
                  setState(() {
                    text = txt;
                  });
                },
              ),
              const SizedBox(height: 20),
              Builder(builder: (BuildContext context) {
                return ElevatedButton(
                    onPressed: text.isEmpty
                        ? null
                        : () {
                            share(context);
                          },
                    child: const Text('Share'));
              })
            ],
          ),
        ));
  }
}
