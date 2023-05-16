import 'package:flutter/material.dart';

class StyledBoxShadow {
  static BoxShadow build() {
    return BoxShadow(
      color: Colors.grey.withOpacity(0.3),
      spreadRadius: 0,
      blurRadius: 4,
      offset: const Offset(0, 5), // changes position of shadow
    );
  }
}
