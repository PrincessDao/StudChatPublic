import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:stud_chat/settings.dart';

typedef void OnIndexChangedCallback(int index);

class ProfileTab extends StatefulWidget {

  final OnIndexChangedCallback? onIndexChanged;

  ProfileTab({this.onIndexChanged});

  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFF161616),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65.0),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              bottom: 5,
              child: Container(
                height: 40.0,
                width: MediaQuery.of(context).size.width - 25.0,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 0.0),
                    child: GestureDetector(
                      onTap: () {
                        widget.onIndexChanged?.call(0);
                      },
                      child: Image(
                        image: AssetImage('lib/assets/back.png'),
                        fit: BoxFit.contain,
                        width: 31,
                        height: 31,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 3,
              child: Container(
                height: 40.0,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    'Профиль',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF6D55FF),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 5,
              child: Container(
                height: 40.0,
                width: MediaQuery.of(context).size.width - 25.0,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 0.0),
                    child: GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        Navigator.push(
                            context,
                            CupertinoPageRoute(builder: (context) => SettingsPage()));
                      },
                      child: Image(
                        image: AssetImage('lib/assets/settings.png'),
                        fit: BoxFit.contain,
                        width: 25,
                        height: 25,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Stack(
    children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
          Image(
            image: AssetImage('lib/assets/banner.png'),
            fit: BoxFit.contain,
            alignment: Alignment.topCenter,
          ),
        Padding(
          padding: EdgeInsets.only(top: 15.0, left: 200),
          child: ClipOval(
            child: Image(
              height: 100,
              width: 100,
              image: AssetImage('lib/assets/ryzhikov.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
            ]
        ),
      ),
  ]
),
    );
  }
}