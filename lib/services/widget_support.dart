import 'package:flutter/material.dart';

class AppWidget {
  static TextStyle headlinetextStyle(double size) {
    return TextStyle(
      color: Colors.black,
      fontSize: size,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle normaltextStyle(double size) {
    return TextStyle(
      color: Colors.black,
      fontSize: size,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle whitetextStyle(double size) {
    return TextStyle(
      color: Colors.white,
      fontSize: size,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle greentextStyle(double size) {
    return TextStyle(
      color: Colors.green,
      fontSize: size,
      fontWeight: FontWeight.bold,
    );
  }
}
