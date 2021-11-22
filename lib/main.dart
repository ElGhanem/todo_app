import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Edit/editscreen.dart';
import 'package:todo_app/Home/homescreen.dart';
import 'package:todo_app/mythemedata.dart';
import 'package:todo_app/providers/listprovider.dart';
import 'package:todo_app/providers/appconfigpovider.dart';
import 'package:todo_app/userpreferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseFirestore.instance.disableNetwork();
  FirebaseFirestore.instance.settings = const Settings(persistenceEnabled: false);
  FirebaseFirestore.instance.settings = const Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  await UserPreferences.init();
  runApp(
      ChangeNotifierProvider(
        create: (context)=>ListProvider(),
          child: ChangeNotifierProvider(
          create: (context)=>AppConfigProvider(),
          child: MyApp()
      ),
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
        EditScreen.routeName: (context)=> EditScreen(),
      },
      initialRoute: HomeScreen.routeName,
    );
  }
}

