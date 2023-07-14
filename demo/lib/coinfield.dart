import 'package:flutter/material.dart';

class CoinField extends StatelessWidget {
  final String coinImagePath; // Path of the coin image
  int coinCount;
  CoinField({required this.coinImagePath, this.coinCount = 0});

  setCoins(int coins) => coinCount = coins;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 150,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            coinImagePath,
            width: 30,
            height: 30,
          ),
          SizedBox(height: 10, width: 15),
          Text(
            '$coinCount',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
