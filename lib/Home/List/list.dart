import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_app/Home/List/todoitem.dart';
import 'package:todo_app/providers/appconfigpovider.dart';

class List extends StatefulWidget {
  const List({Key? key}) : super(key: key);

  @override
  State<List> createState() => _ListState();
}

class _ListState extends State<List> {
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  @override
  Widget build(BuildContext context) {
    AppConfigProvider provider = Provider.of(context);
    return Column(
      children: [
        TableCalendar(
          firstDay: DateTime.now().subtract(Duration(days: 365)),
          lastDay: DateTime.now().add(Duration(days: 365)),
          focusedDay: focusedDay,
          locale: provider.appLanguage,
          selectedDayPredicate: (day) {
            return isSameDay(selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              this.selectedDay = selectedDay;
              this.focusedDay = focusedDay; // update `_focusedDay` here as well
            });
          },
          headerVisible: false,
          calendarFormat: CalendarFormat.week,
          weekendDays: [],
          daysOfWeekStyle: DaysOfWeekStyle(
            decoration: BoxDecoration(color: Theme.of(context).canvasColor),
            weekdayStyle: TextStyle(color: Theme.of(context).colorScheme.secondary),
          ),
          calendarStyle: CalendarStyle(
            defaultDecoration: BoxDecoration(color: Theme.of(context).canvasColor,borderRadius: BorderRadius.circular(5),),
            defaultTextStyle: TextStyle(color: Theme.of(context).colorScheme.secondary),
            selectedDecoration: BoxDecoration(
              color: Theme.of(context).canvasColor, 
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5),
            ),
            todayDecoration: BoxDecoration(color: Theme.of(context).canvasColor,borderRadius: BorderRadius.circular(5),),
            todayTextStyle: TextStyle(color: Theme.of(context).colorScheme.secondary),
            selectedTextStyle: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index){
              return TodoItem();
            }),
        )
      ],
    );
  }
}
