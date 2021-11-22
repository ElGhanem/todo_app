import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Database/Models/todo.dart';
import 'package:todo_app/Database/firebaseutils.dart';
import 'package:todo_app/providers/listprovider.dart';

class AddTodoBottomSheet extends StatefulWidget {
  const AddTodoBottomSheet({Key? key}) : super(key: key);

  @override
  State<AddTodoBottomSheet> createState() => _AddTodoBottomSheetState();
}

class _AddTodoBottomSheetState extends State<AddTodoBottomSheet> {

  DateTime day = DateTime.now().toUtc();
  String title = '';
  String description = '';
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(day);
    day = day.subtract(Duration(hours: day.hour));
    day = day.subtract(Duration(minutes: day.minute));
    day = day.subtract(Duration(seconds: day.second));
    day = day.subtract(Duration(milliseconds: day.millisecond));
    day = day.subtract(Duration(microseconds: day.microsecond));
    print(day);
  }
  @override
  Widget build(BuildContext context) {
    ListProvider listProvider = Provider.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        color: Theme.of(context).canvasColor
      ),
      padding: const EdgeInsets.all(30),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.fromLTRB(15,0,15,15),
                child: Text(AppLocalizations.of(context)!.newTask, style: Theme.of(context).textTheme.headline1,)
              ),
            ),
            Expanded(
              child: TextFormField(
                style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                onChanged: (text) {
                  title = text;
                },
                validator: (text){
                  if(text == null || text.isEmpty) {
                    return  AppLocalizations.of(context)!.titleErr;
                  }
                },
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.title,
                  labelStyle: TextStyle(color: Theme.of(context).colorScheme.secondary),
                  floatingLabelStyle: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
            ),
            Expanded(
              child: TextFormField(
                style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                onChanged: (text) {
                  description = text;
                },
                maxLines: 4,
                minLines: 4,
                validator: (text){
                  if(text == null || text.isEmpty) {
                    return  AppLocalizations.of(context)!.descriptionErr;
                  }
                },
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.description,
                  labelStyle: TextStyle(color: Theme.of(context).colorScheme.secondary),
                  floatingLabelStyle: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                showMyDatePicker();
              },
              child: Container(
                margin: EdgeInsets.only(top: 20),
                width: double.infinity,
                child: Text(AppLocalizations.of(context)!.selectTime, style: Theme.of(context).textTheme.headline1, textAlign: TextAlign.start,)
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  showMyDatePicker();
                },
                child: Container(
                    margin: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Text(DateFormat('yyyy/MM/dd').format(day), style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.secondary))
                ),
              ),
            ),
            FloatingActionButton(
              onPressed: (){
                addTodo();
                listProvider.refreshTodos(1);
              },
              elevation: 15,
              shape: StadiumBorder(
                  side: BorderSide(
                    color: Theme.of(context).canvasColor,
                    width: 4,
                  )
              ),
              child: const Icon(Icons.check),
              backgroundColor: Theme.of(context).primaryColor,
            )
          ],
        ),
      ),
    );
  }

  void showMyDatePicker() {
    showDatePicker(context: context,
        initialDate: DateTime.now().toUtc(),
        firstDate: DateTime.now().toUtc(),
        lastDate: DateTime.now().toUtc().add(Duration(days: 365))).then((date) {
          if(date != null) {
            date = date.add(Duration(hours: 2)).toUtc();
            print(date);
            day = date;
            setState(() {});
          }
    });
  }

  void addTodo() {
    if(!formKey.currentState!.validate()) return;
    Todo todo = Todo(title: title, description: description, dateTime: day);
    addTodoToFireStore(todo).then((value) {}).catchError((onError) {
      print(onError.toString());
    }).timeout(const Duration(microseconds: 500), onTimeout: () {
      print('in Time out');
      Navigator.pop(context);
    });
  }
}
