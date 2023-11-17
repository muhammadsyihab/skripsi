import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class AnekaFirebaseUser {
  AnekaFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

AnekaFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<AnekaFirebaseUser> anekaFirebaseUserStream() => FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<AnekaFirebaseUser>(
      (user) {
        currentUser = AnekaFirebaseUser(user);
        return currentUser!;
      },
    );
