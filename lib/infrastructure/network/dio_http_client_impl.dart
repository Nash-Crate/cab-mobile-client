import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart' as mock_adapter;
import 'package:injectable/injectable.dart';
import 'package:mobile_client/i18n/translations.g.dart';
import 'package:mobile_client/infrastructure/infrastructure.dart';
import 'package:mobile_client/infrastructure/network/mocks/mocks.dart';
import 'package:mobile_library/mobile_library.dart';

/// Http client implementation for [Dio] library
@Singleton(as: IHttpClient)
class DioHttpClientImpl implements IHttpClient {
  /// constructor
  DioHttpClientImpl(this._client, this._networkInfo, this._authLocalDatasource, this._dioAdapter) {
    /// Mocks only for testing without a server
    _client.httpClientAdapter = _dioAdapter;
    MockingData.init(_dioAdapter);

    // to avoid circular dependency with AuthRemoteDatasource
    _client.interceptors.add(DioInterceptor(_authLocalDatasource, AuthRemoteDatasourceImpl(this)));
  }

  final Dio _client;
  final INetworkInfo _networkInfo;
  final AuthLocalDatasource _authLocalDatasource;
  final mock_adapter.DioAdapter _dioAdapter;

  // internet connectivity check
  Future<void> _checkInternetConnectivity() async {
    final isConnected = await _networkInfo.isConnected.first;
    if (isConnected.isLeft() || !isConnected.asR) {
      throw SocketException(t.errors.failures.noInternet);
    }
  }

  @override
  Future<HttpResponseModel> delete(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    await _checkInternetConnectivity();

    try {
      final response = await _client.delete<Map<String, dynamic>>(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return HttpResponseModel.fromDioResponse(response);
    } on FormatException catch (_) {
      throw const FormatException();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<HttpResponseModel> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    await _checkInternetConnectivity();

    try {
      final newOptions = options ?? Options(contentType: Headers.jsonContentType);

      final response = await _client.get<dynamic>(
        uri,
        queryParameters: queryParameters,
        data: data,
        options: newOptions,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      if (response is Response<Map<String, dynamic>>) {
        return HttpResponseModel.fromDioResponse(response);
      }
      return HttpResponseModel.fromDynamicDioResponse(response);
    } on FormatException catch (_) {
      throw const FormatException();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<HttpResponseModel> patch(
    String uri, {
    required Object data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    ProgressCallback? onSendProgress,
  }) async {
    await _checkInternetConnectivity();

    try {
      final response = await _client.patch<Map<String, dynamic>>(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return HttpResponseModel.fromDioResponse(response);
    } on FormatException catch (_) {
      throw const FormatException();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<HttpResponseModel> post(
    String uri, {
    Map<String, dynamic>? data,
    RequestContentType requestType = RequestContentType.json,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    await _checkInternetConnectivity();

    try {
      final newOptions =
          options ??
          Options(
            contentType: requestType == RequestContentType.formData
                ? Headers.multipartFormDataContentType
                : requestType == RequestContentType.formEncoded
                ? Headers.formUrlEncodedContentType
                : Headers.jsonContentType,
          );

      final response = await _client.post<Map<String, dynamic>>(
        uri,
        data: requestType == RequestContentType.formData && data != null
            ? FormData.fromMap(data)
            : data,
        queryParameters: queryParameters,
        options: newOptions,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return HttpResponseModel.fromDioResponse(response);
    } on FormatException catch (_) {
      throw const FormatException();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<HttpResponseModel> put(
    String uri, {
    required Object data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    ProgressCallback? onSendProgress,
  }) async {
    await _checkInternetConnectivity();

    try {
      final response = await _client.put<Map<String, dynamic>>(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return HttpResponseModel.fromDioResponse(response);
    } on FormatException catch (_) {
      throw const FormatException();
    } catch (e) {
      rethrow;
    }
  }
}
