import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_client/infrastructure/infrastructure.dart';

/// External library injection for Http libraries
@module
abstract class HttpExternalLibraryInjectableModule {
  /// DI for Dio
  @lazySingleton
  Dio get dio {
    return Dio(
      BaseOptions(
        baseUrl: httpBaseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );
  }

  /// DI for DioAdapter
  @lazySingleton
  DioAdapter get dioAdapter => DioAdapter(dio: dio);
}
