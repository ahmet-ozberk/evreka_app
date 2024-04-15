import 'package:evreka_app/app/constant/constants.dart';
import 'package:evreka_app/app/init/starter/starter.dart';
import 'package:evreka_app/ui/views/splash/view/splash_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  await Starter.start();
  runApp(const ProviderScope(child: EvrekaApp()));
}

class EvrekaApp extends StatelessWidget {
  const EvrekaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MaterialApp(
        debugShowCheckedModeBanner: kDebugMode,
        navigatorKey: Constants.navigatorKey,
        title: Constants.string.appName,
        theme: ThemeData(
          fontFamily: "OpenSans",
          scaffoldBackgroundColor: Constants.color.scaffoldBackgroundColor,
        ),
        home: const SplashView(),
      ),
    );
  }
}
