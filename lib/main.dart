import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stud_chat/settings.dart';
import 'home.dart';
import 'people.dart';
import 'public.dart';
import 'chats.dart';
import 'entry.dart';
import 'acquaint.dart';
import 'profile.dart';
import 'dart:io';
import 'package:video_player/video_player.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: EntryPage(),
      theme: ThemeData.light().copyWith(
          splashFactory: NoSplash.splashFactory,
          navigationBarTheme: NavigationBarThemeData(
            indicatorShape: null,
            backgroundColor: Color(0xFF292929),
            surfaceTintColor: Color(0xFF292929),
            indicatorColor: Color(0xFF292929),
            labelTextStyle: MaterialStateProperty.resolveWith<TextStyle?>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.selected)) {
                  return TextStyle(
                    fontStyle: FontStyle.normal,
                    color: Color(0xFFFFFFFF),
                    fontSize: 9.0,
                  );
                }
                return TextStyle(
                  fontStyle: FontStyle.normal,
                  color: Color(0xFF676767),
                  fontSize: 9.0,
                );
              },
            ),
          )
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  bool backButtonPressed = false;

  @override
  void initState() {
    super.initState();
  }

  void _handleIndexChanged(int index) {
    setState(() {
      _currentIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: Container(
        color: Color(0xFF161616),
        child: IndexedStack(
          index: _currentIndex,
          children: [
            Navigator(
              onGenerateRoute: (settings) {
                return MaterialPageRoute(
                  builder: (context) => HomeTab(),
                );
              },
            ),
            Navigator(
              onGenerateRoute: (settings) {
                return MaterialPageRoute(
                  builder: (context) => ChatsTab(onIndexChanged: _handleIndexChanged),
                );
              },
            ),
            Navigator(
              onGenerateRoute: (settings) {
                return MaterialPageRoute(
                  builder: (context) => PeopleTab(onIndexChanged: _handleIndexChanged),
                );
              },
            ),
            Navigator(
              onGenerateRoute: (settings) {
                return MaterialPageRoute(
                  builder: (context) => AcquaintTab(onIndexChanged: _handleIndexChanged),
                );
              },
            ),
            Navigator(
              onGenerateRoute: (settings) {
                return MaterialPageRoute(
                  builder: (context) => ProfileTab(onIndexChanged: _handleIndexChanged),
                );
              },
            ),
            Navigator(
              onGenerateRoute: (settings) {
                return MaterialPageRoute(
                  builder: (context) => SettingsPage(onIndexChanged: _handleIndexChanged),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(right: 10.0, left: 10.0, bottom: 5.0),
        color: Colors.transparent,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(45.0),
    child: Container(
    padding: EdgeInsets.only(right: 10.0, left: 10.0),
      color: Color(0xFF292929),
          child: NavigationBar(
            height: 70.0,
            selectedIndex: _currentIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _currentIndex = index;
                backButtonPressed = false;
              });
            },
            destinations: const <Widget>[
              NavigationDestination(
                tooltip: '',
                icon: Image(
                  image: AssetImage('lib/assets/navigationBar/mainIconGray.png'),
                  fit: BoxFit.contain,
                  width: 21,
                  height: 21,
                ),
                selectedIcon: Image(
                  image: AssetImage('lib/assets/navigationBar/mainIconWhite.png'),
                  fit: BoxFit.contain,
                  width: 21,
                  height: 21,
                ),
                label: 'Главная',
              ),
              NavigationDestination(
                tooltip: '',
                icon: Image(
                  image: AssetImage('lib/assets/navigationBar/chatsIconGray.png'),
                  fit: BoxFit.contain,
                  width: 21,
                  height: 21,
                ),
                selectedIcon: Image(
                  image: AssetImage('lib/assets/navigationBar/chatsIconWhite.png'),
                  fit: BoxFit.contain,
                  width: 21,
                  height: 21,
                ),
                label: 'Сообщения',
              ),
              NavigationDestination(
                tooltip: '',
                icon: Image(
                  image: AssetImage('lib/assets/navigationBar/peopleIconGray.png'),
                  fit: BoxFit.contain,
                  width: 21,
                  height: 21,
                ),
                selectedIcon: Image(
                  image: AssetImage('lib/assets/navigationBar/peopleIconWhite.png'),
                  fit: BoxFit.contain,
                  width: 21,
                  height: 21,
                ),
                label: 'Друзья',
              ),
              NavigationDestination(
                tooltip: '',
                icon: Image(
                  image: AssetImage('lib/assets/navigationBar/acquaintIconGray.png'),
                  fit: BoxFit.contain,
                  width: 21,
                  height: 21,
                ),
                selectedIcon: Image(
                  image: AssetImage('lib/assets/navigationBar/acquaintIconWhite.png'),
                  fit: BoxFit.contain,
                  width: 21,
                  height: 21,
                ),
                label: 'Знакомства',
              ),
              NavigationDestination(
                tooltip: '',
                icon: Image(
                  image: AssetImage('lib/assets/navigationBar/profileIconGray.png'),
                  fit: BoxFit.contain,
                  width: 21,
                  height: 21,
                ),
                selectedIcon: Image(
                  image: AssetImage('lib/assets/navigationBar/profileIconWhite.png'),
                  fit: BoxFit.contain,
                  width: 21,
                  height: 21,
                ),
                label: 'Профиль',
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }
}