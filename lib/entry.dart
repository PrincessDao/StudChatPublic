import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:stud_chat/password_rec_email.dart';
import 'main.dart';
import 'reg_email.dart';

class EntryPage extends StatefulWidget {
  @override
  _EntryPageState createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage>
    with SingleTickerProviderStateMixin {
  bool isLineClicked = false;
  bool isButtonDisabled = false;
  bool isPasswordVisible = false;
  bool isCheckmarkVisible = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 450),
    );

    _animation = Tween<double>(begin: 1, end: 0.025).animate(_controller);

    restoreAnimationState();
  }



  void saveState() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('email', emailController.text);
      prefs.setString('password', passwordController.text);
      prefs.setBool('isCheckmarkVisible', isCheckmarkVisible);
      prefs.setBool('isButtonDisabled', isButtonDisabled);
      prefs.setDouble('animationValue', _controller.value);
    });
  }

  void restoreState() {
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        emailController.text = prefs.getString('email') ?? '';
        passwordController.text = prefs.getString('password') ?? '';
        isCheckmarkVisible = prefs.getBool('isCheckmarkVisible') ?? false;
        isButtonDisabled = prefs.getBool('isButtonDisabled') ?? false;
      });
    });
  }

  void restoreAnimationState() {
    SharedPreferences.getInstance().then((prefs) {
      double animationValue = prefs.getDouble('animationValue') ?? 1.0;
      _controller.value = animationValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    var mySystemTheme = SystemUiOverlayStyle.light.copyWith(
        systemNavigationBarColor: Color(0xFF161616));
    SystemChrome.setSystemUIOverlayStyle(mySystemTheme);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Scaffold(
      backgroundColor: Color(0xFF161616),
      body: Stack(
        children: [

          SingleChildScrollView(
            child: Align(
              alignment: Alignment.topCenter,
              child: Image(
                image: AssetImage('lib/assets/entry/art.png'),
                fit: BoxFit.contain,
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.05,
            left: 0,
            right: 0,
            child: Center(
              child: Image(
                image: AssetImage('lib/assets/entry/studchat.png'),
                fit: BoxFit.contain,
                height: 352,
                width: 172,
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: (MediaQuery.of(context).size.width -
                MediaQuery.of(context).size.width * 0.85) /
                2,
            width: MediaQuery.of(context).size.width * 0.85,
            height: 50,
            child: GestureDetector(
              onTap: () {
                if (!isButtonDisabled) {
                  _controller.forward();
                  setState(() {
                    isLineClicked = true;
                    isButtonDisabled = true;
                  });
                }
              },
              child: AnimatedOpacity(
                opacity: isButtonDisabled ? 0 : 1,
                duration: Duration.zero,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF6D55FF),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Center(
                    child: Text(
                      'Начать',
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
          ),
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Stack(
                children: [
                  Positioned(
                    bottom: 10,
                    left: MediaQuery.of(context).size.width * _animation.value,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.95,
                      height: 385,
                      decoration: BoxDecoration(
                        color: Color(0xFF202020),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 23,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Text(
                                'Добро пожаловать в STUDCHAT',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 46,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Text(
                                textAlign: TextAlign.center,
                                'Знакомства, события, развлечения\n и многое другое!',
                                style: TextStyle(
                                  height: 1,
                                  fontSize: 12.0,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xFF5F5F5F),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 60,
                            left: (MediaQuery.of(context).size.width -
                                MediaQuery.of(context).size.width * 0.9) /
                                2,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.85,
                              height: 50,
                              child: Padding(
                                padding: EdgeInsets.only(top: 14.0),
                                child: Text(
                                  'Почта:',
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFFFFFFFF),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 100,
                            left: (MediaQuery.of(context).size.width -
                                MediaQuery.of(context).size.width * 0.9) /
                                2,
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
                                obscureText: false,
                                decoration: InputDecoration(
                                  hintText: 'Введите почту',
                                  hintStyle: TextStyle(
                                    fontSize: 12.0,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.normal,
                                    color: Color(0xFF5F5F5F),
                                  ),
                                  contentPadding: EdgeInsets.only(
                                      left: 22.0, bottom: 3.0, right: 22.0),
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
                            top: 140,
                            left: (MediaQuery.of(context).size.width -
                                MediaQuery.of(context).size.width * 0.9) /
                                2,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.85,
                              height: 50,
                              child: Padding(
                                padding: EdgeInsets.only(top: 14.0),
                                child: Text(
                                  'Пароль:',
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFFFFFFFF),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 140,
                            left: (MediaQuery.of(context).size.width -
                                MediaQuery.of(context).size.width * 0.9) /
                                2,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.85,
                              height: 50,
                              child: Padding(
                                padding: EdgeInsets.only(top: 14.0),
                                child: Text(
                                  'Пароль:',
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFFFFFFFF),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 180,
                            left: (MediaQuery.of(context).size.width -
                                MediaQuery.of(context).size.width * 0.9) /
                                2,
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
                                decoration: InputDecoration(
                                  hintText: 'Введите пароль',
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
                            top: 190,
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
                                              right: 20),
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
                            top: 220,
                            left: (MediaQuery.of(context).size.width -
                                MediaQuery.of(context).size.width * 0.9) /
                                2,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.85,
                              height: 50,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isCheckmarkVisible = !isCheckmarkVisible;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Image(
                                      image: AssetImage(isCheckmarkVisible
                                          ? 'lib/assets/entry/checkmarkOn.png'
                                          : 'lib/assets/entry/checkmarkOff.png'),
                                      fit: BoxFit.contain,
                                      width: 24.0,
                                      height: 24.0,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 5.0),
                                      child: Text(
                                        'Запомнить меня',
                                        style: TextStyle(
                                          fontSize: 11.0,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.normal,
                                          color: Color(0xFFFFFFFF),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 220,
                            left: (MediaQuery.of(context).size.width -
                                MediaQuery.of(context).size.width * 0.9) /
                                2,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.85,
                              height: 50,
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: EdgeInsets.only(left: 25.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Future.delayed(const Duration(milliseconds: 200), () {
                                      Navigator.push(
                                        context,
                                        CupertinoPageRoute(builder: (context) => PasswordRecEmailPage()),
                                      );
                                    });
                                  },
                                child: Text(
                                  'Забыли пароль...?',
                                  style: TextStyle(
                                    fontSize: 11.0,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.normal,
                                    color: Color(0xFF515151),
                                  ),
                                ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 290,
                            left: (MediaQuery.of(context).size.width -
                                MediaQuery.of(context).size.width * 0.9) /
                                2,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (context) => MyHomePage()),
                                );
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.85,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Color(0xFF6D55FF),
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                child: Center(
                                  child: Text(
                                    'Войти',
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
                          Positioned(
                            top: 335,
                            left: (MediaQuery.of(context).size.width -
                                MediaQuery.of(context).size.width * 0.9) /
                                2,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.85,
                              height: 50,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Ещё не зарегистрированы...?',
                                    style: TextStyle(
                                      fontSize: 11.0,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.normal,
                                      color: Color(0xFFFFFFFF),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 5.0),
                                    child: GestureDetector(
                                      onTap: () {
                                  Future.delayed(const Duration(milliseconds: 200), () {
                                        Navigator.push(
                                            context,
                                            CupertinoPageRoute(builder: (context) => RegEmailPage()),
                                        );
                                        });
                                      },
                                      child: Text(
                                        'Регистрация',
                                        style: TextStyle(
                                          fontSize: 11.0,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.normal,
                                          color: Color(0xFF6D55FF),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    clearState();
    _controller.dispose();
    super.dispose();
  }

  void clearState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}