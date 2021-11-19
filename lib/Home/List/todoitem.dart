import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/appconfigpovider.dart';

class TodoItem extends StatefulWidget {

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  @override
  Widget build(BuildContext context) {
    AppConfigProvider provider = Provider.of(context);
    return Slidable(
      startActionPane: provider.appLanguage == 'en' ? ActionPane(
        extentRatio: 0.2,
        motion: ScrollMotion(),
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(topRight: Radius.circular(15), bottomRight: Radius.circular(15))
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.delete, color: Colors.white,),
                  Text(AppLocalizations.of(context)!.delete, style: TextStyle(color: Colors.white),)
                ],
              ),
            ),
          )
        ]
      ) : null,
      endActionPane: provider.appLanguage == 'ar' ? ActionPane(
          extentRatio: 0.2,
          motion: ScrollMotion(),
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(15), bottomLeft: Radius.circular(15))
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.delete, color: Colors.white,),
                    Text(AppLocalizations.of(context)!.delete, style: TextStyle(color: Colors.white),)
                  ],
                ),
              ),
            )
          ]
      ) : null,
      child: Container(
        margin: const EdgeInsets.all(15),
        padding: EdgeInsets.all(20),
        height: 100,
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: BorderRadius.circular(15)
        ),
        child: Row(
          children: [
            VerticalDivider(color: Theme.of(context).primaryColor, thickness: 4,),
            SizedBox(width: 15,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Play Basketball', style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 18, fontWeight: FontWeight.bold),),
                Container(
                  margin: EdgeInsets.only(top: 15),
                  child: Row(
                    children: [
                      Icon(Icons.access_time, color: Theme.of(context).colorScheme.secondary,),
                      SizedBox(width: 10,),
                      Text('10:30 AM', style: TextStyle(color: Theme.of(context).colorScheme.secondary))
                    ],
                  ),
                )
              ],
            ),
            Spacer(),
            Image.asset('assets/chech.png')
          ],
        ),
      ),
    );
  }
}
