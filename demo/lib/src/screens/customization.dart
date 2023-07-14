import 'package:demo/coinfield.dart';
import 'package:flutter/material.dart';

class customization extends StatefulWidget {
  const customization({Key? key});

  @override
  _customizationState createState() => _customizationState();
}

class _customizationState extends State<customization> {
  List<String> hats = ['hat1', 'hat2', 'hat3', 'hat4'];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.only(top: 20, left: 100),
            child: Container(
              child: Text(
                'Items for Sal',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  decoration: TextDecoration.underline,
                ),
              ),
            )),
        Padding(
            padding: EdgeInsets.only(top: 50, right: 300, bottom: 20),
            child: Container(
              child: Text(
                'Hats',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            )),
        Container(
          height: 500,
          child: ListView.builder(
            itemCount: hats.length,
            itemBuilder: (context, index) {
              final hat = hats[index];

              return Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: Container(
                        padding: EdgeInsets.only(top: 20),
                        width: 50,
                        height: 50,
                        child: Image.asset(
                            'assets/hats/hat1.png'), // Replace with your image path
                      ),
                      title: Text(hat),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        CoinField(
                            coinImagePath: 'assets/coin.png', coinCount: 10),
                        TextButton(
                          child: const Text('BUY'),
                          onPressed: () {/* ... */},
                        ),
                        // Increase the space between cards
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
