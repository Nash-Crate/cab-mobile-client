import 'package:mobile_client/infrastructure/model/model.dart';

/// Request content type
enum RequestContentType {
  /// application/json
  json,

  /// application/x-www-form-urlencoded
  formEncoded,

  /// multipart/form-data
  formData,
}

/// Http client interface
abstract class IHttpClient {
  /// Http method for [get] requests
  Future<HttpResponseModel> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
  });

  /// Http method for [post] requests
  Future<HttpResponseModel> post(
    String uri, {
    Map<String, dynamic>? data,
    RequestContentType requestType = RequestContentType.json,
    Map<String, dynamic>? queryParameters,
  });

  /// Http method for [patch] requests
  Future<HttpResponseModel> patch(
    String uri, {
    required Object data,
    Map<String, dynamic>? queryParameters,
  });

  /// Http method for [put] requests
  Future<HttpResponseModel> put(
    String uri, {
    required Object data,
    Map<String, dynamic>? queryParameters,
  });

  /// Http method for [delete] requests
  Future<HttpResponseModel> delete(
    String uri, {
    Map<String, dynamic>? queryParameters,
  });
}
