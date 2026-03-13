import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

/// Logger instance
final logger = Logger(level: kDebugMode ? Level.debug : Level.error);

/// Logger instance without stack trace
final loggerNoStack = Logger(
  level: kDebugMode ? Level.debug : Level.error,
  printer: PrettyPrinter(methodCount: 0),
);
