import 'package:flutter/material.dart';

ListTile getDrawerTile(String title, IconData trailingIcon, Function onTap) {
  return ListTile(
    title: Text(
      title,
      style: TextStyle(color: Colors.white),
    ),
    trailing: Icon(
      trailingIcon,
      color: Colors.white,
    ),
    onTap: onTap,
  );
}
