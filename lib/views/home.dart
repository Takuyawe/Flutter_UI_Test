import 'package:flutter/material.dart';
import 'package:study_ui/widgets/alert_button.dart';
import 'package:study_ui/widgets/menu_bar.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context) {
    return const BottomMenuBar();
    // return Scaffold(
    //     appBar: AppBar(
    //       title: const Text('Home'),
    //     ),
    //     body: Center(
    //         child: Column(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             verticalDirection: VerticalDirection.down,
    //             children: [
    //           const Spacer(),
    //           alertButton(context),
    //           const Spacer(),
    //           const BottomMenuBar()
    //         ])));
  }
}
