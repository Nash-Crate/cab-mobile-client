import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_client/injection.config.dart';

/// getIt instance
final GetIt getIt = GetIt.instance;

/// Injectable initialization
@injectableInit
Future<void> configureDependencies() => getIt.init();
