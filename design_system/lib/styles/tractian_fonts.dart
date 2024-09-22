import 'package:design_system/styles/tractian_lineheight.dart';
import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';

const _robotoMedium = 'Roboto-Medium';
const _robotoRegular = 'Roboto-Regular';

class TractianFonts {
  final TextStyle Function(Color color) customColor;
  TractianFonts(this.customColor);

  TextStyle defaultStyle() => customColor(TractianColors.black50);
}

final TractianFonts mediumLg =
    TractianFonts(
      (color) {
        return TextStyle(
          color: color,
          fontSize: 18,
          fontFamily: _robotoMedium,
          fontWeight: FontWeight.w500,
          height: TractianLineheight.lineHeight28,
        );
      },
    );

final TractianFonts regularLg = TractianFonts(
  (color) {
    return TextStyle(
      color: color,
      fontSize: 18,
      fontFamily: _robotoRegular,
      fontWeight: FontWeight.w400,
    );
  },
);

final TractianFonts mediumSm = TractianFonts(
  (color) {
    return TextStyle(
      color: color,
      fontSize: 14,
      fontFamily: _robotoMedium,
      fontWeight: FontWeight.w500,
    );
  },
);

final TractianFonts regularSm =
    TractianFonts(
      (color) {
        return TextStyle(
          color: color,
          fontSize: 14,
          fontFamily: _robotoRegular,
          fontWeight: FontWeight.w400,
        );
      },
    );
