import 'package:flutter/material.dart';

// Light Theme
ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  primaryColor: const Color(0xFF535B5D), // Primary color for the app
  scaffoldBackgroundColor: const Color(0xFFCDCDCD), // Background for scaffold
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF535B5D), // Primary color for app bar
    iconTheme: IconThemeData(color: Colors.white), // AppBar icon color
  ),
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF535B5D), // Primary color
    onPrimary: Colors.white, // Text color on primary
    secondary: Color(0xFFD9D9D9), // Secondary color
    onSecondary: Color(0xFFAEA884), // Text color on secondary
    surface: Color(0xFFF5F5F5), // Surface color
    onSurface: Colors.black, // Text color on surface
    error: Color(0xFFD32F2F), // Error color
    onError: Colors.white, // Text color on error
  ),
  textTheme: const TextTheme(
    displayMedium: TextStyle(
        color: Color(0xFF0C4160), fontSize: 16.0), // Default body text
    displaySmall:
        TextStyle(color: Color(0xFF0C4160), fontSize: 14.0), // Secondary text
    displayLarge: TextStyle(
        color: Color(0xFF0C4160),
        fontSize: 20.0,
        fontWeight: FontWeight.w600), // Header text
  ),
  buttonTheme: ButtonThemeData(
    textTheme: ButtonTextTheme.primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30), // Rounded button edges
    ),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFFCDCDCD),
      secondary: Color(0xFF0C4160),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: const WidgetStatePropertyAll(
          Color(0xFFCDCDCD)), // Elevated button color
      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      )),
      textStyle: const WidgetStatePropertyAll(
        TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
      padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(vertical: 12, horizontal: 24)),
    ),
  ),
  iconTheme:
      const IconThemeData(color: Color(0xFF0C4160)), // Default icon color
  cardTheme: CardTheme(
    color: const Color(0xFFD9D9D9), // Card background color
    shadowColor: Color.fromARGB(num.parse((255 * 0.25).toString()).toInt(), 0,
        0, 0), // Shadow color for cards
    elevation: 5, // Elevation for shadow effect
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16), // Rounded card edges
    ),
  ),
  tabBarTheme: const TabBarTheme(
    indicatorColor: Color(0xFF0C4160),
    dividerColor: Color(0xFFCDCDCD),
    dividerHeight: 1,
  ),
);

// Dark Theme
ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  primaryColor: const Color(0xFF141927), // Primary color for the app
  scaffoldBackgroundColor:
      const Color(0xFF141927), // Dark background for scaffold
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF141927), // Dark primary color for app bar
    iconTheme: IconThemeData(color: Colors.white), // AppBar icon color
  ),
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFF141927), // Dark primary color
    onPrimary: Color(0xFF206088), // Text color on primary
    secondary: Color(0xFF1B2336), // Secondary color
    onSecondary: Colors.white, // Text color on secondary
    surface: Color(0xFF1C1C1C), // Surface color
    onSurface: Colors.white, // Text color on surface
    error: Color(0xFFD32F2F), // Error color
    onError: Colors.white, // Text color on error
  ),
  textTheme: const TextTheme(
    displayMedium: TextStyle(
        color: Color(0xFFFFFFFF), fontSize: 16.0), // Default body text
    displaySmall:
        TextStyle(color: Color(0xFFFFFFFF), fontSize: 14.0), // Secondary text
    displayLarge: TextStyle(
        color: Color(0xFFFFFFFF),
        fontSize: 20.0,
        fontWeight: FontWeight.w600), // Header text 
  ),
  buttonTheme: ButtonThemeData(
    textTheme: ButtonTextTheme.primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30), // Rounded button edges
    ),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF141927),
      secondary: Color(0xFFFFFFFF),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: const WidgetStatePropertyAll(
          Color(0xFF206088)), // Elevated button color
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      textStyle: const WidgetStatePropertyAll(
        TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
      padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(vertical: 12, horizontal: 24)),
    ),
  ),
  iconTheme:
      const IconThemeData(color: Color(0xFFFFFFFF)), // Default icon color
  cardTheme: CardTheme(
    color: const Color(0xFF1B2336), // Dark card background color
    shadowColor: Colors.black38, // Dark shadow color for cards
    elevation: 5, // Elevation for shadow effect
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16), // Rounded card edges
    ),
  ),
  tabBarTheme: const TabBarTheme(
    indicatorColor: Color(0xFF1A1A19),
    dividerColor: Color(0xFFFFFFFF),
    dividerHeight: 1,
  ),
);
