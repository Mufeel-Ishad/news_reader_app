import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthFailure implements Exception {
  const AuthFailure(this.message);

  final String message;

  @override
  String toString() => message;
}

class FirebaseService {
  FirebaseService._({FirebaseAuth? auth})
    : _auth = auth ?? FirebaseAuth.instance;

  static final FirebaseService instance = FirebaseService._();

  final FirebaseAuth _auth;

  Future<void> initialize() async {
    await Firebase.initializeApp();
  }

  Stream<bool> authStateChanges() {
    return _auth.authStateChanges().map((user) => user != null);
  }

  Future<void> signIn({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw AuthFailure(e.message ?? 'Sign in failed');
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
    String? displayName,
  }) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final safeDisplayName = displayName?.trim();
      if (safeDisplayName != null && safeDisplayName.isNotEmpty) {
        await cred.user?.updateDisplayName(safeDisplayName);
      }
    } on FirebaseAuthException catch (e) {
      throw AuthFailure(e.message ?? 'Sign up failed');
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw AuthFailure(e.message ?? 'Reset failed');
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      throw AuthFailure(e.message ?? 'Sign out failed');
    }
  }
}
