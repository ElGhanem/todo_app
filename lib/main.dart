import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Home/homescreen.dart';
import 'package:todo_app/mythemedata.dart';
import 'package:todo_app/providers/appconfigpovider.dart';

void main() {
  runApp(
      ChangeNotifierProvider(
        create: (context)=>AppConfigProvider(),
        child: MyApp()
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppConfigProvider provider = Provider.of(context);
    return MaterialApp(
      title: 'Todo App',
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'),
        Locale('ar'),
      ],
      locale: Locale(provider.appLanguage),
      theme: MyThemeData.lightTheme,
      darkTheme: MyThemeData.darkTheme,
      themeMode: provider.mode,
      routes: {
        HomeScreen.routeName: (context)=> HomeScreen(),
      },
      initialRoute: HomeScreen.routeName,
    );
  }
}

