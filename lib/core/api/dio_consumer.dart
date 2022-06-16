import 'dart:convert';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:quotes_app/core/api/api_client.dart';
import 'package:quotes_app/core/api/app_interceptor.dart';
import 'package:quotes_app/core/api/end_points.dart';
import 'package:quotes_app/core/api/status_codes.dart';
import 'package:quotes_app/core/error/exceptions.dart';
import 'package:quotes_app/injector.dart';

class DioConsumer implements ApiClient {
  late Dio dio;
  DioConsumer({required this.dio}) {
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    dio.options
      ..baseUrl = EndPoints.baseUrl
      ..responseType = ResponseType.plain
      ..followRedirects = true
      ..validateStatus = (status) {
        return status! < StatusCodes.internalServerError;
      };

    dio.interceptors.add(getIt<AppInterceptor>());
    if (kDebugMode) {
      dio.interceptors.add(getIt<LogInterceptor>());
    }
  }

  @override
  Future get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await dio.get(path, queryParameters: queryParameters);
      return _convertResponseToJson(response);
    } on DioError catch (error) {
      _handleDioError(error);
    }
  }

  @override
  Future post(String path,
      {Map<String, dynamic>? queryParameters,
      bool formDataEnabled = false,
      Map<String, dynamic>? body}) async {
    try {
      final response = await dio.post(path,
          queryParameters: queryParameters,
          data: formDataEnabled ? FormData.fromMap(body!) : body);
      return _convertResponseToJson(response);
    } on DioError catch (error) {
      _handleDioError(error);
    }
  }

  @override
  Future put(String path,
      {Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? body}) async {
    try {
      final response =
          await dio.put(path, queryParameters: queryParameters, data: body);
      return _convertResponseToJson(response);
    } on DioError catch (error) {
      _handleDioError(error);
    }
  }

  dynamic _convertResponseToJson(Response<dynamic> response) {
    return json.decode(response.data.toString());
  }

  dynamic _handleDioError(DioError error) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        throw const FetchDataException();
      case DioErrorType.response:
        switch (error.response!.statusCode) {
          case StatusCodes.badRequest:
            throw const BadRequestException();
          case StatusCodes.unauthorized:
          case StatusCodes.forbidden:
            throw const UnauthorizedException();
          case StatusCodes.notfound:
            throw const NotFoundException();
          case StatusCodes.conflict:
            throw const ConflictException();
          case StatusCodes.internalServerError:
            throw const InternalServerErrorException();
        }
        break;
      case DioErrorType.cancel:
        break;
      case DioErrorType.other:
        throw const NoInternetConnectionException();
    }
  }
}
