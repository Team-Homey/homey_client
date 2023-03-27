import 'package:flutter/material.dart';
import 'package:calendar_builder/calendar_builder.dart';

class TodayShow extends StatefulWidget {
  const TodayShow({Key? key}) : super(key: key);

  @override
  _todayShowState createState() => _todayShowState();
}

class _todayShowState extends State<TodayShow> {
  List<DateTime> eventDate = [DateTime(2022, 1, 3)];
  List<DateTime> highlightDate = [];
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      CbMonthBuilder(
        cbConfig: CbConfig(
          startDate: DateTime(2022),
          endDate: DateTime(2123),
          selectedDate: DateTime.now(),
          selectedYear: DateTime(2023),
          weekStartsFrom: WeekStartsFrom.sunday,
          eventDates: eventDate,
          highlightedDates: highlightDate,
        ),
        monthCustomizer: MonthCustomizer(
            padding: const EdgeInsets.all(20),
            monthHeaderCustomizer: MonthHeaderCustomizer(
              textStyle: const TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            monthButtonCustomizer: MonthButtonCustomizer(
                currentDayColor: Colors.orange,
                borderStrokeWidth: 2,
                textStyleOnDisabled: const TextStyle(color: Colors.red),
                highlightedColor: Colors.amber),
            monthWeekCustomizer: MonthWeekCustomizer(
                textStyle: const TextStyle(color: Colors.amber))),
        yearDropDownCustomizer: YearDropDownCustomizer(
            yearButtonCustomizer: YearButtonCustomizer(
              borderColorOnSelected: Colors.red,
            ),
            yearHeaderCustomizer: YearHeaderCustomizer(
                titleTextStyle: const TextStyle(color: Colors.amber))),
        onYearHeaderExpanded: (isExpanded) {},
        onDateClicked: (onDateClicked) {},
        onYearButtonClicked: (year, isSelected) {},
      ),
      //selet the selected date's feeling
      Positioned(
          bottom: 0,
          right: 0,
          child: Container(
              color: Colors.white,
              height: 110,
              width: MediaQuery.of(context).size.width,
              child: Column(children: [
                const SizedBox(height: 10),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 20),
                  child: const Text('How are you feeling today?',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      )),
                ),
                const SizedBox(height: 10),
                Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: emotions.length,
                        itemBuilder: (context, index) => Container(
                            margin: const EdgeInsets.only(left: 22),
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                FloatingActionButton(
                                    onPressed: () {
                                      setState(() {
                                        highlightDate.add(DateTime.now());
                                      });
                                    },
                                    backgroundColor: Colors.white,
                                    mini: true,
                                    elevation: 0,
                                    child: Text(emotions[index],
                                        style: const TextStyle(
                                          fontSize: 30,
                                        ))),
                                Text(emotionsName[index],
                                    style: const TextStyle(
                                        fontSize: 10, color: Colors.grey))
                              ],
                            )))),
              ]))),
    ]));
  }
}
