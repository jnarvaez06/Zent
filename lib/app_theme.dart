import 'package:flutter/material.dart';

class AppTheme {
  // Configuración para el tema claro
  static final ThemeData greenFinanceTheme = ThemeData(
    // Colores principales
    primaryColor: Color(0xFF1B5E20),
    primaryColorLight: Color(0xFF4C8C4A),
    primaryColorDark: Color(0xFF003300),
    
    // Esquema de colores
    colorScheme: ColorScheme.light(
      primary: Color(0xFF1B5E20),
      error: Colors.red,
      onPrimary: Colors.white,
    ),
    
    // Tipografía
    textTheme: TextTheme(
      displayLarge: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
      displayMedium: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
      displaySmall: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
      bodyLarge: TextStyle(fontSize: 16.0),
      bodyMedium: TextStyle(fontSize: 14.0),
    ),
    
    // Configuración de botones
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF1B5E20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    ),
    
    // Configuración adicional
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF1B5E20),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    iconTheme: IconThemeData(color: Color(0xFF1B5E20)),
    dividerTheme: DividerThemeData(color: Colors.grey[300]),
  );

  // Configuración para el tema oscuro
  static final ThemeData greenFinanceDarkTheme = ThemeData(
    // Colores principales
    primaryColor: Color(0xFF388E3C),
    primaryColorLight: Color(0xFF6ABF69),
    primaryColorDark: Color(0xFF00600F),
    
    // Esquema de colores
    colorScheme: ColorScheme.dark(
      primary: Color(0xFF388E3C),
      error: Colors.redAccent,
      onPrimary: Colors.white,
    ),
    
    // Tipografía
    textTheme: TextTheme(
      displayLarge: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white),
      displayMedium: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold, color: Colors.white),
      displaySmall: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500, color: Colors.white),
      bodyLarge: TextStyle(fontSize: 16.0, color: Colors.white70),
      bodyMedium: TextStyle(fontSize: 14.0, color: Colors.white70),
    ),
    
    // Configuración de botones
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF388E3C),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    ),
    
    // Configuración adicional
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF1B5E20),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    iconTheme: IconThemeData(color: Color(0xFF4CAF50)),
    dividerTheme: DividerThemeData(color: Colors.grey[800]),
  );
}