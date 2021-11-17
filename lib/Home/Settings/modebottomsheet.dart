import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/appconfigpovider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ModeBottomSheet extends StatefulWidget {
  const ModeBottomSheet({Key? key}) : super(key: key);

  @override
  State<ModeBottomSheet> createState() => _ModeBottomSheetState();
}

class _ModeBottomSheetState extends State<ModeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    AppConfigProvider provider = Provider.of(context);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
              onTap: (){
                provider.setNewMode(ThemeMode.light);
              },
              child: getMainView(AppLocalizations.of(context)!.light, provider.mode == ThemeMode.light)
          ),
          InkWell(
              onTap: (){
                provider.setNewMode(ThemeMode.dark);
              },
              child: getMainView(AppLocalizations.of(context)!.dark, provider.mode == ThemeMode.dark)
          )
        ],
      ),
    );
  }

  Widget getMainView(String lang, bool selected) {
    if(selected) {
      return Container(
        margin: EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(lang, style: TextStyle(color: Theme.of(context).primaryColor)),
            Icon(Icons.check, color: Theme.of(context).primaryColor)
          ],
        ),
      );
    } else {
      return Container(
          margin: EdgeInsets.all(15),
          child: Text(lang, style: TextStyle(color: Theme.of(context).colorScheme.secondary),)
      );
    }
  }
}
