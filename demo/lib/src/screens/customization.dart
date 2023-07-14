import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/coinfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

class Product {
  String name;
  int price;
  String image;

  Product(this.name, this.price, this.image);
}

class customization extends StatefulWidget {
  const customization({Key? key});

  @override
  _customizationState createState() => _customizationState();
}

class _customizationState extends State<customization> {
  List<Product> hats = List.generate(
      5,
      (index) =>
          Product("Hat ${index}", (index + 1) * 10, 'assets/hats/hat1.png'));

  @override
  void initState() {
    super.initState();
  }

  Future<void> removePoints(int pointToRemove) async {
    final user = FirebaseAuth.instance.currentUser;
    final userCollection = FirebaseFirestore.instance.collection('users');
    DocumentSnapshot currentUserSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();
    Map<String, dynamic> newDoc = {"coins": 50};
    Map<String, dynamic> newDoc2 =
        currentUserSnapshot.data() as Map<String, dynamic>;
    newDoc2['coins'] = (newDoc2['coins'] as int) - pointToRemove;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .set(newDoc2);
  }

  Future<void> addDigitalItem(Product newProduct) async {
    final user = FirebaseAuth.instance.currentUser;
    final userCollection = FirebaseFirestore.instance.collection('users');

    if (user != null) {
      final userDoc = userCollection.doc(user.uid);
      Map<String, dynamic> newwww = {
        "name": newProduct.name,
        "selected": false,
      };
      await userDoc.collection('digitalItems').doc().set(newwww);
    }
  }

  Future<bool> hasBought(Product newProduct) async {
    final user = FirebaseAuth.instance.currentUser;
    final userCollection = FirebaseFirestore.instance.collection('users');

    if (user != null) {
      final userDoc = userCollection.doc(user.uid);
      QuerySnapshot documentSnapshot = await userDoc
          .collection('digitalItems')
          .where('name', isEqualTo: newProduct.name)
          .get();

      print(documentSnapshot.docs);
      if (documentSnapshot.docs.isEmpty) return false;
      return true;
    }
    return false;
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
                            hat.image), // Replace with your image path
                      ),
                      title: Text(hat.name),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        CoinField(
                            coinImagePath: 'assets/coin.png',
                            coinCount: hat.price),
                        FutureBuilder(
                            future: hasBought(hat),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              } else if (snapshot.hasData) {
                                print(snapshot.data);
                                if (snapshot.data as bool) {
                                  return TextButton(
                                    child: const Text('SELECT'),
                                    onPressed: () {},
                                  );
                                } else {
                                  return TextButton(
                                    child: const Text('BUY'),
                                    onPressed: () {
                                      removePoints(hat.price);
                                      addDigitalItem(Product(
                                          hat.name, hat.price, hat.image));
                                    },
                                  );
                                }
                              } else {
                                return Text("No data");
                              }
                            })
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
