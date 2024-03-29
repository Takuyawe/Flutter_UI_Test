import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomCalendar extends StatefulWidget {
  const CustomCalendar({super.key});
  @override
  _CustomCalendarState createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();
  Map<DateTime, List> _eventList = {};

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _eventList = {
      DateTime.now().subtract(Duration(days: 2)): ['Event A6', 'Event B6'],
      DateTime.now(): ['Event A7', 'Event B7', 'Event C7', 'Event D7'],
      DateTime.now().add(Duration(days: 1)): [
        'Event A8',
        'Event B8',
        'Event C8',
        'Event D8',
        'Event D8'
      ],
      DateTime.now().add(Duration(days: 3)):
          Set.from(['Event A9', 'Event A9', 'Event B9']).toList(),
      DateTime.now().add(Duration(days: 7)): [
        'Event A10',
        'Event B10',
        'Event C10'
      ],
      DateTime.now().add(Duration(days: 11)): ['Event A11', 'Event B11'],
      DateTime.now().add(Duration(days: 17)): [
        'Event A12',
        'Event B12',
        'Event C12',
        'Event D12'
      ],
      DateTime.now().add(Duration(days: 22)): ['Event A13', 'Event B13'],
      DateTime.now().add(Duration(days: 26)): [
        'Event A14',
        'Event B14',
        'Event C14'
      ],
    };
  }

  @override
  Widget build(BuildContext context) {
    final _events =
        LinkedHashMap<DateTime, List>(equals: isSameDay, hashCode: getHashCode)
          ..addAll(_eventList);

    List _getEventForDay(DateTime day) {
      return _events[day] ?? [];
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('カレンダー'),
        ),
        body: Column(children: [
          TableCalendar(
            calendarBuilders:
                CalendarBuilders(markerBuilder: (context, date, events) {
              if (events.isNotEmpty) {
                return _buildEventsMarker(date, events);
              }
            }),
            calendarStyle: CalendarStyle(
                markersMaxCount: 10,
                selectedDecoration: BoxDecoration(
                    color: Colors.amber[500], shape: BoxShape.circle)),
            firstDay: DateTime.utc(2010, 1, 1),
            lastDay: DateTime.utc(2030, 1, 1),
            focusedDay: _focusedDay,
            locale: "ja_JP",
            eventLoader: _getEventForDay,
            headerStyle: const HeaderStyle(formatButtonVisible: false),
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: ((selectedDay, focusedDay) => {
                  if (!isSameDay(_selectedDay, selectedDay))
                    {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      })
                    }
                }),
          ),
          Flexible(
              child: Scrollbar(
                  thumbVisibility: true,
                  thickness: 5,
                  child: ListView(
                    shrinkWrap: true,
                    children: _getEventForDay(_selectedDay!)
                        .map((event) => ListTile(
                              leading: Checkbox(
                                  value: false,
                                  onChanged: (value) {
                                    setState(() {
                                      _getEventForDay(_selectedDay!)
                                          .remove(event);
                                    });
                                  }),
                              title: Text(event.toString()),
                            ))
                        .toList(),
                  )))
        ]));
  }
}

Widget _buildEventsMarker(DateTime date, List events) {
  return Positioned(
      right: 5,
      bottom: 5,
      child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: Colors.red[300]),
          width: 16,
          height: 16,
          child: Center(
            child: Text(
              '${events.length}',
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          )));
}
