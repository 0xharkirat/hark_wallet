import 'package:flutter/material.dart';

SnackBar createSnackBar(String message) {
  return SnackBar(
    content: ListTile(
      contentPadding: const EdgeInsets.all(0),
      title: Text(message),
      leading: const Icon(Icons.check_circle_outline_outlined),
    ),
    backgroundColor: Colors.black,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      side: BorderSide(color: Colors.white24),
    ),
    behavior: SnackBarBehavior.floating,
    width: 300,
    showCloseIcon: true,
    closeIconColor: Colors.white,
  );
}
