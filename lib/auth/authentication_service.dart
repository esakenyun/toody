import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toastr/flutter_toastr.dart';

class AuthenticationService {
  Future<void> signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      if (!context.mounted) return;
      Navigator.of(context).popUntil((route) => route.isFirst);
    } catch (e) {
      FlutterToastr.show(
        '$e',
        context,
        position: FlutterToastr.bottom,
        duration: FlutterToastr.lengthLong,
      );
    }
  }
}
