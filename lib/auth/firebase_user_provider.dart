import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class MessengerFirebaseUser {
  MessengerFirebaseUser(this.user);
  final User user;
  bool get loggedIn => user != null;
}

MessengerFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<MessengerFirebaseUser> messengerFirebaseUserStream() => FirebaseAuth
    .instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<MessengerFirebaseUser>(
        (user) => currentUser = MessengerFirebaseUser(user));
