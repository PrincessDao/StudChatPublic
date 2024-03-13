import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'main.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class RegProfilePage extends StatefulWidget {
  @override
  _RegProfilePageState createState() => _RegProfilePageState();
}

class _RegProfilePageState extends State<RegProfilePage> with SingleTickerProviderStateMixin {
  bool isLineClicked = false;
  bool isButtonDisabled = true;
  XFile? selectedImage;

  TextEditingController profileNameController = TextEditingController();
  TextEditingController profileSurnameController = TextEditingController();
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 100), () {
      FocusScope.of(context).requestFocus(_focusNode);
      });
    });

    profileNameController.addListener(updateButtonState);
    profileSurnameController.addListener(updateButtonState);

  }

  void updateButtonState() {
    setState(() {
      isButtonDisabled = profileNameController.text.isEmpty || profileSurnameController.text.isEmpty;
    });
  }

  Future<void> _pickImage() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedImage = image;
      });
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
                'Ваш профиль',
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
            top: 85,
            left: (MediaQuery.of(context).size.width + MediaQuery.of(context).size.width * 0.45) / 2,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.20,
              height: 66,
              child: GestureDetector(
                  onTap: _pickImage,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: ClipOval(
                          child: selectedImage != null
                              ? Image.file(
                            File(selectedImage!.path),
                            fit: BoxFit.cover,
                            height: 66,
                            width: 66,
                          )
                              : Image(
                            image: AssetImage('lib/assets/noIcon.png'),
                            fit: BoxFit.contain,
                            height: 66,
                            width: 66,
                          ),
                        ),
                      ),
                      if (selectedImage == null)
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Image(
                            image: AssetImage('lib/assets/addPhoto.png'),
                            fit: BoxFit.contain,
                            height: 27,
                            width: 27,
                          ),
                        ),
                    ],
                  )
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
                'Давайте заполним немного информации о вас!',
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
                controller: profileNameController,
                obscureText: false,
                decoration: InputDecoration(
                  hintText: 'Введите имя',
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
            top: 300,
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
                controller: profileSurnameController,
                obscureText: false,
                decoration: InputDecoration(
                  hintText: 'Введите фамилию',
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
            bottom: 20,
            left: (MediaQuery.of(context).size.width - MediaQuery.of(context).size.width * 0.85) / 2,
            width: MediaQuery.of(context).size.width * 0.85,
            height: 50,
            child: GestureDetector(
              onTap: isButtonDisabled
                  ? null
                  : () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => MyHomePage()),
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