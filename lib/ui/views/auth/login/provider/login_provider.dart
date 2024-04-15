import 'package:evreka_app/ui/components/base_popup/error_popup.dart';
import 'package:evreka_app/ui/components/base_popup/loading_popup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginProvider = ChangeNotifierProvider((ref) => LoginProvider());

class LoginProvider extends ChangeNotifier {
  final _emailController = TextEditingController(text: "test2@test.com");
  final _passwordController = TextEditingController(text: "123456789");

  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> login() async {
    try {
      LoadingPopup.show();
      await _auth.signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
      LoadingPopup.hide();
      return true;
    } catch (e) {
      if (e.runtimeType == FirebaseAuthException) {
        e as FirebaseAuthException;
        LoadingPopup.hide();
        ErrorPopup.show(e.message!);
      } else {
        LoadingPopup.hide();
        ErrorPopup.show(e.toString());
      }
      return false;
    }
  }
}
