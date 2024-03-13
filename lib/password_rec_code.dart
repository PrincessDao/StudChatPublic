import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:stud_chat/password_rec_password.dart';

class PasswordRecCodePage extends StatefulWidget {

  final String email;

  PasswordRecCodePage({required this.email});

  @override
  _PasswordRecCodePageState createState() => _PasswordRecCodePageState();
}

class _PasswordRecCodePageState extends State<PasswordRecCodePage> with SingleTickerProviderStateMixin {
  bool isLineClicked = false;
  bool isButtonDisabled = false;

  TextEditingController codeController = TextEditingController();
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  Widget build(BuildContext context) {
    var mySystemTheme = SystemUiOverlayStyle.light
        .copyWith(systemNavigationBarColor: Color(0xFF161616));
    SystemChrome.setSystemUIOverlayStyle(mySystemTheme);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Scaffold(
      backgroundColor: Color(0xFF161616),
      body: Stack(
        children: [
          Positioned(
            top: 70,
            left: (MediaQuery.of(context).size.width - MediaQuery.of(context).size.width * 0.85) / 2,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              height: 50,
              child: Align(
                alignment: Alignment.topLeft,
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
            top: 120,
            left: (MediaQuery.of(context).size.width - MediaQuery.of(context).size.width * 0.85) / 2,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              height: 50,
              child: Text(
                'Введите код',
                style: TextStyle(
                  fontSize: 24.0,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFFFFFFF),
                ),
              ),
            ),
          ),
          Positioned(
            top: 160,
            left: (MediaQuery.of(context).size.width - MediaQuery.of(context).size.width * 0.85) / 2,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              height: 50,
              child: Text(
                'Мы отправили код верификации на вашу почту',
                style: TextStyle(
                  fontSize: 12.0,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.normal,
                  color: Color(0xFF5F5F5F),
                ),
              ),
            ),
          ),
          Positioned(
            top: 180,
            left: (MediaQuery.of(context).size.width - MediaQuery.of(context).size.width * 0.85) / 2,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              height: 30,
              child: Text(
                widget.email,
                style: TextStyle(
                  fontSize: 12.0,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.normal,
                  color: Color(0xFFFFFFFF),
                ),
              ),
            ),
          ),
          Positioned(
            top: 220,
            left: (MediaQuery.of(context).size.width - MediaQuery.of(context).size.width * 0.85) / 2,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xFF161616),
                ),
              ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 22.0, bottom: 0.0, right: 22.0),
                  child: Row(
                      children: [
                    Container(
              width: 15,
              height: 3,
              decoration: BoxDecoration(
                color: Color(0xFF848484),
                borderRadius: BorderRadius.circular(25.0),
                     ),
                    ),
                        SizedBox(width: 34), //260 170
                        Container(
                          width: 15,
                          height: 3,
                          decoration: BoxDecoration(
                            color: Color(0xFF848484),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                        SizedBox(width: 34),
                        Container(
                          width: 15,
                          height: 3,
                          decoration: BoxDecoration(
                            color: Color(0xFF848484),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                        SizedBox(width: 34),
                        Container(
                          width: 15,
                          height: 3,
                          decoration: BoxDecoration(
                            color: Color(0xFF848484),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                        SizedBox(width: 34),
                        Container(
                          width: 15,
                          height: 3,
                          decoration: BoxDecoration(
                            color: Color(0xFF848484),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                        SizedBox(width: 34),
                        Container(
                          width: 15,
                          height: 3,
                          decoration: BoxDecoration(
                            color: Color(0xFF848484),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                   ],
                  ),
                  ),
            ),
          ),
          Positioned(
            top: 220,
            left: (MediaQuery.of(context).size.width - MediaQuery.of(context).size.width * 0.85) / 2,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xFF161616),
                ),
              ),
              child: TextField(
                 onChanged: (String value) async {
                   if (value.length == 6) {
                         Future.delayed(const Duration(milliseconds: 2000), () {
                           Navigator.push(
                               context,
                               CupertinoPageRoute(builder: (context) => PasswordRecPasswordPage()));
                         });
                   }
                 },
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                ],
                cursorColor: Colors.transparent,
                enableInteractiveSelection: false,
                autocorrect: false,
                enableSuggestions: false,
                maxLength: 6,
                //cursorColor: ,
                controller: codeController,
                focusNode: _focusNode,
                keyboardType: TextInputType.numberWithOptions(signed: false, decimal: false),
                obscureText: false,
                decoration: InputDecoration(
                  counterText: "",
                  hintText: '',
                  hintStyle: TextStyle(
                    fontSize: 24.0,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF5F5F5F),
                  ),
                  contentPadding: EdgeInsets.only(left: 5.0, bottom: 5.0),
                  border: InputBorder.none,
                ),
                style: TextStyle(
                  backgroundColor: Color(0xFF161616),
                    shadows: [
                      Shadow( // topLeft
                          offset: Offset(-8.0, 0.0),
                          color: Color(0xFF161616)
                      ),
                      Shadow( // topLeft
                          offset: Offset(-9.0, 0.0),
                          color: Color(0xFF161616)
                      ),
                      Shadow( // topLeft
                          offset: Offset(-10.0, 0.0),
                          color: Color(0xFF161616)
                      ),
                      Shadow( // topLeft
                          offset: Offset(-11.0, 0.0),
                          color: Color(0xFF161616)
                      ),
                      Shadow( // topLeft
                          offset: Offset(-12.0, 0.0),
                          color: Color(0xFF161616)
                      ),
                    ],
                  letterSpacing: 35.2,
                  fontSize: 24.0,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
            ),
          ),
        ],
      ),
    );
  }
}