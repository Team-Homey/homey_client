import 'dart:collection';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class TodayShow extends StatefulWidget {
  const TodayShow({Key? key}) : super(key: key);

  @override
  TodayShowState createState() => TodayShowState();
}

class TodayShowState extends State<TodayShow> {
  List<String> emotions = [
    '🥰',
    '😊',
    '🙂',
    '🤔',
    '😕',
    '😭',
    '😠',
  ];
  List<String> emotionsName = [
    'Lovely',
    'Happy',
    'Good',
    "Don't know",
    'So-So',
    'Sad',
    'Angry',
  ];

  final ValueNotifier<List<Event>> _selectedEvents = ValueNotifier([]);

  // Using a `LinkedHashSet` is recommended due to equality comparison override
  final Set<DateTime> _selectedDays = LinkedHashSet<DateTime>(
    equals: isSameDay,
    hashCode: getHashCode,
  );

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }

  List<Event> _getEventsForDays(Set<DateTime> days) {
    // Implementation example
    // Note that days are in selection order (same applies to events)
    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _focusedDay = focusedDay;
      // Update values in a Set
      if (_selectedDays.contains(selectedDay)) {
        _selectedDays.remove(selectedDay);
      } else {
        _selectedDays.add(selectedDay);
      }
    });

    _selectedEvents.value = _getEventsForDays(_selectedDays);
  }

  @override
  Widget build(BuildContext context) {
    String _text = '';
    return Scaffold(
        body: Stack(children: [
      Column(children: [
        SingleChildScrollView(
            child: TableCalendar<Event>(
          rowHeight: 55,
          firstDay: kFirstDay,
          lastDay: kLastDay,
          focusedDay: _focusedDay,
          calendarFormat: _calendarFormat,
          eventLoader: _getEventsForDay,
          startingDayOfWeek: StartingDayOfWeek.sunday,
          calendarBuilders: CalendarBuilders(
            dowBuilder: (context, day) {
              if (day.weekday == DateTime.sunday) {
                final text = DateFormat.E().format(day);
                return Center(
                  child: Text(
                    text,
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              }
              // Use default style for other days
              if (day.weekday == DateTime.saturday) {
                final text = DateFormat.E().format(day);
                return Center(
                  child: Text(
                    text,
                    style: const TextStyle(color: Colors.blue),
                  ),
                );
              }
              final text = DateFormat.E().format(day);
              return Center(
                child: Text(
                  text,
                  style:
                      const TextStyle(color: Color.fromARGB(255, 53, 53, 53)),
                ),
              );
            },
          ),
          selectedDayPredicate: (day) {
            // Use values from Set to mark multiple days as selected
            return _selectedDays.contains(day);
          },
          onDaySelected: _onDaySelected,
          onFormatChanged: (format) {
            if (_calendarFormat != format) {
              setState(() {
                _calendarFormat = format;
              });
            }
          },
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },
        )),
        const SizedBox(height: 8.0),
        Container(
          alignment: Alignment.centerRight,
          width: MediaQuery.of(context).size.width * 0.9,
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                _selectedDays.clear();
                _selectedEvents.value = [];
              });
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 215, 215, 215)),
            child: const Text('Clear selection',
                style: TextStyle(color: Colors.white)),
          ),
        ),
        const SizedBox(height: 8.0),
        Expanded(
          child: ValueListenableBuilder<List<Event>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                // if value.isEmpty show the seven feeling, else shwo the listview
                if (value.isEmpty) {
                  return Container(
                      color: Colors.white,
                      height: 110,
                      width: MediaQuery.of(context).size.width,
                      child: Expanded(
                          child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(children: [
                                const SizedBox(height: 10),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: const EdgeInsets.only(left: 20),
                                  child:
                                      const Text('How are you feeling today?',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 17,
                                          )),
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                    height: 70,
                                    width: MediaQuery.of(context).size.width,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: emotions.length,
                                        itemBuilder: (context, index) =>
                                            Container(
                                                margin: const EdgeInsets.only(
                                                    left: 9),
                                                alignment: Alignment.center,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    FloatingActionButton(
                                                        onPressed: () {},
                                                        backgroundColor:
                                                            Colors.white,
                                                        mini: true,
                                                        elevation: 0,
                                                        child: Text(
                                                            emotions[index],
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 30,
                                                            ))),
                                                    Text(emotionsName[index],
                                                        style: const TextStyle(
                                                            fontSize: 11,
                                                            color: Colors.grey))
                                                  ],
                                                )))),
                                const SizedBox(height: 20),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: const EdgeInsets.only(left: 20),
                                  child: const Text("Question",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 17,
                                      )),
                                ),
                                const SizedBox(height: 15),
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: Container(
                                      margin: EdgeInsets.all(20),
                                      child: const Text(
                                          "Do you know about your family's hobbies?",
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 62, 62, 62),
                                              fontSize: 20,
                                              fontFamily: "Roboto")),
                                    )),
                                const SizedBox(height: 20),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: const EdgeInsets.only(left: 20),
                                  child: const Text("Answer",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 17,
                                      )),
                                ),
                                // save user's input answer texts using Textformfield
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  child: TextField(
                                    decoration: const InputDecoration(
                                      hintText: 'Enter your answer here',
                                    ),
                                    onChanged: (text) {
                                      setState(() {
                                        _text = text;
                                      });
                                    },
                                  ),
                                ),

                                const SizedBox(height: 20),
                                // complete button
                                ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.amber),
                                      minimumSize:
                                          MaterialStateProperty.all<Size>(Size(
                                              MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.9,
                                              40))),
                                  onPressed: () {
                                    // add _test to the eventList
                                  },
                                  child: const Text(
                                    'Save Text',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ]))));
                }
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ListTile(
                        onTap: () => print('${value[index]}'),
                        title: Text('${value[index]}'),
                      ),
                    );
                  },
                );
              }),
        ),
      ])
    ]));
  }
}

class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}

/// Example events.
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

final _kEventSource = Map.fromIterable(List.generate(50, (index) => index),
    key: (item) => DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5),
    value: (item) => List.generate(item % 4 + 1,
        (index) => Event("Taejin's answer : I want' to go a trip!!")))
  ..addAll({
    kToday: [
      const Event(
          "Yuhwan's answer : Yurim loves to play the piano. Isn't that cool?"),
      const Event(
          "Seoyeon's answer : Taejin enjoys playing the basketball. I think he's good at it."),
      const Event("My answer : No... I want to know! "),
    ],
  });

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);
