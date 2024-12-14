import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // instances
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  void createUserDocForFirstTime(UserCredential userCredential) {
    // store in users doc, later we add more fields to it
    firestore.collection("Users").doc(userCredential.user!.uid).set(
      {
        'uid': userCredential.user!.uid,
        'email': userCredential.user!.email,
      },
      SetOptions(merge: true),
    );
  }

  // sign in with email password
  Future<UserCredential> signInWithEmailPassword(String email, password) async {
    try {
      // create user
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential;
    } on FirebaseAuthException {
      rethrow;
    }
  }

  // sign in with google
  Future<UserCredential> signInWithGoogle() async {
    try {
      // start google sign-in flow
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        throw FirebaseAuthException(
          code: 'Aborted',
          message: "Sign-in aborted by user",
        );
      }

      // obtain authentication details
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // create new credential
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // sign in with the credential
      UserCredential userCredential =
          await auth.signInWithCredential(credential);
      createUserDocForFirstTime(userCredential);
      return userCredential;
    } on FirebaseAuthException {
      rethrow;
    }
  }

  // register
  Future<UserCredential> register(String email, password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      createUserDocForFirstTime(userCredential);
      return userCredential;
    } on FirebaseAuthException {
      rethrow;
    }
  }

  // send password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException {
      rethrow;
    }
  }

  // sign out
  Future<void> signOut() async {
    await googleSignIn.signOut();
    return await auth.signOut();
  }
}
