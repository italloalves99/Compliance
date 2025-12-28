// lib/services/api_client.dart
import 'package:dio/dio.dart';

class ApiClient {
  static const String baseUrl = 'https://aliancadev.com/compliance/api';

  static Dio dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 12),
      receiveTimeout: const Duration(seconds: 20),
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );
}
