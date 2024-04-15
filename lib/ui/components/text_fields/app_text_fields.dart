import 'package:evreka_app/app/constant/characters.dart';
import 'package:evreka_app/app/constant/constants.dart';
import 'package:evreka_app/app/extension/num_extension.dart';
import 'package:evreka_app/app/extension/widget_extension.dart';
import 'package:evreka_app/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String label;
  final bool? Function(String?)? validator;
  final bool obscureText;
  final TextInputType keyboardType;
  final bool readOnly;
  final bool enabled;

  const AppTextField({
    super.key,
    this.controller,
    required this.label,
    this.validator,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.readOnly = false,
    this.enabled = true,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  final textController = TextEditingController();
  bool isValidate = false;
  bool isHide = false;
  bool isFocus = false;
  final focusNode = FocusNode();

  void hasFocus() {
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          isFocus = true;
        });
      } else {
        setState(() {
          isFocus = false;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    hasFocus();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 46.5,
      child: TextFormField(
        cursorWidth: 1,
        cursorHeight: 20,
        focusNode: focusNode,
        controller: widget.controller ?? textController,
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText ? !isHide : false,
        obscuringCharacter: Constants.string.obscureCharacter,
        readOnly: widget.readOnly,
        enabled: widget.enabled,
        onChanged: (value) {
          if (widget.validator != null) {
            setState(() {
              widget.validator!(value) == true
                  ? isValidate = true
                  : isValidate = false;
            });
          }
        },
        style: CharacterStyles.t1.copyWith(color: isError),
        cursorColor: Constants.color.darkGrey,
        decoration: InputDecoration(
          label: Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: Text(widget.label),
          ),
          labelStyle:
              CharacterStyles.inputboxLabelDeactive.copyWith(color: isError),
          contentPadding: const EdgeInsets.only(bottom: 6.5, top: 1),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Constants.color.shadowColor.validate(isValidate),
              width: 1,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Constants.color.yellow.validate(isValidate),
              width: 2,
            ),
          ),
          suffix: suffix,
        ),
      ),
    );
  }

  Color? get isError => isValidate ? Constants.color.errorColor : null;

  Widget? get suffix {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isFocus) clearButton(),
        if (widget.obscureText) hideButton(),
        if (isValidate) errorIcon(),
      ].seperator(4.width),
    );
  }

  Widget hideButton() {
    return InkWell(
      onTap: () {
        setState(() {
          isHide = !isHide;
        });
      },
      child: SvgPicture.asset(
        Assets.image.imPasswordHideSVG,
        width: 24.75,
        height: 16.5,
        colorFilter: ColorFilter.mode(
          isHide ? Constants.color.yellow : Constants.color.shadowColor,
          BlendMode.srcIn,
        ),
      ),
    );
  }

  Widget errorIcon() {
    return SvgPicture.asset(
      Assets.image.imErrorSVG,
      width: 26,
      height: 23.22,
      colorFilter: ColorFilter.mode(
        Constants.color.errorColor,
        BlendMode.srcIn,
      ),
    );
  }

  Widget clearButton() {
    return InkWell(
      onTap: () {
        widget.controller?.clear();
        textController.clear();
      },
      child: SvgPicture.asset(
        Assets.image.imClearSVG,
        width: 22.88,
        height: 22.88,
        colorFilter: ColorFilter.mode(
          Constants.color.shadowColor,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}

extension ColorExtension on Color {
  Color validate(bool isValidate) =>
      isValidate ? Constants.color.errorColor : this;
}
