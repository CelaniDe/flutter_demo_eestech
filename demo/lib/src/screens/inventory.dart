import 'package:demo/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

  List<Product> productList = [
    Product('Product 1', DateTime.now().add(Duration(days: 1))),
    Product('Product 2', DateTime.now().add(Duration(days: 5))),
    Product('Product 3', DateTime.now().add(Duration(days: 10))),
    // Add more products here
  ];

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Widget _signOutButton() {
    return ElevatedButton(onPressed: signOut, child: const Text('Sign out'));
  }

  Widget _userUid() {
    return Text(user?.email ?? 'User email');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  productList[index].selected = !productList[index].selected;
                });
              },
            ),
          );
        },
      ),
    );
  }
}
