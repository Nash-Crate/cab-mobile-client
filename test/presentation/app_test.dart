import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_client/injection.dart';
import 'package:mobile_client/presentation/app.dart';
import 'package:mobile_client/presentation/common/common.dart';
import 'package:mobile_client/presentation/features/authentication/authentication.dart';
import 'package:mobile_client/presentation/features/onboarding/onboarding.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'app_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AppConfigsCubit>(),
  MockSpec<I18nCubit>(),
  MockSpec<OnboardingCubit>(),
  MockSpec<AuthActionsCubit>(),
  MockSpec<DrawerCubit>(),
])
void main() {
  late MockAppConfigsCubit mockAppConfigsCubit;
  late MockI18nCubit mockI18nCubit;
  late MockOnboardingCubit mockOnboardingCubit;
  late MockAuthActionsCubit mockAuthCubit;
  late MockDrawerCubit mockDrawerCubit;

  setUpAll(() async {
    WidgetsFlutterBinding.ensureInitialized();

    mockAppConfigsCubit = MockAppConfigsCubit();
    mockI18nCubit = MockI18nCubit();
    mockOnboardingCubit = MockOnboardingCubit();
    mockAuthCubit = MockAuthActionsCubit();
    mockDrawerCubit = MockDrawerCubit();

    when(mockAuthCubit.state).thenAnswer((_) => const AuthActionsProcessing(ActionStepEnum.login));

    // DI
    getIt
      ..registerSingleton<AppConfigsCubit>(mockAppConfigsCubit)
      ..registerSingleton<I18nCubit>(mockI18nCubit)
      ..registerSingleton<OnboardingCubit>(mockOnboardingCubit)
      ..registerSingleton<AuthActionsCubit>(mockAuthCubit)
      ..registerSingleton<DrawerCubit>(mockDrawerCubit);
  });
  Future<void> createWidgetUnderTest(WidgetTester tester) async {
    runApp(const App());
    await tester.pump(const Duration(seconds: 3));
  }

  group(
    'App',
    () {
      testWidgets(
        '`MaterialApp` should be created',
        (tester) async {
          // act
          await createWidgetUnderTest(tester);
          // assert
          expect(find.byType(MaterialApp), findsOneWidget);
        },
      );

      // TODO(tests): i18n
      // TODO(tests): router
      // TODO(tests): active theme
    },
  );
}
