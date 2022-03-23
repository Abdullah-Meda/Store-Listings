import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const String kAppName = 'Ѕтσяє Lɪꜱᴛɪиɢѕ';
const Color kAppColor = Colors.amber;

const colors = [
  Color(0xffFDE2E6),
  Color(0xffFCF7DE),
  Color(0xffDEFDE0),
  Color(0xffDEF3FD),
  Color(0xffF0DEFD),
  // Color(0xff92db6e),
  // Color(0xff73b8e5),
  // Color(0xfffd7590),
  // Color(0xffc78ae5),
];

final TextStyle kDarkLabelTextStyle = GoogleFonts.dmSans(
  fontSize: 20,
  fontWeight: FontWeight.w500,
  fontStyle: FontStyle.normal,
);

final TextStyle kLightLabelTextStyle = GoogleFonts.dmSans(
  fontSize: 15,
  color: Colors.black38,
  fontWeight: FontWeight.w500,
  fontStyle: FontStyle.normal,
);

Color createRandomColor() {
  return Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
}
