import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class AddTodoBottomSheet extends StatefulWidget {
  const AddTodoBottomSheet({Key? key}) : super(key: key);

  @override
  State<AddTodoBottomSheet> createState() => _AddTodoBottomSheetState();
}

class _AddTodoBottomSheetState extends State<AddTodoBottomSheet> {
  DateTime day = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        color: Theme.of(context).canvasColor
      ),
      padding: EdgeInsets.all(30),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(15,0,15,15),
            child: Text(AppLocalizations.of(context)!.newTask, style: Theme.of(context).textTheme.headline1,)
          ),
          TextField(
            decoration: InputDecoration(
              labelText: 'Enter Todo Title',
            ),
          ),
          TextField(
            maxLines: 4,
            minLines: 4,
            decoration: InputDecoration(
              labelText: 'Enter Todo Description',
            ),
          ),
          InkWell(
            onTap: () {
              showMyDatePicker();
            },
            child: Container(
              margin: EdgeInsets.only(top: 20),
              width: double.infinity,
              child: Text('Select Time', style: Theme.of(context).textTheme.headline1, textAlign: TextAlign.start,)
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 20, bottom: 20),
              child: Text(DateFormat('yyyy/MM/dd').format(day), style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.secondary))
          ),
          FloatingActionButton(
            onPressed: (){
              Navigator.pop(context);
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
    );
  }

  void showMyDatePicker() async {
    day = (await showDatePicker(context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365))
    ))!;
    setState(() {});
  }
}
