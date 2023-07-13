import 'package:demo/auth.dart';
import 'package:demo/src/screens/achievements.dart';
import 'package:demo/src/screens/home.dart';
import 'package:demo/src/screens/inventory.dart';
import 'package:demo/src/screens/settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import 'package:demo/coinfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final User? user = Auth().currentUSer;

  int coinCount = 0;
  final DatabaseReference coinsRef =
      FirebaseDatabase.instance.reference().child('coins');

  var _currentIndex = 0;

  final List<Widget> _pages = [
    inventory(),
    home(),
    achievements(),
    settings(),
  ];

  Future<int> fetchUserCoins() async {
    int userCoins = 0;

    if (user != null) {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get();
      print(user!.uid);

      if (documentSnapshot.exists) {
        Map<String, dynamic>? data =
            documentSnapshot.data() as Map<String, dynamic>?;
        if (data != null) {
          userCoins = data['coins'] ?? 0;
        }
      }
    }

    return userCoins;
  }

  @override
  void initState() {
    super.initState();
    fetchUserCoins().then((userCoins) {
      setState(() {
        coinCount = userCoins;
      });
    });
  }

  Widget _coinCount() {
    return Text('$coinCount');
  }

  Widget _title() {
    return const Text(
      'WasteNot',
      style: TextStyle(color: Colors.black, fontSize: 30), // Set text color to black
    );
  }

  Widget _userUid() {
    return Text(user?.email ?? 'User email');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Row(
          children: <Widget>[
            _title(),
            Spacer(),
            CoinField(
              coinImagePath: 'assets/coin.png', 
              coinCount: coinCount),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        ),
        body: Container(
            height: double.infinity,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                _pages[_currentIndex],
              ],
            )),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Container(
                width: 30,
                height: 30,
                child: Image.asset('assets/inventory.png'),
              ),
              label: 'Inventory',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Container(
                width: 30,
                height: 30,
                child: Image.asset('assets/award.png'),
              ),
              label: 'Achievements',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'settings',
            ),
          ],
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black.withOpacity(0.5),
        ));
  }
}
