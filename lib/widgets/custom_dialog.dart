import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showCustomDialog(BuildContext context) {
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
                  child: const Text('OK'), onPressed: () => print("Pressed")),
            ],
          ));
}
