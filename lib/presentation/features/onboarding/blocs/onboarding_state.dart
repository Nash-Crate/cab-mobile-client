part of 'onboarding_cubit.dart';

/// OnboardingState is used to manage the state of the onboarding process
@freezed
class OnboardingState with _$OnboardingState {
  /// initial state of the onboarding process
  const factory OnboardingState.initial() = OnboardingInitial;

  /// show state of the onboarding process
  const factory OnboardingState.show() = ShowOnboarding;

  /// ignore state of the onboarding process
  const factory OnboardingState.ignore() = IgnoreOnboarding;
}
