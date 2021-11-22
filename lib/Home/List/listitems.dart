import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_app/Database/Models/todo.dart';
import 'package:todo_app/Database/firebaseutils.dart';
import 'package:todo_app/Home/List/todoitem.dart';
import 'package:todo_app/providers/listprovider.dart';
import 'package:todo_app/providers/appconfigpovider.dart';

class ListItems extends StatefulWidget {
  const ListItems({Key? key}) : super(key: key);

  @override
  State<ListItems> createState() => _ListItemsState();
}

class _ListItemsState extends State<ListItems> {

  int x=1;
  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    AppConfigProvider provider = Provider.of(context);
    ListProvider listProvider = Provider.of(context);
    if(x==1) listProvider.refreshTodos(x++);
    return Column(
      children: [
        TableCalendar(
            firstDay: DateTime.now().subtract(Duration(days: 365)),
            lastDay: DateTime.now().add(Duration(days: 365)),
            focusedDay: focusedDay,
            locale: provider.appLanguage,
            selectedDayPredicate: (day) {
              return isSameDay(listProvider.selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                listProvider.setNewSelectedDay(selectedDay);
                x=1;
                this.focusedDay = focusedDay; // update `_focusedDay` here as well
              });
            },
            headerVisible: false,
            calendarFormat: CalendarFormat.week,
            weekendDays: [],
            daysOfWeekStyle: DaysOfWeekStyle(
              decoration: BoxDecoration(color: Theme.of(context).canvasColor),
              weekdayStyle:
                  TextStyle(color: Theme.of(context).colorScheme.secondary),
            ),
            calendarStyle: CalendarStyle(
              defaultDecoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  shape: BoxShape.rectangle
              ),
              defaultTextStyle:
                  TextStyle(color: Theme.of(context).colorScheme.secondary),
              selectedDecoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                border: Border.all(color: Theme.of(context).primaryColor),
                shape: BoxShape.rectangle
              ),
              todayDecoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                shape: BoxShape.rectangle
              ),
              todayTextStyle:
                  TextStyle(color: Theme.of(context).colorScheme.secondary),
              selectedTextStyle: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold),
            )),
        Expanded(
          child: ListView.builder(
              itemCount: listProvider.items.length,
              itemBuilder: (context, index) {
                return TodoItem(listProvider.items[index]);
              }),
        )
      ],
    );
  }
}


