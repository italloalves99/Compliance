import 'package:flutter/material.dart';

class AppTextStyle {
  static const TextStyle titlelarge = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold
  ); 
   static const TextStyle titleMedium = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  // texto normal
  static const TextStyle body = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
  );

  // texto em itálico
  static const TextStyle italic = TextStyle(
    fontSize: 14,
    fontStyle: FontStyle.italic,
  );

  // texto em negrito
  static const TextStyle bold = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );

  // texto pequeno
  static const TextStyle small = TextStyle(
    fontSize: 12,
    color: Color(0xFF666666),
  );
}