import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Database/Models/todo.dart';
import 'package:todo_app/Database/firebaseutils.dart';
import 'package:todo_app/providers/appconfigpovider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/providers/listprovider.dart';

class TodoItem extends StatelessWidget {

  Todo item;

  TodoItem(this.item);

  @override
  Widget build(BuildContext context) {
    AppConfigProvider provider = Provider.of(context);
    ListProvider listProvider = Provider.of(context);
    return Slidable(
      startActionPane: provider.appLanguage == 'en' ? ActionPane(
          extentRatio: 0.2,
          motion: ScrollMotion(),
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  getTodosRefWithConverters().doc(item.id).delete();
                  listProvider.refreshTodos(1);
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15))
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.delete, color: Colors.white,),
                      Text(AppLocalizations.of(context)!.delete, style: TextStyle(
                          color: Colors.white),)
                    ],
                  ),
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
            color: Theme
                .of(context)
                .canvasColor,
            borderRadius: BorderRadius.circular(15)
        ),
        child: Row(
          children: [
            VerticalDivider(color: item.isDone ? Color(0xff61E757) : Theme
                .of(context)
                .primaryColor, thickness: 4,),
            SizedBox(width: 15,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.title, style: TextStyle(color: item.isDone ? Color(0xff61E757) :Theme
                    .of(context)
                    .primaryColor, fontSize: 18, fontWeight: FontWeight.bold),),
                Container(
                    margin: EdgeInsets.only(top: 15),
                    child: Text(
                        item.description, style: TextStyle(color: Theme
                        .of(context)
                        .colorScheme
                        .secondary))
                )
              ],
            ),
            Spacer(),
            item.isDone == false ?
            InkWell(
              onTap: () {
                getTodosRefWithConverters().doc(item.id).update({'isDone': true });
                listProvider.refreshTodos(1);
              },
                child: Image.asset('assets/chech.png')
            ) : Text(AppLocalizations.of(context)!.done, style: TextStyle(color: Color(0xff61E757), fontSize: 22, fontWeight: FontWeight.bold),)
          ],
        ),
      ),
    );
  }
}
