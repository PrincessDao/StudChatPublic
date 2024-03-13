import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stud_chat/entry.dart';

typedef void OnIndexChangedCallback(int index);

class SettingsPage extends StatefulWidget {

  final OnIndexChangedCallback? onIndexChanged;

  SettingsPage({this.onIndexChanged});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  bool isConfirmationVisible = false;

  OverlayEntry? overlayEntry;
  OverlayEntry? confirmationOverlay;

  void _showOverlay() {
    overlayEntry = OverlayEntry(
      builder: (context) => Positioned.fill(
        child: Container(
          color: Color.fromRGBO(0, 0, 0, 0.5),
        ),
      ),
    );

    confirmationOverlay = OverlayEntry(
        builder: (context) => Positioned(
          top: 340,
          left: (MediaQuery.of(context).size.width - MediaQuery.of(context).size.width * 0.90) / 2,
          child: Container(
              width: MediaQuery.of(context).size.width * 0.90,
              height: 235,
              decoration: BoxDecoration(
                color: Color(0xFF2D2D2D),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 10,
                    left: (MediaQuery.of(context).size.width -
                        MediaQuery.of(context).size.width * 0.9) /
                        2,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: 50,
                      child: Padding(
                        padding: EdgeInsets.only(top: 10.0, left: 10.0),
                        child: Text(
                          'Удаление аккаунта',
                          style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 40,
                    left: (MediaQuery.of(context).size.width -
                        MediaQuery.of(context).size.width * 0.9) /
                        2,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: 80,
                      child: Padding(
                        padding: EdgeInsets.only(top: 10.0, left: 10.0),
                        child: Text(
                          'Ваш аккаунт будет удалён. Вы сможете восстановить аккаунт в течение\n1 месяца.',
                          style: TextStyle(
                            fontSize: 13.0,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF787878),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 125,
                    left: (MediaQuery.of(context).size.width -
                        MediaQuery.of(context).size.width * 0.85) /
                        2,
                    child: GestureDetector(
                      onTap: () {
                        _hideOverlay();
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.75,
                        height: 45,
                        decoration: BoxDecoration(
                          color: Color(0xFF454545),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Подтвердить',
                            style: TextStyle(
                              fontSize: 13.0,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 180,
                    left: (MediaQuery.of(context).size.width -
                        MediaQuery.of(context).size.width * 0.85) /
                        2,
                    child: GestureDetector(
                      onTap: () {
                        _hideOverlay();
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.75,
                        height: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Отмена',
                            style: TextStyle(
                              fontSize: 13.0,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
          ),
        ),
    );

    Overlay.of(context)?.insert(overlayEntry!);
    Overlay.of(context)?.insert(confirmationOverlay!);
  }

  void _hideOverlay() {
    overlayEntry?.remove();
    confirmationOverlay?.remove();
    overlayEntry = null;
    confirmationOverlay = null;
  }

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
                        Navigator.pop(context);
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
                    'Настройки',
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
          ],
        ),
      ),
      body: Stack(
          children: [
            Positioned(
              top: 20,
              child: Container(
                height: 40.0,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: GestureDetector(
                      onTap: () {
                      },
                      child: Row(
                        children: [
                          Image(
                            image: AssetImage('lib/assets/appearance.png'),
                            fit: BoxFit.contain,
                            width: 24,
                            height: 24,
                          ),
                          SizedBox(width: 15.0),
                          Text(
                            'Внешний вид',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                        ],
                      )
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 65,
              child: Container(
                height: 40.0,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: GestureDetector(
                        onTap: () {
                        },
                        child: Row(
                          children: [
                            Image(
                              image: AssetImage('lib/assets/aboutApp.png'),
                              fit: BoxFit.contain,
                              width: 24,
                              height: 24,
                            ),
                            SizedBox(width: 15.0),
                            Text(
                              'О приложении',
                              style: TextStyle(
                                fontSize: 14.0,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                color: Color(0xFFFFFFFF),
                              ),
                            ),
                          ],
                        )
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 110,
              child: Container(
                height: 40.0,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: GestureDetector(
                        onTap: () {
                        },
                        child: Row(
                          children: [
                            Image(
                              image: AssetImage('lib/assets/assistance.png'),
                              fit: BoxFit.contain,
                              width: 24,
                              height: 24,
                            ),
                            SizedBox(width: 15.0),
                            Text(
                              'Помощь',
                              style: TextStyle(
                                fontSize: 14.0,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                color: Color(0xFFFFFFFF),
                              ),
                            ),
                          ],
                        )
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 155,
              child: Container(
                height: 40.0,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => EntryPage()),
                                (Route<dynamic> route) => false,
                          );
                        },
                        child: Text(
                              'Выйти',
                              style: TextStyle(
                                fontSize: 14.0,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                color: Color(0xFFFF2D2D),
                              ),
                        )
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 195,
              child: Container(
                height: 40.0,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isConfirmationVisible = true;
                          });

                          if (isConfirmationVisible) {
                            _showOverlay();
                          } else {
                            _hideOverlay();
                          }
                        },
                        child: Text(
                          'Удалить аккаунт',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            color: Color(0xFFFF2D2D),
                          ),
                        )
                    ),
                  ),
                ),
              ),
            ),
          ]
      ),
    );
  }
}