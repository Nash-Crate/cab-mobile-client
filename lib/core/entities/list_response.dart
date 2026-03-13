import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_response.freezed.dart';

/// Wrapper for responses with list of items and pagination data
@freezed
abstract class ListResponse<T> with _$ListResponse<T> {
  /// List response
  const factory ListResponse({
    required List<T> items,
    required int page,
    required int totalPages,
  }) = _ListResponse<T>;
}
