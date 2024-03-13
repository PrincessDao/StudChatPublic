import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AcquaintTab extends StatefulWidget {
  @override
  _AcquaintTabState createState() => _AcquaintTabState();
}

class _AcquaintTabState extends State<AcquaintTab> {
  PageController _pageController = PageController(initialPage: 0);
  List<String> images = [];
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    loadImagesFromJson();
  }

  Future<void> loadImagesFromJson() async {
    String jsonContent = await rootBundle.loadString('lib/assets/profiles.json');
    List<dynamic> jsonData = json.decode(jsonContent);

    for (var item in jsonData) {
      for (var i = 1; i <= 6; i++) {
        String imagePath = item['image$i'] ?? "";
        if (imagePath.isNotEmpty) {
          images.add(imagePath);
        }
      }
    }

    setState(() {});
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
          Positioned(
            top: MediaQuery
                .of(context)
                .size
                .height * 0.12,
            left: 10,
            right: 10,
            bottom: MediaQuery
                .of(context)
                .size
                .height * 0.12,
            child: GestureDetector(
              onTapDown: (details) {
                // Calculate the tap position
                double tapPosition = details.globalPosition.dx;
                // Determine whether to swipe left or right based on the tap position
                if (tapPosition < MediaQuery.of(context).size.width / 2) {
                  // Swipe left
                  if (currentPage > 0) {
                    _pageController.animateToPage(currentPage - 1,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut);
                  }
                } else {
                  // Swipe right
                  if (currentPage < images.length - 1) {
                    _pageController.animateToPage(currentPage + 1,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut);
                  }
                }
              },
              child: Stack(
                children: [
                  PageView.builder(
                    controller: _pageController,
                    itemCount: images.length,
                    onPageChanged: onPageChanged,
                    itemBuilder: (context, index) {
                      return buildContainer(images[index]);
                    },
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {},
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
                          onTap: () {},
                          child: Image(
                            image: AssetImage('lib/assets/acquaint/like.png'),
                            fit: BoxFit.fitHeight,
                            width: MediaQuery.of(context).size.width * 0.16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(images.length, (index) {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          width: MediaQuery.of(context).size.width * 0.23,
                          height: 4.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(36.0),
                            color: currentPage == index ? Colors.white : Colors.grey,
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildContainer(String imagePath) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.90,
      height: MediaQuery.of(context).size.height * 0.95,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(9.0),
                topRight: Radius.circular(9.0),
              ),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.44),
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
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.44),
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
      ),
    );
  }
  void onPageChanged(int page) {
    setState(() {
      currentPage = page;
    });
  }
}