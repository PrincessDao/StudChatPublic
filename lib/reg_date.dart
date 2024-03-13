import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:stud_chat/reg_profile.dart';
import 'package:intl/intl.dart';

class RegDatePage extends StatefulWidget {
  @override
  _RegDatePageState createState() => _RegDatePageState();
}

class _RegDatePageState extends State<RegDatePage> with SingleTickerProviderStateMixin {
  bool isLineClicked = false;
  bool isButtonDisabled = true;
  bool isFirstInput = true;

  TextEditingController dateController = TextEditingController();
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

  void _handleDateInput(String input) {
    String formattedDate = '';

    for (int i = 0; i < input.length; i++) {
      if (i == 2 || i == 4) {
        formattedDate += '.';
      }
      formattedDate += input[i];
    }



    dateController.value = dateController.value.copyWith(
      text: formattedDate,
      selection: TextSelection.collapsed(offset: formattedDate.length),
    );

    if (_isValidDate(formattedDate)) {
      setState(() {
        isButtonDisabled = false;
      });
    } else {
      setState(() {
        isButtonDisabled = true;
      });
    }

    if (isFirstInput) {
      setState(() {
        isLineClicked = true;
        isFirstInput = false;
      });
    } else {
      setState(() {
        isLineClicked = dateController.text.isNotEmpty;
      });
    }
  }

  bool _isValidDate(String inputDate) {
    try {
      DateTime selectedDate = DateFormat("dd.MM.yyyy").parseStrict(inputDate);

      DateTime currentDate = DateTime.now();

      DateTime maxDate = currentDate.subtract(Duration(days: 18 * 365));

      DateTime minDate = currentDate.subtract(Duration(days: 98 * 365));

      return selectedDate.isBefore(maxDate) && selectedDate.isAfter(minDate);
    } catch (e) {
      return false;
    }
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
                    Navigator.pop(context);
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
                'Введите дату рождения',
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
                'Введите вашу реальную дату рождения',
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
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                ],
                enableInteractiveSelection: false,
                autocorrect: false,
                enableSuggestions: false,
                keyboardType: TextInputType.numberWithOptions(signed: false, decimal: false),
                controller: dateController,
                focusNode: _focusNode,
                obscureText: false,
                showCursor: false,
                onChanged: _handleDateInput,
                maxLength: 8,
                onTap: () {
                  setState(() {
                    isLineClicked = dateController.text.isNotEmpty;
                  });
                },
                onEditingComplete: () {
                  setState(() {
                    isLineClicked = false;
                  });
                },
                decoration: InputDecoration(
                  counterText: "",
                  hintText: 'Введите дату рождения',
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
                  'Использование приложения разрешено лицам старше 18 лет. Формат даты: ДД.ММ.ГГГГ',
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
                    CupertinoPageRoute(builder: (context) => RegProfilePage()));
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