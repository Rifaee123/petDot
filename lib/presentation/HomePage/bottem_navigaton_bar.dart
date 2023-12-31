
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:petdot/presentation/ChatPage/chat_screen.dart';
import 'package:petdot/presentation/HomePage/Home.dart';
import 'package:petdot/presentation/MyProdectPage/my_ads_screen.dart';
import 'package:petdot/presentation/ProfilePage/profile_screen.dart';

class BottemNavigaton extends StatefulWidget {
  @override
  BottemNavigatonState createState() => BottemNavigatonState();
}

class BottemNavigatonState extends State<BottemNavigaton> {
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: Container(
        // margin: EdgeInsets.all(displayWidth * .05),
        height: displayWidth * .175,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.1),
              blurRadius: 30,
              offset: Offset(0, 10),
            ),
          ],
          borderRadius: BorderRadius.circular(50),
        ),
        child: ListView.builder(
          itemCount: 4,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: displayWidth * .02),
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              setState(() {
                currentIndex = index;
                HapticFeedback.lightImpact();
              });
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Stack(
              children: [
                AnimatedContainer(
                  duration: Duration(seconds: 1),
                  curve: Curves.fastLinearToSlowEaseIn,
                  width: index == currentIndex
                      ? displayWidth * .32
                      : displayWidth * .18,
                  alignment: Alignment.center,
                  child: AnimatedContainer(
                    duration: Duration(seconds: 1),
                    curve: Curves.fastLinearToSlowEaseIn,
                    height: index == currentIndex ? displayWidth * .12 : 0,
                    width: index == currentIndex ? displayWidth * .32 : 0,
                    decoration: BoxDecoration(
                      color: index == currentIndex
                          ? Color.fromRGBO(79, 249, 217, 1).withOpacity(.2)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                AnimatedContainer(
                  duration: Duration(seconds: 1),
                  curve: Curves.fastLinearToSlowEaseIn,
                  width: index == currentIndex
                      ? displayWidth * .31
                      : displayWidth * .18,
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          AnimatedContainer(
                            duration: Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            width:
                                index == currentIndex ? displayWidth * .13 : 0,
                          ),
                          AnimatedOpacity(
                            opacity: index == currentIndex ? 1 : 0,
                            duration: Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            child: Text(
                              index == currentIndex
                                  ? '${listOfStrings[index]}'
                                  : '',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          AnimatedContainer(
                            duration: Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            width:
                                index == currentIndex ? displayWidth * .03 : 20,
                          ),
                          Image.asset(
                            listOfImages[index],
                            width: displayWidth * .100,
                          )
                          // Icon(
                          //   listOfIcons[index],
                          //   size: displayWidth * .076,
                          //   color: index == currentIndex
                          //       ? Colors.blueAccent
                          //       : Colors.black26,
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: listofwidget[currentIndex],
    );
  }

  List<Widget> listofwidget = [
    HomePage(),
    ChatPage(),
    MyAdsPage(),
    ProfilePage()
  ];
  List<String> listOfImages = [
    "assets/images/icons8-home-100.png",
    'assets/images/icons8-chat-100.png',
    'assets/images/icons8-favorites-100.png',
    'assets/images/icons8-test-account-100.png',
  ];

  List<String> listOfStrings = [
    'Home',
    'Chat',
    'My Ads',
    'Account',
  ];
}
