part of 'auth_actions_cubit.dart';

/// AuthActionsState is used to manage the state of authentication actions
enum ActionStepEnum {
  /// login step
  login,

  /// register step
  register,

  /// login verification step
  loginVerification,

  /// register verification step
  registerVerification,
}

/// AuthActionsState is used to manage the state of authentication actions
@freezed
class AuthActionsState with _$AuthActionsState {
  /// Processing state of authentication actions
  const factory AuthActionsState.processing(ActionStepEnum step) = AuthActionsProcessing;

  /// Step state of authentication actions
  const factory AuthActionsState.step(ActionStepEnum step) = AuthActionsStep;

  /// authenticated state of authentication actions
  const factory AuthActionsState.authenticated(User user) = Authenticated;

  // const factory AuthActionsState.error(String error, ActionStepEnum step) = AuthActionsError;

  const AuthActionsState._();

  /// Check if the currently at the 'Login step'
  bool get isOnLogin =>
      (this is AuthActionsStep && (this as AuthActionsStep).step == ActionStepEnum.login) ||
      (this is AuthActionsProcessing &&
          (this as AuthActionsProcessing).step == ActionStepEnum.login);

  /// Check if the currently at the 'Register step'
  bool get isOnRegister =>
      (this is AuthActionsStep && (this as AuthActionsStep).step == ActionStepEnum.register) ||
      (this is AuthActionsProcessing &&
          (this as AuthActionsProcessing).step == ActionStepEnum.register);

  /// Check if the currently at the 'Login Verification step'
  bool get isOnLoginVerification =>
      (this is AuthActionsStep &&
          ((this as AuthActionsStep).step == ActionStepEnum.loginVerification ||
              (this as AuthActionsStep).step == ActionStepEnum.loginVerification)) ||
      (this is AuthActionsProcessing &&
          ((this as AuthActionsProcessing).step == ActionStepEnum.loginVerification ||
              (this as AuthActionsProcessing).step == ActionStepEnum.loginVerification));

  /// Check if the currently at the 'Register Verification step'
  bool get isOnRegisterVerification =>
      (this is AuthActionsStep &&
          ((this as AuthActionsStep).step == ActionStepEnum.registerVerification ||
              (this as AuthActionsStep).step == ActionStepEnum.registerVerification)) ||
      (this is AuthActionsProcessing &&
          ((this as AuthActionsProcessing).step == ActionStepEnum.registerVerification ||
              (this as AuthActionsProcessing).step == ActionStepEnum.registerVerification));
}
