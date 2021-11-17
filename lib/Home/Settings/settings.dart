import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Home/Settings/languagebottomsheet.dart';
import 'package:todo_app/Home/Settings/modebottomsheet.dart';
import 'package:todo_app/providers/appconfigpovider.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    AppConfigProvider provider = Provider.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          margin: const EdgeInsets.all(15),
          child: Text(AppLocalizations.of(context)!.language, style: Theme.of(context).textTheme.headline1,)
        ),
        InkWell(
          onTap: () {
            showLanguageBottomSheet();
          },
          child: Container(
            child: Container(
              margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                border: Border.all(color: Theme.of(context).primaryColor)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(provider.appLanguage == 'en' ? 'English' : 'العربية', style: TextStyle(color: Theme.of(context).primaryColor)),
                  Icon(Icons.arrow_downward_outlined, color: Theme.of(context).primaryColor,)
                ],
              ),
            ),
          ),
        ),
        Container(
            margin: const EdgeInsets.all(15),
            child: Text(AppLocalizations.of(context)!.mode, style: Theme.of(context).textTheme.headline1,)
        ),
        InkWell(
          onTap: () {
            showModeBottomSheet();
          },
          child: Container(
            child: Container(
              margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  border: Border.all(color: Theme.of(context).primaryColor)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(provider.mode == ThemeMode.light ? AppLocalizations.of(context)!.light : AppLocalizations.of(context)!.dark, style: TextStyle(color: Theme.of(context).primaryColor)),
                  Icon(Icons.arrow_downward_outlined, color: Theme.of(context).primaryColor,)
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void showLanguageBottomSheet() {
    showModalBottomSheet(context: context, builder: (context){
      return LanguageBottomSheet();
    });
  }

  void showModeBottomSheet() {
    showModalBottomSheet(context: context, builder: (context){
      return ModeBottomSheet();
    });
  }
}
