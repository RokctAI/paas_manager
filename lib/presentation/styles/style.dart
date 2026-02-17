import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class Style {
  Style._();

  /// colors
  static const primary = Color(0xFF83EA00);
  static const white = Color(0xFFFFFFFF);
  static const hintColor = Color(0xFFA7A7A7);
  static const black = Color(0xFF232B2F);
  static const blue = Color(0xFF03758E);
  static const green = Color(0xFF16AA16);
  static const red = Color(0xFFFF3D00);
  static const starColor = Color(0xFFFFA100);
  static const textGrey = Color(0xFF898989);
  static const bgColor = Color(0xFFFFF2EE);
  static const greyColor = Color(0xFFF4F5F8);
  static const iconsColor = Color(0xFF232B2F);
  static const textColor = Color(0xFF898989);
  static const blackColor = Color(0xFF000000);
  static const transparent = Colors.transparent;
  static const differBorderColor = Color(0xFFE0E0E0);
  static const bottomNavigationBarColor = Color(0xFF191919);
  static const bgGrey = Color(0xFFF4F5F8);
  static const dragElement = Color(0xFFC4C5C7);
  static const bottomSheetIconColor = Color(0xFFC4C5C7);
  static const iconColor = Color(0xFFC4C4C4);
  static const shimmerBase = Color(0xFFE0E0E0);
  static const shimmerHighlight = Color(0xFFF5F5F5);
  static const tabBarBorderColor = Color(0xFFDEDFE1);
  static const toggleColor = Color(0xFFE7E7E7);
  static const toggleShadowColor = Color(0xFF6B6B6B);
  static const logOutBgColor = Color(0xFFB9B9B9);
  static const borderColor = Color(0xFFF2F2F2);
  static const addCountColor = Color(0xFFF7F7F7);
  static const discountColor = Color(0xFFF3F3F3);
  static const pending = Color(0xFFFEFAF2);
  static const pendingDark = Color(0xFFF19204);
  static const iconButtonBack = Color(0xFFE9E9E6);

  static List<Color> primaryGradient = [
    Style.primary.withOpacity(0.5),
    Style.transparent,
  ];

  /// ################# Fonts #######################

  static interBold({
    double size = 18,
    Color color = Style.blackColor,
    double letterSpacing = 0,
  }) =>
      GoogleFonts.inter(
        fontSize: size,
        fontWeight: FontWeight.bold,
        color: color,
        decoration: TextDecoration.none,
        letterSpacing: letterSpacing,
      );

  static interSemi({
    double size = 18,
    Color color = Style.blackColor,
    TextDecoration decoration = TextDecoration.none,
    double letterSpacing = 0,
    FontStyle? fontStyle,
  }) =>
      GoogleFonts.inter(
        fontSize: size,
        fontWeight: FontWeight.w700,
        color: color,
        letterSpacing: letterSpacing,
        decoration: decoration,
        fontStyle: fontStyle,
      );

  static interNormal({
    double size = 16,
    Color color = Style.blackColor,
    double letterSpacing = 0,
    TextDecoration textDecoration = TextDecoration.none,
    FontStyle? fontStyle,
  }) =>
      GoogleFonts.inter(
        fontSize: size,
        fontWeight: FontWeight.w500,
        color: color,
        letterSpacing: letterSpacing,
        decoration: textDecoration,
        fontStyle: fontStyle,
      );

  static interRegular({
    double size = 16,
    Color color = Style.blackColor,
    double letterSpacing = 0,
    TextDecoration textDecoration = TextDecoration.none,
    FontStyle? fontStyle,
  }) =>
      GoogleFonts.inter(
        fontSize: size,
        fontWeight: FontWeight.w400,
        color: color,
        letterSpacing: letterSpacing,
        decoration: textDecoration,
        fontStyle: fontStyle,
      );
}
