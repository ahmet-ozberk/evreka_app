import 'package:evreka_app/app/init/connection_checker/connection_checker.dart';
import 'package:evreka_app/assets.dart';
import 'package:evreka_app/ui/components/base_popup/error_popup.dart';
import 'package:evreka_app/ui/views/auth/login/view/login_view.dart';
import 'package:evreka_app/ui/views/google_map/view/google_map_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  void connectionChecker() {
    ref.listen(internetConnectionProvider, (_, isConnection) {
      if (!isConnection) {
        ErrorPopup.show("You have no internet connection.");
      }
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      final user = FirebaseAuth.instance.currentUser;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => user == null ? const LoginView() : const GoogleMapView()),
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    connectionChecker();
    return Scaffold(
      body: Center(child: Image.asset(Assets.image.imLogoPNG)),
    );
  }
}
