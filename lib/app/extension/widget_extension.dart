import 'package:flutter/material.dart';

extension ListWidgetExtension on List<Widget> {
  List<Widget> seperator(Widget seperator) {
    final list = <Widget>[];
    for (var i = 0; i < length; i++) {
      list.add(this[i]);
      if (i != length - 1) {
        list.add(seperator);
      }
    }
    return list;
  }
}

extension WidgetExtension on Widget {
  Widget get red => ColoredBox(color: Colors.red, child: this);
  Widget get green => ColoredBox(color: Colors.green, child: this);
  Widget get expanded => Expanded(child: this);

  Widget opaque({double opacity = 0.5}) => Opacity(opacity: opacity, child: this);
}