import 'package:dio/dio.dart';

import 'network_config.dart';

class DioClient {
  static Dio? _googleMapsDio;
  static Dio? _backendDio;

  static Dio get googleMapsInstance {
    if (_googleMapsDio == null) {
      _googleMapsDio = Dio(
        BaseOptions(
          baseUrl: NetworkConfig.googleMapsBaseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      _googleMapsDio!.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            return handler.next(options);
          },
          onResponse: (response, handler) {
            return handler.next(response);
          },
          onError: (DioException e, handler) {
            return handler.next(e);
          },
        ),
      );
    }
    return _googleMapsDio!;
  }

  static Dio get backendInstance {
    if (_backendDio == null) {
      _backendDio = Dio(
        BaseOptions(
          baseUrl: NetworkConfig.baseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      _backendDio!.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) {
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print(response);

          return handler.next(response);
        },
        onError: (DioException e, handler) {
          return handler.next(e);
        },
      ));
    }
    return _backendDio!;
  }
}
