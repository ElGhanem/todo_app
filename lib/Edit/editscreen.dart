import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Database/Models/todo.dart';
import 'package:todo_app/Database/firebaseutils.dart';
import 'package:todo_app/providers/listprovider.dart';

class EditScreen extends StatefulWidget {
  static String routeName = 'edit';

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  DateTime day = DateTime.now().toUtc();
  String title = '';
  String description = '';
  late Todo args;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ListProvider listProvider = Provider.of(context);
    args = ModalRoute.of(context)!.settings.arguments as Todo;
    title = args.title;
    description = args.description;
    day = args.dateTime;
    return Scaffold(
      body: Stack(
        children: [
          Scaffold(
          appBar: AppBar(
            toolbarHeight: MediaQuery.of(context).size.height*0.2,
            title: Text(AppLocalizations.of(context)!.app_bar_title1, style: Theme.of(context).textTheme.headline2,),
          ),
        ),
          Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.65,
              width: MediaQuery.of(context).size.width * 0.85,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).canvasColor
              ),
              padding: const EdgeInsets.all(30),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                          margin: const EdgeInsets.fromLTRB(15,0,15,15),
                          child: Text(AppLocalizations.of(context)!.editTask, style: Theme.of(context).textTheme.headline1,)
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        initialValue: title,
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
                      flex: 2,
                      child: TextFormField(
                        initialValue: description,
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
                    Container(
                        margin: EdgeInsets.only(top: 20),
                        width: double.infinity,
                        child: Text(AppLocalizations.of(context)!.selectTime, style: Theme.of(context).textTheme.headline1, textAlign: TextAlign.start,)
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                          margin: const EdgeInsets.only(top: 20, bottom: 20),
                          child: Text(DateFormat('yyyy/MM/dd').format(day), style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.secondary))
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Center(
                        child: ElevatedButton(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(EdgeInsets.all(15)),
                            fixedSize: MaterialStateProperty.all(Size.fromWidth(MediaQuery.of(context).size.width * 0.6)),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                  )
                              )
                          ),
                          onPressed: () {
                            updateTask();
                            listProvider.refreshTodos(1);
                            Navigator.pop(context);
                          },
                          child: Text(AppLocalizations.of(context)!.save, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ]
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
        setState(() {
          day = date!;
          print(day);
        });
      }
    });
  }

  void updateTask() {
    if(title == args.title && description == args.description && day == args.dateTime) return;
    getTodosRefWithConverters().doc(args.id).update({'title': title, 'description': description, 'dateTime': day })
    .then((value) {
      print('done');
    })
    .catchError((onError) {
      print('err ${onError.toString()}');
    });
  }
}
