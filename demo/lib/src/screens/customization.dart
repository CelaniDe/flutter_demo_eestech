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
              color: Colors.lightBlue,
              child: Text(
                'Welcome! My name is Maou and \ntogether we will learn about food waste',
                style: TextStyle(
                  fontSize: 15,
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
                        width: 50,
                        height: 50,
                        child: Image.asset(
                            'assets/hats/hat1.png'), // Replace with your image path
                      ),
                      title: Text(hat),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        TextButton(
                          child: const Text('BUY'),
                          onPressed: () {/* ... */},
                        ),
                        const SizedBox(width: 8),
                        const SizedBox(width: 8),
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
