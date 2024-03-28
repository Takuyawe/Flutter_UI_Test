import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () => {
                  showDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                            title: const Text("タイトル"),
                            content: const Text("メッセージ内容"),
                            actions: [
                              CupertinoDialogAction(
                                isDestructiveAction: true,
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Cancel'),
                              ),
                              CupertinoDialogAction(
                                  child: const Text('OK'),
                                  onPressed: () => print("Pressed")),
                            ],
                          ))
                },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, minimumSize: const Size(50, 30)),
            child: const Text('Alert')),
      ),
    );
  }
}
