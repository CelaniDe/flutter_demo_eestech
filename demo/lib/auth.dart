import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;


  Future<void> createUserDocument() async {
  try {
    User? user = FirebaseAuth.instance.currentUser;
    
    if (user != null) {
      // Get the reference to the user document
      DocumentReference userDocRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
      
      // Create the user document
      await userDocRef.set({
        'uid': user.uid,
        'email': user.email,
        'createdAt': DateTime.now(),
        'coins': 0,
        // Add more fields as needed
      });
      
      print('User document created successfully!');
    } else {
      print('User is not authenticated.');
    }
  } catch (error) {
    print('Error creating user document: $error');
  }
}

  User? get currentUSer => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    await createUserDocument();
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
