import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:study_ui/widgets/calender/calender.dart';

class BottomMenuBar extends StatelessWidget {
  const BottomMenuBar({super.key});
  @override
  Widget build(BuildContext context) {
    return CupertinoTabBar(
      activeColor: Colors.indigo[800],
      items: const [
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.heart),
          label: 'Favorite',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.calendar),
          label: 'Calendar',
        ),
      ],
      onTap: (value) => {
        if (value == 3)
          {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CustomCalendar()),
            )
          }
      },
    );
  }
}
