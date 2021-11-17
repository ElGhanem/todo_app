import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/appconfigpovider.dart';

class LanguageBottomSheet extends StatefulWidget {
  const LanguageBottomSheet({Key? key}) : super(key: key);

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    AppConfigProvider provider = Provider.of(context);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: (){
              provider.setNewLang('en');
            },
            child: getMainView('English', provider.appLanguage == 'en')
          ),
          InkWell(
            onTap: (){
              provider.setNewLang('ar');
            },
            child: getMainView('العربية', provider.appLanguage == 'ar')
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
