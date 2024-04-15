import 'package:evreka_app/app/constant/characters.dart';
import 'package:evreka_app/app/constant/constants.dart';
import 'package:evreka_app/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

OverlayEntry? _errorPopupEntry;
OverlayState _overlayState = Constants.navigatorKey.currentState!.overlay!;

class ErrorPopup extends StatefulWidget {
  final String text;
  const ErrorPopup({super.key, required this.text});

  static void show(String text) {
    if (_errorPopupEntry != null) {
      _errorPopupEntry!.remove();
      _errorPopupEntry = null;
    }
    _errorPopupEntry = OverlayEntry(
      builder: (context) => ErrorPopup(text: text),
    );
    _overlayState.insert(_errorPopupEntry!);
    Future.delayed(const Duration(seconds: 3), () {
      if (_errorPopupEntry != null) {
        _errorPopupEntry!.remove();
        _errorPopupEntry = null;
      }
    });
  }

  @override
  State<ErrorPopup> createState() => _ErrorPopupState();
}

class _ErrorPopupState extends State<ErrorPopup>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  late Animation<Offset> _animation;

  Future<void> _initAnimation() async {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      reverseDuration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _animation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: const Offset(0, -1),
    ).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: Curves.easeOut,
      ),
    );
    _controller?.forward();
    await Future.delayed(const Duration(seconds: 3), () {
      if (_errorPopupEntry != null) {
        _controller?.reverse();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _initAnimation();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 24,
      right: 24,
      child: SlideTransition(
        position: _animation,
        child: Container(
          width: 336,
          padding: const EdgeInsets.fromLTRB(25, 24, 25, 16),
          constraints: const BoxConstraints(minHeight: 94),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color(0XFFFBFCFF),
            boxShadow: const [
              BoxShadow(
                color: Color(0XFFBBBBBB),
                offset: Offset(0, 0),
                blurRadius: 10,
              ),
            ],
          ),
          child: Material(
            type: MaterialType.transparency,
            child: Row(
              children: [
                SvgPicture.asset(
                  Assets.image.imErrorSVG,
                  colorFilter: ColorFilter.mode(
                    Constants.color.errorColor,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    widget.text,
                    style: CharacterStyles.t1,
                    maxLines: 3,
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
