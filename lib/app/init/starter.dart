import 'package:evreka_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

final class Starter {
  // Private constructor
  Starter._();

  static Future<void> start() async {
    WidgetsFlutterBinding.ensureInitialized();

    // Firebase initialization
    final currPlatform = DefaultFirebaseOptions.currentPlatform;
    await Firebase.initializeApp(options: currPlatform);
  }
}
