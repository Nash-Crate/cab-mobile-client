import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_client/injection.dart';
import 'package:mobile_client/presentation/app.dart';
import 'package:mobile_client/presentation/common/common.dart';

/// Common main
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // screen util
  await ScreenUtil.ensureScreenSize();

  Bloc.observer = MainBlocObserver();

  // injectable initialization
  await configureDependencies();

  runApp(const App());
}
