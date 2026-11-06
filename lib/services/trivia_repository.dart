import 'package:dio/dio.dart';
import '../models/trivia.dart';
import 'api_client.dart';

class TriviaRepository {
  final Dio _dio = getIt<Dio>();

  Future<Trivia> fetchRandomTrivia({String? category}) async {
    final ticker = (category != null && category.isNotEmpty) ? category.toUpperCase() : 'AAPL';
    
    try {
      final response = await _dio.get(
        'stockprice',
        queryParameters: {'ticker': ticker},
      );

      final Map<String, dynamic> data = response.data;
      return Trivia.fromJson(data);
      
    } on DioException catch (e) {
      throw Exception('Ошибка сети: ${e.response?.statusCode}');
    }
  }
}