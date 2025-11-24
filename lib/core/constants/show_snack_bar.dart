import 'package:flutter/material.dart';

abstract class ShowSnackBar {
   static ShowSnackBarMessage(context,String content) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(
      backgroundColor: Colors.green,
      content: Text(content)));
  }
   static ShowSnackBarErrMessage(context,String content) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      content: Text(content)));
  }
}