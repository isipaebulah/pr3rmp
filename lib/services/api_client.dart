import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'auth_interceptor.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerLazySingleton<Dio>(() {
    final dio = Dio(BaseOptions(
      baseUrl: 'https://api.api-ninjas.com/v1/',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ));

    // ключ
    dio.interceptors.add(AuthInterceptor('snXSi7Sm7NqqZawT2qt4tvbs0AwdqPSShbzVrN7s'));

    // Логгер для проверки
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      error: true,
      compact: true,
      maxWidth: 90,
    ));

    return dio;
  });
}