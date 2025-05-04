import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:megaplug/config/clients/api/api_result.dart';
import 'package:megaplug/config/clients/storage/storage_client.dart';
import 'package:megaplug/config/helpers/logging_helper.dart';
import 'package:megaplug/config/helpers/offline_handler.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../environment.dart';
import 'network_helper.dart';

enum DioMethods { get, post, patch, put, delete }

class APIClient {
  static const _requestTimeOut = Duration(seconds: 30);

  APIClient._();

  static final instance = APIClient._();

  final Dio _client = Dio(
    BaseOptions(
      baseUrl: Environment().url(),
      headers: {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.cacheControlHeader: 'no-Cache',
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer ${StorageClient().apiToken()}',
        "Accept-Language": StorageClient().getAppLanguage(),
        HttpHeaders.acceptLanguageHeader: StorageClient().getAppLanguage()
      },
      followRedirects: false,
      validateStatus: (status) => status! <= 500,
      connectTimeout: _requestTimeOut,
      receiveTimeout: _requestTimeOut,
    ),
  )..interceptors.add(
      PrettyDioLogger(
        request: true,
        requestBody: true,
        requestHeader: true,
        error: true,
        logPrint: (Object object) {
          AppLogger.logWithGetX(object.toString());
        },
        maxWidth: 1000,
      ),
    );

  void updateAcceptedLanguageHeader(String language) {
    _client.options.headers[HttpHeaders.acceptLanguageHeader] = language;
  }

  void updateTokenHeader(String? token, {String? tokenType}) {
    if (token == null) {
      _client.options.headers.remove(HttpHeaders.authorizationHeader);
      return;
    }
    _client.options.headers[HttpHeaders.authorizationHeader] =
        '${tokenType ?? 'Bearer'} $token';
  }

  Future<ApiResult<T>> get<T>({
    required String endPoint,
    required T Function(dynamic) fromJson,
  }) async {
    try {
      if (await OfflineHandler.isConnected()) {
        Response response = await _client.get(endPoint);
        if (NetworkHelper.isSuccess(response)) {
          return ApiSuccess(fromJson(response.data));
        } else {
          return NetworkHelper.handleCommonNetworkCases(response);
        }
      } else {
        return ApiFailure(
          StorageClient().isAr()
              ? 'لا يوجد اتصال بالإنترنت'
              : 'Check your internet status',
        );
      }
    } on DioException catch (error) {
      return NetworkHelper.handleDioError(error);
    } catch (error) {
      AppLogger.logWithGetX(error.toString());

      return ApiFailure(StorageClient().isAr()
          ? 'للأسف حدث خطأ'
          : 'Unexpected Error Happened');
    }
  }

  Future<ApiResult<T>> post<T>({
    required String endPoint,
    required T Function(dynamic) fromJson,
    Map<String, dynamic>? requestBody,
    List<MapEntry<String, File>> files = const [],
    Function(double percentage)? onUploadProgress,
    Function(double percentage)? onDownloadProgress,
  }) async {
    try {
      if (await OfflineHandler.isConnected()) {
        bool haveFiles = false;
        FormData formData = FormData.fromMap({});
        if (files.isNotEmpty) {
          haveFiles = true;
          formData = FormData.fromMap(requestBody ?? {});
          formData.files.addAll(files
              .map(
                (e) => MapEntry(
                  e.key,
                  MultipartFile.fromFileSync(e.value.path,
                      filename: e.value.path.split("/").last),
                ),
              )
              .toList());
        }
        Response response = await _client.post(
          endPoint,
          data: haveFiles ? formData : requestBody,
          onReceiveProgress: (received, total) {
            int percentage = ((received / total) * 100).floor();

            if (onDownloadProgress != null) {
              onDownloadProgress((received / total));
            }
            AppLogger.log('Downloading ....$percentage');
          },
          onSendProgress: (sent, total) {
            int percentage = ((sent / total) * 100).floor();
            if (onUploadProgress != null) {
              onUploadProgress((sent / total));
            }
            AppLogger.log('Uploading ....$percentage');
          },
        );
        if (NetworkHelper.isSuccess(response)) {
          return ApiSuccess(fromJson(response.data));
        } else {
          return NetworkHelper.handleCommonNetworkCases(response);
        }
      } else {
        return ApiFailure(
          StorageClient().isAr()
              ? 'لا يوجد اتصال بالإنترنت'
              : 'Check your internet status',
        );
      }
    } on DioException catch (error) {
      return NetworkHelper.handleDioError(error);
    } catch (error) {
      AppLogger.logWithGetX(error.toString());
      return ApiFailure(StorageClient().isAr()
          ? 'للأسف حدث خطأ'
          : 'Unexpected Error Happened');
    }
  }

