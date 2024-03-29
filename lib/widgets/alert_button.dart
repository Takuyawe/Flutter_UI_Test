import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:study_ui/widgets/custom_dialog.dart';

Widget alertButton(BuildContext context) {
  return CupertinoButton(
      onPressed: () => {showCustomDialog(context)},
      color: Colors.blue[500],
      minSize: 50,
      child: const Text('Alert'));
}
