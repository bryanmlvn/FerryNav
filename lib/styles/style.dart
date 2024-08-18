import 'package:flutter/material.dart';

Color appBarColor = const Color(0xFF06305A);
Color containerColor = const Color(0xFFd2fbf7);

TextStyle h1Style = const TextStyle(
  fontSize: 25.0,
  color: Colors.black,
  fontWeight: FontWeight.w800,
);
TextStyle h2Style = const TextStyle(
  fontSize: 18.0,
  color: Colors.white,
  fontWeight: FontWeight.w700,
);
TextStyle h2StyleB = const TextStyle(
  fontSize: 18.0,
  color: Colors.black,
  fontWeight: FontWeight.w700,
);
TextStyle h3Style = const TextStyle(
  fontSize: 15.0,
  color: Colors.black,
  fontWeight: FontWeight.w600,
);
TextStyle h4Style = const TextStyle(
  fontSize: 15.0,
  color: Colors.black,
  fontWeight: FontWeight.w500,
);
TextStyle desc1Style(Color color) {
  return TextStyle(
    fontSize: 14.0,
    color: color,
    fontWeight: FontWeight.w400,
  );
}

BoxDecoration commonBoxDecorationStyle(Color color) {
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(15.0),
  );
}
