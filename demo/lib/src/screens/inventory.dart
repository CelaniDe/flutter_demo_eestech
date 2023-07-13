import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  // collection reference
  final CollectionReference myCollection =
      FirebaseFirestore.instance.collection('users');

  Future<DocumentSnapshot> getData(String id) async {
    return await myCollection.doc(id).get();
  }
}

class Product {
  String name;
  DateTime expiryDate;
  bool selected;

  Product(this.name, this.expiryDate, {this.selected = false});
}

class inventory extends StatefulWidget {
  const inventory({Key? key}) : super(key: key);

  @override
  State<inventory> createState() => _inventoryState();
}

class _inventoryState extends State<inventory> {
  final User? user = Auth().currentUSer;

  List<Product> productList = List.empty();

  @override
  void initState() {
    super.initState();
    printProducts2();
  }

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Future<void> printProducts() async {
    DatabaseService db = DatabaseService();

    DocumentSnapshot documentSnapshot = await db.getData('celanide@gmail.com');
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;

    print("Name: ${data['name']}");
  }

  Future<void> printProducts2() async {
    final user = FirebaseAuth.instance.currentUser;
    final userCollection = FirebaseFirestore.instance.collection('users');
    if (user != null) {
      final userDoc = userCollection.doc(user.uid);

      // Add the product data to the user's product list
      final products = await userDoc.collection('products').get();
      List<Product> lista = [];
      print(products.docs.map((e) {
        lista.add(Product(e.data()['name'], DateTime(2000)));
      }));
      setState(() {
        productList = lista;
      });
    }
  }

    Future<void> addItem() async {
      final user = FirebaseAuth.instance.currentUser;
      final userCollection = FirebaseFirestore.instance.collection('users');

      if (user != null) {
        final userDoc = userCollection.doc(user.uid);
        final productCollection =
            FirebaseFirestore.instance.collection('products');
        final productDoc = productCollection.doc('555555555');

        final productSnapshot = await productDoc.get();

        if (productSnapshot.exists) {
          final productData = productSnapshot.data();

          // Add the product data to the user's product list
          final products = await userDoc.collection('products').get();
          await userDoc.collection('products').add(productData!);
          print(products.docs.map((e) => e.data()));
        }
      }
    }

    Widget _addItem() {
      return ElevatedButton(
        onPressed: addItem,
        child: Text('Scan Barcode'),
      );
    }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 500,
          child: ListView.builder(
            itemCount: productList.length,
            itemBuilder: (context, index) {
              return Card(
                color: productList[index].selected ? Colors.green : null,
                child: ListTile(
                  title: Text(productList[index].name),
                  subtitle: Text(
                      "Expires on: ${productList[index].expiryDate.toLocal().toString().split(' ')[0]}"),
                  onTap: () {
                    setState(() {
                      productList[index].selected =
                          !productList[index].selected;
                    });
                  },
                ),
              );
            },
          ),
        ),
        ElevatedButton(
            onPressed: printProducts2, child: const Text("click me please")),
        _addItem(),
      ],
    );
  }
}
