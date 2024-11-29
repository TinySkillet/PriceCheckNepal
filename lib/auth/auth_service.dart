import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // instance of auth
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  // sign in with email password
  Future<UserCredential> signInWithEmailPassword(String email, password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw e;
    }
  }

  // sign in with google
  Future<UserCredential> signInWithGoogle() async {
    try {
      // start google sign-in flow
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        throw FirebaseAuthException(
          code: 'ERROR_ABORTED_BY_USER',
          message: "Sign-in aborted by user",
        );
      }

      // obtain authentication details
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // create a new credential
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // sign in with the credential
      UserCredential userCredential =
          await auth.signInWithCredential(credential);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw e;
    }
  }

  // sign out
  Future<void> signOut() async {
    await googleSignIn.signOut();
    return await auth.signOut();
  }

  // errors
}
