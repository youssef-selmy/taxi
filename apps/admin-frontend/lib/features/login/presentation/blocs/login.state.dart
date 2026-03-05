part of 'login.cubit.dart';

@freezed
sealed class LoginState with _$LoginState {
  const factory LoginState({
    @Default("") String email,
    @Default("") String password,
    required GlobalKey<FormState> formKey,
  }) = _LoginState;

  const LoginState._();

  // initial State
  factory LoginState.initial() => LoginState(formKey: GlobalKey<FormState>());

  bool get isValid => email.isNotEmpty && password.isNotEmpty;
}
