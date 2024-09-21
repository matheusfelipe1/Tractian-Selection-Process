import 'dart:ui';
import 'package:design_system/design_system.dart';

const _robotoMedium = 'Roboto-Medium';
const _robotoRegular = 'Roboto-Regular';

class TractianFonts {
  final TextStyle Function(Color color) customColor;
  TractianFonts(this.customColor);

  TextStyle defaultStyle() => customColor(TractianColors.black50);
}

TractianFonts mediumLg({
  required Color color,
}) =>
    TractianFonts(
      (color) {
        return TextStyle(
          color: color,
          fontSize: 18,
          fontFamily: _robotoMedium,
          fontWeight: FontWeight.w500,
        );
      },
    );

TractianFonts regularLg({
  required Color color,
}) =>
    TractianFonts(
      (color) {
        return TextStyle(
          color: color,
          fontSize: 18,
          fontFamily: _robotoRegular,
          fontWeight: FontWeight.w400,
        );
      },
    );

TractianFonts mediumSm({
  required Color color,
}) =>
    TractianFonts(
      (color) {
        return TextStyle(
          color: color,
          fontSize: 14,
          fontFamily: _robotoMedium,
          fontWeight: FontWeight.w500,
        );
      },
    );

TractianFonts regularSm({
  required Color color,
}) =>
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
