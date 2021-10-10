import 'dart:math';

import 'package:flutter/material.dart';

int gToMmi(double g) {
  if (g <= 0.0007) {
    return 1;
  } else if (g < 0.0023) {
    return 2;
  } else if (g < 0.0076) {
    return 3;
  } else if (g < 0.0256) {
    return 4;
  } else if (g < 0.0686) {
    return 5;
  } else if (g < 0.1473) {
    return 6;
  } else if (g < 0.3166) {
    return 7;
  } else if (g < 0.6801) {
    return 8;
  } else if (g < 1.4614) {
    return 9;
  } else if (g < 3.14) {
    return 10;
  } else {
    return 11;
  }
}

String mmiToSymbol(int mmi) {
  if (mmi <= 1) {
    return "I";
  } else if (mmi == 2) {
    return "II";
  } else if (mmi == 3) {
    return "III";
  } else if (mmi == 4) {
    return "IV";
  } else if (mmi == 5) {
    return "V";
  } else if (mmi == 6) {
    return "VI";
  } else if (mmi == 7) {
    return "VII";
  } else if (mmi == 8) {
    return "VIII";
  } else if (mmi == 9) {
    return "IX";
  } else if (mmi == 10) {
    return "X";
  } else {
    return "X+";
  }
}

Color mmiToBgColor(int mmi) {
  if (mmi <= 1) {
    return const Color(0xFFFFFFFF);
  } else if (mmi == 2) {
    return const Color(0xFFA0E6FF);
  } else if (mmi == 3) {
    return const Color(0xFF92D050);
  } else if (mmi == 4) {
    return const Color(0xFFFFFF00);
  } else if (mmi == 5) {
    return const Color(0xFFFFC000);
  } else if (mmi == 6) {
    return const Color(0xFFFF0000);
  } else if (mmi == 7) {
    return const Color(0xFFA32777);
  } else if (mmi == 8) {
    return const Color(0xFF632523);
  } else if (mmi == 9) {
    return const Color(0xFF4C2600);
  } else {
    return const Color(0xFF000000);
  }
}

Color mmiToFgColor(int mmi) {
  if (mmi >= 6) {
    return Colors.white;
  } else {
    return Colors.black;
  }
}

double gToJma(double g) {
  return 2 * log(g * 980.665) / ln10 + 0.7;
}

String jmaToSymbol(double jma) {
  if (jma < 0.5) {
    return "0";
  } else if (jma < 1.5) {
    return "1";
  } else if (jma < 2.5) {
    return "2";
  } else if (jma < 3.5) {
    return "3";
  } else if (jma < 4.5) {
    return "4";
  } else if (jma < 5.0) {
    return "5-";
  } else if (jma < 5.5) {
    return "5+";
  } else if (jma < 6.0) {
    return "6-";
  } else if (jma < 6.5) {
    return "6+";
  } else {
    return "7";
  }
}

Color jmaToBgColor(double jma) {
  if (jma < 0.5) {
    return const Color(0xFFFFFFFF);
  } else if (jma < 1.5) {
    return const Color(0xFF51B3FC);
  } else if (jma < 2.5) {
    return const Color(0xFF81D25A);
  } else if (jma < 3.5) {
    return const Color(0xFFF0DC7B);
  } else if (jma < 4.5) {
    return const Color(0xFFF57B43);
  } else if (jma < 5.5) {
    return const Color(0xFFAD1121);
  } else if (jma < 6.5) {
    return const Color(0xFFFECADA);
  } else {
    return const Color(0xFFAD1121);
  }
}

Color jmaToFgColor(double jma) {
  if (jma < 4.5) {
    return Colors.black;
  } else if (jma < 5.5) {
    return Colors.white;
  } else if (jma < 6.5) {
    return const Color(0xFFA01C2F);
  } else {
    return Colors.yellow;
  }
}
