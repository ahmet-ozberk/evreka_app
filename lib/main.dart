import 'package:evreka_app/app/init/starter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async{
  await Starter.start();
  runApp(const ProviderScope(child: EvrekaApp()));
}

class EvrekaApp extends StatelessWidget {
  const EvrekaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: kDebugMode,
      
    );
  }
}