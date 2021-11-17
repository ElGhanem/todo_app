import 'package:flutter/material.dart';
import 'package:todo_app/Home/List/list.dart';
import 'package:todo_app/Home/Settings/settings.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        elevation: 15,
        shape: StadiumBorder(
          side: BorderSide(
            color: Theme.of(context).canvasColor,
            width: 4,
          )
        ),
        child: const Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height*0.2,
        title: Text(selectedIndex == 0 ? AppLocalizations.of(context)!.app_bar_title1 : AppLocalizations.of(context)!.app_bar_title2, style: Theme.of(context).textTheme.headline2,),
      ),
      body: getMainView(),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        elevation: 15,
        notchMargin: 10,
        clipBehavior: Clip.antiAlias,
        child: BottomNavigationBar(
          elevation: 15,
          currentIndex: selectedIndex,
          onTap: (index) {
            selectedIndex = index;
            setState(() {});
          },
          showSelectedLabels: false,
          showUnselectedLabels: false,
          unselectedItemColor: Theme.of(context).colorScheme.secondary,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.list_outlined, size: 30,), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.settings_outlined, size: 30), label: ''),
          ],
        ),
      ),
    );
  }

  Widget getMainView() {
    if(selectedIndex == 0) {
      return List();
    } else if(selectedIndex == 1) {
      return Settings();
    } else {
      return Container();
    }
  }
}
