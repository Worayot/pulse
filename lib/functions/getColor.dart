import 'package:flutter/material.dart';

Color getColor(int value) {
  if (value <= 1) {
    return Color(0xffC5F8C8);
  } else if (value > 1 && value <= 2) {
    return Color(0xffFAF096);
  } else if (value > 2 && value <= 3) {
    return Color(0xffFCCB8F);
  } else if (value > 3 && value <= 4) {
    return Color(0xffFFBF78);
  } else {
    return Color(0xffF9989F);
  }
}
