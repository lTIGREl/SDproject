import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Usuario {
  static var user;

  static FirebaseAuth _auth = FirebaseAuth.instance;
  static FirebaseUser _user;

  static GoogleSignIn _googleSignIn = new GoogleSignIn();

  static Future<void> handleSignIn() async {
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    AuthResult result = (await _auth.signInWithCredential(credential));

    _user = result.user;
    Usuario.user = _user;
  }

  static Future<void> gooleSignout() async {
    await _auth.signOut().then((onValue) {
      _googleSignIn.signOut();
    });
  }

  static getUserState() {
    if (user == null) {
      return false;
    } else {
      return true;
    }
  }
}
