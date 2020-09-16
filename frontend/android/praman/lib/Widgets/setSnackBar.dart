import 'package:flutter/material.dart';

SnackBar setSnackBar(String content, {SnackBarAction action}) {
  return SnackBar(
    content: Text(content),
    duration: Duration(seconds: 1),
    action: action != null ? action : null,
  );
}
