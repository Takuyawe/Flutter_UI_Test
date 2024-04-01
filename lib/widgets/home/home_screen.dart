import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_ui/main.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});
  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late SharedPreferences prefs;
  double _value = 0.0;
  List checkedChips = [];
  int _currentStep = 0;
  bool isError = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _value = prefs.getDouble("value") ?? 0.0;
    });
  }

  void addToCheckedChips(String chip) {
    setState(() {
      checkedChips.add(chip);
    });
  }

  bool isChecked(String chip) {
    return checkedChips.contains(chip);
  }

  void changeCurrentStep(int step, BuildContext context) {
    if (step < 0) {
      isError = true;
    }
    setState(() {
      if (isError) {
        showErrorDialogIfNeeded(context);
        return;
      }
      _currentStep = step;
    });
  }

  void showErrorDialogIfNeeded(BuildContext context) {
    if (isError) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Error'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context);
                  isError = false;
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeMode currentThemeMode = ref.watch(themeMode);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(
        children: [
          Slider(
              autofocus: true,
              label: 'Slider',
              value: _value,
              onChanged: (value) async {
                setState(() {
                  _value = value;
                });
                prefs.setDouble("value", value);
              }),
          Chip(
              onDeleted: () => addToCheckedChips("Restaurant"),
              backgroundColor:
                  isChecked("Restaurant") ? Colors.purple[800] : Colors.white,
              label: const Text("Restaurant"),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)))),
          SizedBox(
              height: 300,
              child: Stepper(
                  type: StepperType.horizontal,
                  onStepTapped: (value) => changeCurrentStep(value, context),
                  onStepContinue: () =>
                      changeCurrentStep(_currentStep + 1, context),
                  onStepCancel: () =>
                      changeCurrentStep(_currentStep - 1, context),
                  elevation: 50,
                  currentStep: _currentStep,
                  steps: List<Step>.generate(4, (index) {
                    return Step(
                      title: Text('${index + 1}'),
                      content: Text('Step ${index + 1} content'),
                      isActive: index == _currentStep,
                    );
                  }))),
          IconButton(
              onPressed: () => {
                    ref.watch(themeMode.notifier).state =
                        currentThemeMode == ThemeMode.light
                            ? ThemeMode.dark
                            : ThemeMode.light
                  },
              icon: const Icon(Icons.dark_mode),
              iconSize: 36,
              splashRadius: 10,
              splashColor: Colors.red[900],
              color: Colors.purple[600],
              style: ButtonStyle(
                  backgroundColor: currentThemeMode == ThemeMode.dark
                      ? MaterialStateProperty.all(Colors.white)
                      : MaterialStateProperty.all(Colors.black))),
          // DatePickerDialog(
          //   firstDate: DateTime.utc(2010, 1, 1),
          //   lastDate: DateTime.utc(2030, 1, 1),
          //   initialDate: DateTime.now(),
          //   currentDate: DateTime.now(),
          //   initialEntryMode: DatePickerEntryMode.calendar,
          //   initialCalendarMode: DatePickerMode.day,
          //   selectableDayPredicate: (date) {
          //     if (date.weekday == 6 || date.weekday == 7) {
          //       return false;
          //     }
          //     return true;
          //   },
          //   restorationId: 'date_picker_dialog',
          // )
        ],
      ),
    );
  }
}
