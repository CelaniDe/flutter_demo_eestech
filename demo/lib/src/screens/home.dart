import 'dart:convert';
import 'dart:io';

import 'package:demo/auth.dart';
import 'package:demo/src/screens/scanner.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

var badgesFolder = 'assets/badges/';
List<String> childrenData = [
  badgesFolder + '1.png',
  badgesFolder + '2.png',
  badgesFolder + '3.png',
  badgesFolder + '4.png',
];

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  final User? user = Auth().currentUSer;
  int currentProgress = 0;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Widget _signOutButton() {
    return ElevatedButton(onPressed: signOut, child: const Text('Sign out'));
  }

  Widget _userUid() {
    return Text(user?.email ?? 'User email');
  }

  List<Widget> widgetList = [];

  int startingValue = 5;

  void updateToolTipText() {
    widgetList = childrenData
        .asMap()
        .map((index, assetPath) {
          final imageName = assetPath.split('/').last.replaceAll('.png', '');
          String tooltipMessage =
              'You need ${(startingValue + (index * 5)) - currentProgress} tasks to earn that badge!';

          return MapEntry(
            index,
            Tooltip(
              message: tooltipMessage,
              child: Container(
                width: 50,
                height: 50,
                margin: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage(assetPath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          );
        })
        .values
        .toList();
  }

  @override
  void initState() {
    super.initState();
    updateToolTipText();
  }

  void incrementX() {
    setState(() {
      currentProgress++;
      updateToolTipText();
    });
  }

  @override
  Widget build(BuildContext context) {
    var constraints;
    final screenSize = MediaQuery.of(context).size;
    return Container(
      height: screenSize.height- 200,
      child: Stack(

      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                'Welcome to the Park',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            ElevatedButton(
              onPressed: incrementX,
              child: Text('Complete task'),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: widgetList,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Container(
                width: 450,
                height: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: Image.asset('assets/park.png').image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
        Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                Padding(
                  padding: EdgeInsets.only(top: 100),
                  child: Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: Image.asset('assets/pou_img.png').image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 20, left: 10),
                    child: Container(
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.lightBlueAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child:
                      Padding(
                        padding: EdgeInsets.all(10),
                        child:
                        Text(
                          'Welcome! My name is Maou and \ntogether we will learn about food waste',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        )
                      ),
                    )),
              ],
            )),
      ],
    ));
  }
}
