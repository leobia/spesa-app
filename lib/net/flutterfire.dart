import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<bool> signIn(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

Future<bool> register(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The passowrd provided is too weak');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exist for that email.');
    }
    return false;
  } catch (e) {
    print(e);
    return false;
  }
}

Future<bool> signInOrRegister(String email, String password) async {
  try {
    var emailInfos =
        await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
    if (emailInfos.isEmpty) {
      print('Register new user $email');
      return await register(email, password);
    } else {
      print('Login user $email');
      return await signIn(email, password);
    }
  } catch (e) {
    print(e);
    return false;
  }
}

Future<bool> signInWithGoogle() async {
  // Trigger the authentication flow
  try {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}
