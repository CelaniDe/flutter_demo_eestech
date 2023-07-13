import 'dart:convert';
import 'dart:io';

import 'package:demo/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {

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

    widgetList = childrenData.map((assetPath) {
      return Container(
        width: 50,
        height: 50,
        margin: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          // color: Colors.green,
          image: DecorationImage(
            image: AssetImage(assetPath),
            fit: BoxFit.cover,
          ),
        ),
      );
    }).toList();
}



  @override
  Widget build(BuildContext context) {
    return Container(
      child:
      Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 20),
              child:
              Text(
                'Welcome to the Park',
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
              child:
              SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: widgetList,
              ),
            ),

            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child:
              Container(
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

        )
    );
  }
}