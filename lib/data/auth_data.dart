import 'package:firebase_auth/firebase_auth.dart';
import 'package:toody/data/user_data.dart';

abstract class AuthenticationDataSource {
  Future<void> signup(String fullname, String email, String password);
  Future<void> login(String email, String password);
}

class AuthenticationRemote extends AuthenticationDataSource {
  @override
  Future<void> login(String email, String password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(), password: password.trim());
  }

  @override
  Future<void> signup(String fullname, String email, String password) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: email.trim(), password: password.trim())
        .then((value) {
      FirestoreDatasource().createUser(fullname, email);
    });
  }
}
