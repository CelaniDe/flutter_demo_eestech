import 'package:demo/auth.dart';
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




Future<int> fetchUserCoins() async {
  int userCoins = 0;

  if (user != null) {
    

    DocumentSnapshot documentSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();
    print(user!.uid);

    if (documentSnapshot.exists) {
      Map<String, dynamic>? data = documentSnapshot.data() as Map<String, dynamic>?;
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

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Widget _title() {
    return const Text('Firebase Auth');
  }

  Widget _userUid() {
    return Text(user?.email ?? 'User email');
  }

  Widget _signOutButton() {
    return ElevatedButton(onPressed: signOut, child: const Text('Sign out'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
          children: <Widget>[
            _title(),
            Spacer(),
            CoinField(coinImagePath: 'assets/coin.png', coinCount: coinCount),
          ],
        )

      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[_userUid(), _signOutButton(),
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
            

          ],

        ),
      ),
        bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 50,
              height: 50,
              child: IconButton(
                icon: Image.asset('assets/inventory.png'),
                onPressed: () {
                  // Handle home button press
                },
              ),
            ),
            Container(
              width: 60,
              height: 60,
              child: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  // Handle search button press
                },
              ),
            ),
            Container(
              width: 60,
              height: 60,
              child: IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  // Handle settings button press
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
