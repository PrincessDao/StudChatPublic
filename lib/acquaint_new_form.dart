import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class AcquaintNewFormPage extends StatefulWidget {

  @override
  _AcquaintNewFormPageState createState() => _AcquaintNewFormPageState();
}

class _AcquaintNewFormPageState extends State<AcquaintNewFormPage> {

  bool isButtonDisabled = true;

  late TextEditingController infoFormController = TextEditingController();

  List<File?> _images = List.generate(6, (index) => null);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 100), () {
      });
    });
    infoFormController.addListener(updateButtonState);

  }

  void updateButtonState() {
    setState(() {
      isButtonDisabled = infoFormController.text.isEmpty || _images.every((image) => image == null);
    });
  }

  Future<void> _pickImage(int index) async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _images[index] = File(pickedFile.path);
        updateButtonState();
      }
    });
  }

  void removeImage(int index) {
    setState(() {
      _images[index] = null;
      updateButtonState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              bottom: 3,
              child: Container(
                height: 40.0,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    'Знакомства',
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
        top: 0,
        left: (MediaQuery.of(context).size.width - MediaQuery.of(context).size.width * 0.85) / 2,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.85,
            height: 50,
            child: Builder(
              builder: (context) {
                String message = '';

                if (_images.every((image) => image == null)) {
                  message += 'Добавьте хотя бы одно фото. ';
                }

                if (infoFormController.text.isEmpty) {
                  message += 'Добавьте информацию о себе. ';
                }

                message = message.trim();

                return Text(
                  message.isNotEmpty ? message : '',
                  style: TextStyle(
                    fontSize: 10.0,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.normal,
                    color: Color(0xFFEF3C3C),
                  ),
                );
              },
            ),
          ),
      ),
      Padding(
        padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.8,
          ),
          itemCount: 6,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () => _pickImage(index),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF242424),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                margin: EdgeInsets.all(8.0),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: _images[index] != null
                            ? Image.file(
                          _images[index]!,
                          fit: BoxFit.cover,
                        )
                            : Center(
                          child: Image(
                            image: AssetImage('lib/assets/acquaint/addPhoto.png'),
                            fit: BoxFit.fitHeight,
                            width: MediaQuery.of(context).size.width * 0.09,
                          ),
                        ),
                      ),
                    ),
                    if (_images[index] != null)
                      Padding(
                        padding: EdgeInsets.only(left: 75.0),
                        child: GestureDetector(
                          onTap: () {
                            removeImage(index);
                          },
                          child: Image(
                            image: AssetImage('lib/assets/acquaint/deletePhoto.png'),
                            fit: BoxFit.fitHeight,
                            width: MediaQuery.of(context).size.width * 0.05,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      Positioned(
        top: 275,
        left: (MediaQuery.of(context).size.width - MediaQuery.of(context).size.width * 0.85) / 2,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          height: 50,
          child: Padding(
            padding: EdgeInsets.only(top: 14.0),
            child: Text(
              'О себе',
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
        top: 310,
        left: (MediaQuery.of(context).size.width - MediaQuery.of(context).size.width * 0.85) / 2,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          height: 90,
          decoration: BoxDecoration(
            color: Color(0xFF6D55FF).withOpacity(0),
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(
              color: Color(0xFF6D55FF),
            ),
          ),
          child: TextField(
            controller: infoFormController,
            maxLines: 3,
            maxLength: 150,
            maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds,
            //obscureText: false,
            decoration: InputDecoration(
              hintText: 'Расскажите коротко о себе',
              hintStyle: TextStyle(
                fontSize: 12.0,
                fontFamily: 'Inter',
                fontWeight: FontWeight.normal,
                color: Color(0xFF5F5F5F),
              ),
              contentPadding: EdgeInsets.only(left: 22.0, top: 15.0, right: 22.0),
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
        bottom: 90,
        left: (MediaQuery.of(context).size.width - MediaQuery.of(context).size.width * 0.85) / 2,
        width: MediaQuery.of(context).size.width * 0.85,
        height: 50,
        child: GestureDetector(
          onTap: isButtonDisabled
              ? null
              : () {
            //Дописать функционал для сохранения анкеты
            FocusScope.of(context).unfocus();
            Future.delayed(const Duration(milliseconds: 200), () {
              Navigator.pop(context);
            });
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
  ]
),
    );
  }
}