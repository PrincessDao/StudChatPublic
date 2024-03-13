import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:stud_chat/entry.dart';
import 'package:stud_chat/reg_email.dart';

class PasswordRecPasswordPage extends StatefulWidget {
  @override
  _PasswordRecPasswordPageState createState() => _PasswordRecPasswordPageState();
}

class _PasswordRecPasswordPageState extends State<PasswordRecPasswordPage> with SingleTickerProviderStateMixin {
  bool isLineClicked = false;
  bool isButtonDisabled = true;
  bool isPasswordVisible = false;
  bool isPasswordValid = false;

  TextEditingController passwordController = TextEditingController();
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

  bool isValidPassword(String password) {

    bool isLengthValid = password.length >= 7;

    bool hasUpperCase = password.contains(RegExp(r'[A-ZА-Я]', unicode: true));

    bool hasDigit = password.contains(RegExp(r'[0-9]'));

    return isLengthValid && hasUpperCase && hasDigit;
  }

  void updateButtonState() {
    setState(() {
      isButtonDisabled = !isPasswordValid;
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
                      Navigator.pushReplacement(
                          context,
                          CupertinoPageRoute(builder: (context) => RegEmailPage()));
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
                'Введите новый пароль',
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
                'Введите новый пароль, включая в него не менее семи символов. При этом обязательно добавьте хотя бы одну заглавную букву и одну цифру',
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
                enableInteractiveSelection: false,
                controller: passwordController,
                obscureText: !isPasswordVisible,
                focusNode: _focusNode,
                onChanged: (password) {
                  setState(() {
                    isLineClicked = password.isNotEmpty;
                    isButtonDisabled = !isValidPassword(password);
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Введите новый пароль',
                  hintStyle: TextStyle(
                    fontSize: 12.0,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.normal,
                    color: Color(0xFF5F5F5F),
                  ),
                  contentPadding: EdgeInsets.only(
                      left: 22.0, bottom: 3.0, right: 66.0),
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
            top: 230,
            left: (MediaQuery.of(context).size.width -
                MediaQuery.of(context).size.width * 0.9) /
                2,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              height: 50,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isPasswordVisible = !isPasswordVisible;
                  });
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: 50,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(
                              right: 12),
                          child: Image(
                            image: AssetImage(isPasswordVisible
                                ? 'lib/assets/entry/openEye.png'
                                : 'lib/assets/entry/closeEye.png'),
                            fit: BoxFit.contain,
                            width: 30,
                            height: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
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
                child: Builder(
                  builder: (context) {
                    String message = '';

                    if (passwordController.text.length < 7) {
                      message += 'Пароль должен содержать не менее 7 символов. ';
                    }

                    if (!passwordController.text.contains(RegExp(r'[A-ZА-Я]', unicode: true))) {
                      message += 'Добавьте хотя бы одну заглавную букву. ';
                    }

                    if (!passwordController.text.contains(RegExp(r'[0-9]'))) {
                      message += 'Добавьте хотя бы одну цифру.';
                    }

                    message = message.trim();

                    return Text(
                      message.isNotEmpty ? message : '',
                      style: TextStyle(
                        fontSize: 10.0,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.normal,
                        color: Color(0xFFfc6262),
                      ),
                    );
                  },
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
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => EntryPage()),
                );
              },
                child: Container(
                  decoration: BoxDecoration(
                    color: isButtonDisabled ? Colors.grey : Color(0xFF6D55FF),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Center(
                    child: Text(
                      'Готово',
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