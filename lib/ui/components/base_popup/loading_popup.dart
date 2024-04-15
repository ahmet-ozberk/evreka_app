import 'package:evreka_app/app/constant/constants.dart';
import 'package:flutter/material.dart';

OverlayEntry? _loadingPopupEntry;
OverlayState _overlayState = Constants.navigatorKey.currentState!.overlay!;

class LoadingPopup extends StatelessWidget {
  const LoadingPopup({super.key});

  static void show() {
    if (_loadingPopupEntry != null) {
      _loadingPopupEntry!.remove();
      _loadingPopupEntry = null;
    }
    _loadingPopupEntry = OverlayEntry(
      builder: (context) => const LoadingPopup(),
    );
    _overlayState.insert(_loadingPopupEntry!);
  }

  static void hide() {
    if (_loadingPopupEntry != null) {
      _loadingPopupEntry!.remove();
      _loadingPopupEntry = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: false,
      child: SizedBox.expand(
        child: Material(
          color: Constants.color.shadowColor.withOpacity(0.5),
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
