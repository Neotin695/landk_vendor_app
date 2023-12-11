import 'package:firebase_auth/firebase_auth.dart';

extension CheckUser on User {
  bool isEmpty() {
    return email != null && uid.isEmpty;
  }
}
