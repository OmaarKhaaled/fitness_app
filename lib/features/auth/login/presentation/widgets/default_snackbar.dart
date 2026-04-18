import 'package:flutter/material.dart';

SnackBar defaultSnackBar({required String message, required Color color}) {
  return SnackBar(content: Text(message), backgroundColor: color);
}
