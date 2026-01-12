import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AuthRepository({FirebaseAuth? firebaseAuth})
    : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);

      return userCredential.user;
    } on FirebaseException catch (e) {
      throw e.message ?? 'Authentication Error!';
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Stream<User?> get authState => _firebaseAuth.authStateChanges();

  Future<User?> register(String username, String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'email': email,
        'username':username,
        'createdAt': FieldValue.serverTimestamp(),
        'role': 'user',
      });

      return userCredential.user;
      
    } on FirebaseException catch (e) {
      throw e.message ?? 'Register authentication Error!';
    }
  }
}