  Future<ApiResult<T>> put<T>({
    required String endPoint,
    required T Function(dynamic) fromJson,
    required Map<String, dynamic> requestBody,
    List<MapEntry<String, File>> files = const [],
  }) async {
    try {
      if (await OfflineHandler.isConnected()) {
        bool haveFiles = false;
        FormData formData = FormData.fromMap({});
        if (files.isNotEmpty) {
          haveFiles = true;
          formData = FormData.fromMap(requestBody);
          formData.files.addAll(files
              .map(
                (e) => MapEntry(
                  e.key,
                  MultipartFile.fromFileSync(e.value.path,
                      filename: e.value.path.split("/").last),
                ),
              )
              .toList());
        }
        Response response = await _client.put(
          endPoint,
          data: haveFiles ? formData : requestBody,
          onReceiveProgress: (received, total) {
            int percentage = ((received / total) * 100).floor();
            AppLogger.log('Downloading ....$percentage');
          },
          onSendProgress: (sent, total) {
            int percentage = ((sent / total) * 100).floor();
            AppLogger.log('Uploading ....$percentage');
          },
        );
        if (NetworkHelper.isSuccess(response)) {
          return ApiSuccess(fromJson(response.data));
        } else {
          return NetworkHelper.handleCommonNetworkCases(response);
        }
      } else {
        return ApiFailure(
          StorageClient().isAr()
              ? 'لا يوجد اتصال بالإنترنت'
              : 'Check your internet status',
        );
      }
    } on DioException catch (error) {
      return NetworkHelper.handleDioError(error);
    } catch (error) {
      AppLogger.logWithGetX(error.toString());

      return ApiFailure(StorageClient().isAr()
          ? 'للأسف حدث خطأ'
          : 'Unexpected Error Happened');
    }
  }

  Future<ApiResult<T>> delete<T>({
    required String endPoint,
    required T Function(dynamic) fromJson,
    required Map<String, dynamic> requestBody,
    List<MapEntry<String, File>> files = const [],
  }) async {
    try {
      if (await OfflineHandler.isConnected()) {
        Response response = await _client.delete(endPoint, data: requestBody);
        if (NetworkHelper.isSuccess(response)) {
          return ApiSuccess(fromJson(response.data));
        } else {
          return NetworkHelper.handleCommonNetworkCases(response);
        }
      } else {
        return ApiFailure(
          StorageClient().isAr()
              ? 'لا يوجد اتصال بالإنترنت'
              : 'Check your internet status',
        );
      }
    } on DioException catch (error) {
      return NetworkHelper.handleDioError(error);
    } catch (error) {
      AppLogger.logWithGetX(error.toString());

      return ApiFailure(StorageClient().isAr()
          ? 'للأسف حدث خطأ'
          : 'Unexpected Error Happened');
    }
  }

  Future<ApiResult<T>> patch<T>({
    required String endPoint,
    required T Function(dynamic) fromJson,
    required Map<String, dynamic> requestBody,
    List<MapEntry<String, File>> files = const [],
  }) async {
    try {
      if (await OfflineHandler.isConnected()) {
        Response response = await _client.patch(endPoint, data: requestBody);
        if (NetworkHelper.isSuccess(response)) {
          return ApiSuccess(fromJson(response.data));
        } else {
          return NetworkHelper.handleCommonNetworkCases(response);
        }
      } else {
        return ApiFailure(
          StorageClient().isAr()
              ? 'لا يوجد اتصال بالإنترنت'
              : 'Check your internet status',
        );
      }
    } on DioException catch (error) {
      return NetworkHelper.handleDioError(error);
    } catch (error) {
      AppLogger.logWithGetX(error.toString());

      return ApiFailure(StorageClient().isAr()
          ? 'للأسف حدث خطأ'
          : 'Unexpected Error Happened');
    }
  }
}
