import 'package:evreka_app/app/constant/characters.dart';
import 'package:evreka_app/app/constant/constants.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  const AppButton({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    const buttonSize = Size(304, 43);
    return Opacity(
      opacity: onPressed == null ? 0.3 : 1,
      child: Container(
        width: buttonSize.width,
        height: buttonSize.height,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Constants.color.shadowGreen,
              offset: const Offset(0, 5),
              blurRadius: 15,
            ),
          ],
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            disabledBackgroundColor: Constants.color.green,
            shadowColor: Colors.transparent,
            backgroundColor: Constants.color.green,
            padding: const EdgeInsets.symmetric(vertical: 8),
            fixedSize: buttonSize,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          onPressed: onPressed,
          child: Text(text, style: CharacterStyles.buttonText),
        ),
      ),
    );
  }
}
