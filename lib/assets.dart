
class Assets {
  Assets._();

  static final font = _AssetsFont._();
  static final image = _AssetsImage._();

}

class _AssetsFont {
  _AssetsFont._();


  final openSansBoldTTF = 'assets/font/OpenSans-Bold.ttf';
  final openSansExtraBoldTTF = 'assets/font/OpenSans-ExtraBold.ttf';
  final openSansRegularTTF = 'assets/font/OpenSans-Regular.ttf';
}

class _AssetsImage {
  _AssetsImage._();


  final imActivePinPNG = 'assets/image/im_active_pin.png';
  final imActivePinSVG = 'assets/image/im_active_pin.svg';
  final imClearSVG = 'assets/image/im_clear.svg';
  final imDefaultPinPNG = 'assets/image/im_default_pin.png';
  final imDefaultPinSVG = 'assets/image/im_default_pin.svg';
  final imErrorSVG = 'assets/image/im_error.svg';
  final imLogoPNG = 'assets/image/im_logo.png';
  final imLogoSVG = 'assets/image/im_logo.svg';
  final imPasswordHideSVG = 'assets/image/im_password_hide.svg';
}
