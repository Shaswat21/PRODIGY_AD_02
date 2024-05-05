import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ThemeClass {
  Color lightBackgroundColor = HexColor('#fefefe');
  Color lightPrimaryColor = HexColor('#ffffff');
  Color borderColor = HexColor('f7f7f7');
  Color uncheckedColor = HexColor('#cccccc');
  Color checkedColor = HexColor('#7ad772');
  Color editColor = HexColor('#312b25');
  Color editBackColor = HexColor('#ffe4c3');
  Color delColor = HexColor('#ff7373');
  Color delBackColor = HexColor('#ffbaba');
  Color buttonBorderColor = HexColor('#ef9d30');
  Color buttonForegroundColor = HexColor('#884b00');
  Color buttonBackgroundColor = HexColor('#ffba5f');
  Color completedBorderColor = HexColor('#81d979');
  Color completedBackgroundColor = HexColor('#eeffec');
  Color closeIconBackground = HexColor('#6b6b6b');
  Color closeIcon = HexColor('#f3f3f3');

  //Light Theme
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: _themeClass.lightBackgroundColor,
    primaryColor: _themeClass.lightPrimaryColor,
    dividerColor: _themeClass.uncheckedColor,
    shadowColor: _themeClass.checkedColor,
    cardColor: _themeClass.editColor,
    canvasColor: _themeClass.buttonBorderColor,
    focusColor: _themeClass.completedBorderColor,
    disabledColor: _themeClass.completedBackgroundColor,
    highlightColor: _themeClass.closeIcon,
    indicatorColor: _themeClass.closeIconBackground,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: _themeClass.buttonBackgroundColor),
    dialogTheme: DialogTheme(
        backgroundColor: _themeClass.lightBackgroundColor,
        shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(45))),
    colorScheme: const ColorScheme.light().copyWith(
      error: _themeClass.delColor,
      errorContainer: _themeClass.delBackColor,
      background: _themeClass.editBackColor,
    ),
    cardTheme: CardTheme(
      color: _themeClass.lightPrimaryColor,
      elevation: 0,
    ),
    textTheme: TextTheme(
        labelSmall: TextStyle(color: _themeClass.closeIconBackground, fontSize: 20),
        titleLarge: const TextStyle(
            color: Colors.black, fontSize: 25, fontWeight: FontWeight.w500),
        titleMedium: const TextStyle(color: Colors.black, fontSize: 21),
        labelMedium:
            TextStyle(color: _themeClass.buttonForegroundColor, fontSize: 23)),
  );

  //Dark Theme
  static ThemeData darkTheme = ThemeData();
}

ThemeClass _themeClass = ThemeClass();
