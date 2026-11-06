import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  final String apiKey;

  AuthInterceptor(this.apiKey);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['X-Api-Key'] = apiKey;
    super.onRequest(options, handler);
  }
}