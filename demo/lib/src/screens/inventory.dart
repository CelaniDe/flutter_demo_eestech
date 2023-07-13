import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class inventory extends StatefulWidget {
  const inventory({Key? key}) : super(key: key);

  @override
  State<inventory> createState() => _inventoryState();
}

class _inventoryState extends State<inventory> {

  final User? user = Auth().currentUSer;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Future<void> addItem() async {
    final user = FirebaseAuth.instance.currentUser;
    final userCollection = FirebaseFirestore.instance.collection('users');

    if (user != null) {

      final userDoc = userCollection.doc(user.uid);
      final productCollection = FirebaseFirestore.instance.collection('products');
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

  Widget _addItem() {

      return 
        ElevatedButton(
          onPressed: addItem,
          child: Text('Scan Barcode'),
        );
    }
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[            
            ElevatedButton(
              onPressed: addItem,
              child: Text('add item'),
            ),],

        )
      );

    }
  }