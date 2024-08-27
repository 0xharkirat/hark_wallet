import 'package:flutter/material.dart';
import 'package:hark_wallet/src/core/constants/colors.dart';


SnackBar createSnackBar(String message, IconData icon, bool isError) {
  return SnackBar(
    content: ListTile(
      contentPadding: const EdgeInsets.all(0),
      title: Text(message),
      leading:  Icon(icon, color: isError ? kErrorColor: null),
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
