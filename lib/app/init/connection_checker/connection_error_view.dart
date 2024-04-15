import 'package:flutter/material.dart';



class ConnectionErrorView extends StatelessWidget {
  const ConnectionErrorView({super.key});

  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const ConnectionErrorView(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
