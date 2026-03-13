import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_client/core/core.dart';
import 'package:mobile_client/presentation/extensions/extensions.dart';
import 'package:mobile_library/mobile_library.dart';

part 'auth_actions_cubit.freezed.dart';

part 'auth_actions_state.dart';

/// Authentication cubit
@singleton
class AuthActionsCubit extends Cubit<AuthActionsState> {
  /// Constructor
  AuthActionsCubit(
    this._checkAuth,
    this._getUser,
    this._requestLoginCheckOtp,
    this._loginRider,
    this._signUpRider,
    this._logout,
  ) : super(const AuthActionsState.step(ActionStepEnum.login));

  final CheckAuth _checkAuth;
  final GetUser _getUser;
  final RequestLoginCheckOtp _requestLoginCheckOtp;
  final LoginRider _loginRider;
  final SignUpRider _signUpRider;
  final UserLogout _logout;

  /// check for authentication status
  Future<void> init() async {
    emit(const AuthActionsProcessing(ActionStepEnum.login));
    final auth = await _checkAuth();

    if (auth.isRight() && auth.asR) {
      final user = await _getUser();
      if (user.isRight()) return emit(AuthActionsState.authenticated(user.asR));

      addError(user.asL.message);
      return emit(const AuthActionsStep(ActionStepEnum.login));
    }
    return emit(const AuthActionsStep(ActionStepEnum.login));
  }

  /// Navigate to login
  void toLogin() => emit(const AuthActionsStep(ActionStepEnum.login));

  /// Navigate to register
  void toRegister() => emit(const AuthActionsStep(ActionStepEnum.register));

  /// check login with otp
  Future<void> checkLoginOtp(CountryCallingCode countryCallingCode, PhoneNumber phoneNumber) async {
    emit(const AuthActionsProcessing(ActionStepEnum.login));

    if (!countryCallingCode.isValid || !phoneNumber.isValid) {
      emit(const AuthActionsStep(ActionStepEnum.login));
      return addError('Invalid phone number');
    }

    final either = await _requestLoginCheckOtp(
      FullPhoneNumber('${countryCallingCode.getOrCrash}${phoneNumber.getOrCrash}'),
    );

    if (either.isLeft()) {
      emit(const AuthActionsStep(ActionStepEnum.login));
      return addError(either.asL.message);
    }

    // if it returns [true], user exists, notify ui to navigate to the [verification] page
    // else, Register the new user
    return emit(
      AuthActionsStep(either.asR ? ActionStepEnum.loginVerification : ActionStepEnum.register),
    );
  }

  /// Login
  Future<void> login(
    CountryCallingCode countryCallingCode,
    PhoneNumber phoneNumber,
    VerificationCode code,
  ) async {
    emit(const AuthActionsProcessing(ActionStepEnum.loginVerification));

    if (!countryCallingCode.isValid || !phoneNumber.isValid) {
      emit(const AuthActionsStep(ActionStepEnum.loginVerification));
      return addError('Invalid phone number');
    } else if (!code.isValid) {
      emit(const AuthActionsStep(ActionStepEnum.loginVerification));
      return addError('Invalid code');
    }

    final params = LoginRiderParams(
      phoneNumber: FullPhoneNumber('${countryCallingCode.getOrCrash}${phoneNumber.getOrCrash}'),
      code: code,
    );
    final either = await _loginRider(params);

    if (either.isLeft()) {
      emit(const AuthActionsStep(ActionStepEnum.loginVerification));
      return addError(either.asL.message);
    }

    // get user on success
    final user = await _getUser();
    if (user.isRight()) return emit(AuthActionsState.authenticated(user.asR));

    emit(const AuthActionsStep(ActionStepEnum.loginVerification));
    return addError(user.asL.message);
  }

  /// Register
  Future<void> register(
    CountryCallingCode countryCallingCode,
    PhoneNumber phoneNumber,
    FirstName firstName,
    LastName lastName, {
    required bool isAgreeTerms,
  }) async {
    emit(const AuthActionsProcessing(ActionStepEnum.register));

    if (!countryCallingCode.isValid || !phoneNumber.isValid) {
      emit(const AuthActionsStep(ActionStepEnum.register));
      return addError('Invalid phone number');
    } else if (!firstName.isValid || !lastName.isValid) {
      emit(const AuthActionsStep(ActionStepEnum.register));
      return addError('Invalid Name');
    } else if (!isAgreeTerms) {
      emit(const AuthActionsStep(ActionStepEnum.register));
      return addError('Please agree to the terms and conditions');
    }

    final params = RiderSignUpParams(
      phoneNumber: FullPhoneNumber('${countryCallingCode.getOrCrash}${phoneNumber.getOrCrash}'),
      firstName: firstName,
      lastName: lastName,
    );
    final either = await _signUpRider(params);

    if (either.isLeft()) {
      emit(const AuthActionsStep(ActionStepEnum.register));
      return addError(either.asL.message);
    }

    // navigate back to login
    // TODO(fix): maybe navigate to the login [verification] page, call [checkLoginOtp] under the hood
    return emit(const AuthActionsStep(ActionStepEnum.login));
  }

  /// Logout
  Future<void> logout() async {
    emit(const AuthActionsProcessing(ActionStepEnum.login));

    final either = await _logout();
    if (either.isLeft()) return addError(either.asL.message);

    emit(const AuthActionsStep(ActionStepEnum.login));
  }
}
