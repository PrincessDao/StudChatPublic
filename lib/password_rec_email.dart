import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stud_chat/password_rec_code.dart';
import 'package:flutter/cupertino.dart';

class PasswordRecEmailPage extends StatefulWidget {
  @override
  _PasswordRecEmailPageState createState() => _PasswordRecEmailPageState();
}

class _PasswordRecEmailPageState extends State<PasswordRecEmailPage> with SingleTickerProviderStateMixin {
  bool isLineClicked = false;
  bool isButtonDisabled = true;
  bool isEmailValid = false;

  TextEditingController emailController = TextEditingController();
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 100), () {
      FocusScope.of(context).requestFocus(_focusNode);
      });
    });

  }

  bool isValidEmail(String email) {
    RegExp emailRegExp = RegExp(r'^[a-zA-Zа-яА-Я0-9_.+-]+@[a-zA-Zа-яА-Я0-9-]+\.[a-zA-Zа-яА-Я0-9-.]+$', unicode: true);
    bool isValidDomain = emailRegExp.hasMatch(email) && (email.endsWith('.ru') || email.endsWith('.рф'));
    return isValidDomain && email.contains('@');
  }


  void updateButtonState() {
    setState(() {
      isButtonDisabled = !isEmailValid;
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
                    FocusScope.of(context).unfocus();
                    Future.delayed(const Duration(milliseconds: 200), () {
                      Navigator.popUntil(context, (route) => route.isFirst);
                  });
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
                'Забыли пароль?',
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
                'Восстановите пароль, предоставив ваш адрес электронной почты с действительным доменным именем',
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
            top: 220,
            left: (MediaQuery.of(context).size.width - MediaQuery.of(context).size.width * 0.85) / 2,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              height: 50,
              decoration: BoxDecoration(
                color: Color(0xFF6D55FF).withOpacity(0),
                borderRadius: BorderRadius.circular(25.0),
                border: Border.all(
                  color: Color(0xFF6D55FF),
                ),
              ),
              child: TextField(
                controller: emailController,
                focusNode: _focusNode,
                obscureText: false,
                onChanged: (email) {
                  setState(() {
                    isEmailValid = isValidEmail(email);
                    updateButtonState();
                    isLineClicked = email.isNotEmpty;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Введите почту',
                  hintStyle: TextStyle(
                    fontSize: 12.0,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.normal,
                    color: Color(0xFF5F5F5F),
                  ),
                  contentPadding: EdgeInsets.only(left: 22.0, bottom: 3.0, right: 22.0),
                  border: InputBorder.none,
                ),
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
            top: 280,
            left: (MediaQuery.of(context).size.width - MediaQuery.of(context).size.width * 0.85) / 2,
            child: AnimatedOpacity(
              opacity: isLineClicked ? 1.0 : 0.0,
              duration: Duration.zero,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                height: 50,
                child: Text(
                  'Доступ к почте предоставляется только для\nадресов с доменами .ru и .рф',
                  style: TextStyle(
                    fontSize: 10.0,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.normal,
                    color: Color(0xFFfcf172),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: (MediaQuery.of(context).size.width - MediaQuery.of(context).size.width * 0.85) / 2,
            width: MediaQuery.of(context).size.width * 0.85,
            height: 50,
            child: GestureDetector(
              onTap: isButtonDisabled
                  ? null
                  : () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => PasswordRecCodePage(email: emailController.text),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: isButtonDisabled ? Colors.grey : Color(0xFF6D55FF),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Center(
                  child: Text(
                    'Далее',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
        ),
    );
  }
}