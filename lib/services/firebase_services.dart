import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseServices {
  final _auth = FirebaseAuth.instance;
  final _googlesignIn = GoogleSignIn();

  // ignore: non_constant_identifier_names
  SignInwithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googlesignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken);
        await _auth.signInWithCredential(authCredential);
      }
    } on FirebaseAuthException catch (e) {
      throw e;
    }
  }

  signOut() async {
    await _auth.signOut();
    await _googlesignIn.signOut();
  }
}
