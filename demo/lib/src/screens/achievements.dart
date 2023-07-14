import 'dart:convert';
import 'dart:io';

import 'package:demo/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class achievements extends StatefulWidget {
  const achievements({Key? key}) : super(key: key);

  @override
  State<achievements> createState() => _achievementsState();
}

class _achievementsState extends State<achievements> {
  final User? user = Auth().currentUSer;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Widget _signOutButton() {
    return ElevatedButton(onPressed: signOut, child: const Text('Sign out'));
  }

  Widget _userUid() {
    return Text(user?.email ?? 'User email');
  }

  var badgesFolder = 'assets/badges/';

  List<Widget> widgetList = [];

  @override
  void initState() {
    super.initState();

    List<String> childrenData = [
      badgesFolder + '1.png',
      badgesFolder + '2.png',
      badgesFolder + '3.png',
      badgesFolder + '4.png',
    ];

    int startingValue = 5;

    widgetList = childrenData
        .asMap()
        .map((index, assetPath) {
          final imageName = assetPath.split('/').last.replaceAll('.png', '');
          final tooltipMessage =
              'You have accomplished ${startingValue + (index * 5)} tasks!';

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
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              'Local Achievements',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.left,
            ),
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
            child: Text(
              'Global Achievements',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.left,
            ),
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
              padding: EdgeInsets.only(top: 100, left: 100),
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
              )
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, left: 200),
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: Image.asset('assets/pou_img.png').image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
