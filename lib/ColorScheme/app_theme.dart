import 'package:flutter/material.dart';

ThemeData blinkitTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,

  // Primary Blinkit colors
  primaryColor: const Color(0xFF00A862), // Blinkit Green
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF00A862), // Green
    onPrimary: Colors.white,
    secondary: Color(0xFFE5F85C), // Yellow-green highlight
    onSecondary: Colors.black,
    background: Colors.white,
    onBackground: Color(0xFF2B2B2B),
    surface: Colors.white, // Cards
    onSurface: Color(0xFF2B2B2B),
    error: Colors.red,
    onError: Colors.white,
  ),

  // AppBar
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 1,
    centerTitle: true,
    titleTextStyle: TextStyle(
      color: Color(0xFF2B2B2B),
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(color: Color(0xFF2B2B2B)),
  ),

  // Text Theme (Modern + Clean)
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      color: Color(0xFF2B2B2B),
      fontWeight: FontWeight.bold,
    ),
    headlineMedium: TextStyle(
      color: Color(0xFF2B2B2B),
      fontWeight: FontWeight.w600,
    ),
    bodyLarge: TextStyle(color: Color(0xFF2B2B2B), fontSize: 16),
    bodyMedium: TextStyle(color: Color(0xFF6E6E6E), fontSize: 14),
    labelLarge: TextStyle(
      color: Color(0xFF00A862),
      fontWeight: FontWeight.bold,
    ),
  ),

  // Buttons (Primary CTA)
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF00A862), // Blinkit Green
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
  ),

  // Bottom Navigation
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: Color(0xFF00A862), // Green active
    unselectedItemColor: Color(0xFF6E6E6E),
    type: BottomNavigationBarType.fixed,
    showSelectedLabels: true,
    showUnselectedLabels: true,
    elevation: 8,
  ),

  // Chips (Category buttons)
  chipTheme: ChipThemeData(
    backgroundColor: Colors.white,
    selectedColor: const Color(0xFF00A862),
    labelStyle: const TextStyle(color: Color(0xFF2B2B2B)),
    secondaryLabelStyle: const TextStyle(color: Colors.white),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
  ),

  // Search Bar Style
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFFF6F6F6), // Light gray for contrast
    contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide.none,
    ),
    hintStyle: const TextStyle(color: Color(0xFF6E6E6E)),
  ),
);
