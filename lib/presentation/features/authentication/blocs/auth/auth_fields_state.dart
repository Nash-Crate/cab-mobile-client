part of 'auth_fields_cubit.dart';

/// State for authentication related fields
@freezed
abstract class AuthFieldsState with _$AuthFieldsState {
  /// Constructor
  const factory AuthFieldsState({
    // common
    required PhoneNumber phoneNumber,
    required CountryCallingCode countryCallingCode,
    required VerificationCode code,
    // register
    required FirstName firstName,
    required LastName lastName,
    required Gender gender,
    @Default(false) bool isAgreeTerms,
  }) = _AuthFieldsState;

  /// Initial state
  factory AuthFieldsState.initial() {
    return AuthFieldsState(
      phoneNumber: PhoneNumber(null),
      countryCallingCode: CountryCallingCode('+1'),
      code: VerificationCode(null),
      firstName: FirstName(null),
      lastName: LastName(null),
      gender: Gender(null),
    );
  }

  const AuthFieldsState._();

  /// Check if the login step is valid
  bool get isLoginStepValid {
    return phoneNumber.isValid && countryCallingCode.isValid;
  }

  /// Check if the registration step is valid
  bool get isRegisterStepValid {
    return phoneNumber.isValid &&
        countryCallingCode.isValid &&
        firstName.isValid &&
        lastName.isValid &&
        gender.isValid &&
        isAgreeTerms;
  }

  /// check if the verification step is valid
  bool get isVerificationStepValid {
    return code.isValid;
  }
}
