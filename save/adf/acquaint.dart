import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AcquaintTab extends StatefulWidget {
  @override
  _AcquaintTabState createState() => _AcquaintTabState();
}

class _AcquaintTabState extends State<AcquaintTab> {
  PageController _profilePageController = PageController(initialPage: 0);
  PageController _photoPageController = PageController(initialPage: 0);

  List<List<String>> imagesList = [];
  int currentProfileIndex = 0;
  int currentPhotoIndex = 0;

  List<Map<String, dynamic>> profiles = [];

  @override
  void initState() {
    super.initState();
    loadProfilesFromJson();
  }

  Future<void> loadProfilesFromJson() async {
    String jsonContent =
    await rootBundle.loadString('lib/assets/profiles.json');
    List<dynamic> jsonData = json.decode(jsonContent);

    for (var item in jsonData) {
      List<String> images = [];
      for (var i = 1; i <= 3; i++) {
        String imagePath = item['form']['image$i'] ?? "";
        if (imagePath.isNotEmpty) {
          images.add(imagePath);
        }
      }
      imagesList.add(images);
      profiles.add(item['form']);
    }

    setState(() {});
  }

  void handleLike() {
    if (currentProfileIndex < profiles.length - 1) {
      setState(() {
        currentProfileIndex++;
        _profilePageController.animateToPage(currentProfileIndex,
            duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
      });
    } else {
      currentProfileIndex = 0;
    }
  }

  void handleReject() {
    if (currentProfileIndex > 0) {
      setState(() {
        currentProfileIndex--;
        _profilePageController.animateToPage(currentProfileIndex,
            duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
      });
    } else {
      currentProfileIndex = profiles.length - 1;
    }
  }



  @override
  Widget build(BuildContext context) {
    var mySystemTheme = SystemUiOverlayStyle.light.copyWith(
      systemNavigationBarColor: Color(0xFF161616),
    );
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
            top: MediaQuery.of(context).size.height * 0.12,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).size.height * 0.12,
            child: GestureDetector(
              onHorizontalDragEnd: (details) {
                double velocity = details.primaryVelocity!;
                if (velocity > 0) {
                  handleReject();
                } else {
                  handleLike();
                }
              },
              child: Stack(
                children: [
                  PageView.builder(
                    controller: _profilePageController,
                    itemCount: profiles.length,
                    onPageChanged: (page) {
                      setState(() {
                        currentProfileIndex = page;
                        currentPhotoIndex = page;
                      });
                    },
                    itemBuilder: (context, index) {
                      return buildProfileContainer(imagesList[index]);
                    },
                  ),
                  Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(imagesList[currentProfileIndex].length, (index) {
                              return Container(
                                margin: EdgeInsets.symmetric(horizontal: 4),
                                width: MediaQuery.of(context).size.width * 0.23,
                                height: 4.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(36.0),
                                  color: currentPhotoIndex == index
                                      ? Colors.white
                                      : Colors.grey,
                                ),
                              );
                            }),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: handleReject,
                              child: Image(
                                image: AssetImage('lib/assets/acquaint/reject.png'),
                                fit: BoxFit.fitHeight,
                                width: MediaQuery.of(context).size.width * 0.16,
                              ),
                            ),
                            SizedBox(width: MediaQuery.of(context).size.width * 0.13),
                            GestureDetector(
                              onTap: () {},
                              child: Image(
                                image: AssetImage('lib/assets/acquaint/return.png'),
                                fit: BoxFit.fitHeight,
                                width: MediaQuery.of(context).size.width * 0.16,
                              ),
                            ),
                            SizedBox(width: MediaQuery.of(context).size.width * 0.13),
                            GestureDetector(
                              onTap: handleLike,
                              child: Image(
                                image: AssetImage('lib/assets/acquaint/like.png'),
                                fit: BoxFit.fitHeight,
                                width: MediaQuery.of(context).size.width * 0.16,
                              ),
                            ),
                          ],
                        ),
                        ),
                      ],
                    ),
                ],
              ),
      ),
                  ),
      ],
      ),
    );
  }

  Widget buildProfileContainer(List<String> imagePaths) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.90,
      height: MediaQuery.of(context).size.height * 0.95,
      child: PageView.builder(
        controller: _photoPageController,
        itemCount: imagePaths.length,
        itemBuilder: (context, index) {
          return Stack(
            alignment: AlignmentDirectional.center,
            children: <Widget>[
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(9.0),
                    topRight: Radius.circular(9.0),
                  ),
                  child: Image.asset(
                    imagePaths[index],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.44),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF0D0C13).withOpacity(0),
                        Color(0xFF161616).withOpacity(1),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.44),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF0D0C13).withOpacity(0),
                        Color(0xFF161616).withOpacity(1),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}