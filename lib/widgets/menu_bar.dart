import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:study_ui/widgets/calender/calender.dart';

class BottomMenuBar extends StatelessWidget {
  const BottomMenuBar({super.key});
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
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
        ),
        tabBuilder: (context, index) {
          switch (index) {
            case 3:
              return CupertinoTabView(builder: (context) {
                return const CupertinoPageScaffold(
                    navigationBar:
                        CupertinoNavigationBar(leading: Text('Home')),
                    child: CustomCalendar());
              });
            default:
              return CupertinoTabView(builder: (context) {
                return const CupertinoPageScaffold(
                    navigationBar:
                        CupertinoNavigationBar(leading: Text('Home')),
                    child: Text("Default"));
              });
          }
        });
  }
}
