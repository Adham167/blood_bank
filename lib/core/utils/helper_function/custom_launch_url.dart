// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// Future <void> customLaunchUrl(context,String url ) async {
//   final Uri _url = Uri.parse(url);
//
//   if (await canLaunchUrl(_url)) {
//     await launchUrl(_url);
//   }
//   else {
//    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Could not launch $url')));
//   }
//
// }