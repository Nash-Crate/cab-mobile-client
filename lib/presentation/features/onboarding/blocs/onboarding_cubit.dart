import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_client/core/core.dart';
import 'package:mobile_library/mobile_library.dart';

part 'onboarding_cubit.freezed.dart';
part 'onboarding_state.dart';

/// Onboarding cubit
@singleton
class OnboardingCubit extends Cubit<OnboardingState> {
  //// constructor
  OnboardingCubit(this._getOnboardingViewed, this._setOnboardingViewed)
    : super(const OnboardingState.initial());

  final GetOnboardingViewed _getOnboardingViewed;
  final SetOnboardingViewed _setOnboardingViewed;

  /// check onboarding flag status on app starts
  Future<void> init() async {
    final result = await _getOnboardingViewed();
    if (result.isRight() && result.asR) return emit(const IgnoreOnboarding());

    return emit(const ShowOnboarding());
  }

  /// set onboarding as viewed on this device
  Future<void> onboardingViewed() async {
    await _setOnboardingViewed();
    // since there won't be any user notifying, no need to check for failures or success
  }
}
