part of 'auth.bloc.dart';

@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState.authenticated({
    required String accessToken,
    required String refreshToken,
    @Default(ApiResponse<Fragment$profile>.initial())
    ApiResponse<Fragment$profile> profileResponse,
    required Enum$AppType? selectedAppType,
    required List<String> supportedCurrencies,
    required String selectedCurrency,
  }) = AuthState$Authenticated;

  const factory AuthState.unauthenticated({
    @Default(ApiResponseInitial())
    ApiResponse<Fragment$token> loginResponse,
  }) = AuthState$Unauthenticated;

  factory AuthState.fromJson(Map<String, dynamic> json) {
    switch (json['runtimeType']) {
      case 'authenticated':
        return AuthState.authenticated(
          accessToken: json['accessToken'] as String,
          refreshToken: json['refreshToken'] as String,
          profileResponse: ApiResponse<Fragment$profile>.fromJson(
            json['profileResponse'] as Map<String, dynamic>,
            (data) => Fragment$profile.fromJson(
              data as Map<String, dynamic>,
            ),
          ),
          selectedAppType: json['selectedAppType'] != null
              ? Enum$AppType.values.firstWhere(
                  (e) => e.name == json['selectedAppType'],
                )
              : null,
          supportedCurrencies:
              List<String>.from(json['supportedCurrencies'] as List),
          selectedCurrency: json['selectedCurrency'] as String,
        );

      case 'unauthenticated':
        return AuthState.unauthenticated(
          loginResponse: ApiResponse<Fragment$token>.fromJson(
            json['loginResponse'] as Map<String, dynamic>,
            (data) => Fragment$token.fromJson(
              data as Map<String, dynamic>,
            ),
          ),
        );

      default:
        throw ArgumentError(
          'Unknown AuthState type: ${json['runtimeType']}',
        );
    }
  }

  Map<String, dynamic> toJson() {
    switch (this) {
      case AuthState$Authenticated(
        :final accessToken,
        :final refreshToken,
        :final profileResponse,
        :final selectedAppType,
        :final supportedCurrencies,
        :final selectedCurrency,
      ):
        return {
          'runtimeType': 'authenticated',
          'accessToken': accessToken,
          'refreshToken': refreshToken,
          'profileResponse':
              profileResponse.toJson((data) => data.toJson()),
          'selectedAppType': selectedAppType?.name,
          'supportedCurrencies': supportedCurrencies,
          'selectedCurrency': selectedCurrency,
        };

      case AuthState$Unauthenticated(:final loginResponse):
        return {
          'runtimeType': 'unauthenticated',
          'loginResponse':
              loginResponse.toJson((data) => data),
        };
    }
  }

  const AuthState._();

  bool get isAuthenticated => this is AuthState$Authenticated;

  String? get accessToken =>
      isAuthenticated ? (this as AuthState$Authenticated).accessToken : null;

  String? get refreshToken =>
      isAuthenticated ? (this as AuthState$Authenticated).refreshToken : null;

  bool get isTokenExpired {
    if (accessToken == null) return true;
    final payload = JWT.decode(accessToken!).payload;
    return DateTime.now().isAfter(
      DateTime.fromMillisecondsSinceEpoch(payload['exp'] * 1000),
    );
  }

  AuthState$Authenticated? get authenticated =>
      isAuthenticated ? this as AuthState$Authenticated : null;

  AuthState$Unauthenticated? get unauthenticated =>
      isAuthenticated ? null : this as AuthState$Unauthenticated;

  Fragment$profile? get profile =>
      authenticated?.profileResponse.data;

  Enum$AppType? get selectedAppType =>
      authenticated?.selectedAppType;

  List<String> get supportedCurrencies =>
      authenticated?.supportedCurrencies ?? const [];

  String get selectedCurrency =>
      authenticated?.selectedCurrency ?? Env.defaultCurrency;

  bool appTypeAllowed(Enum$AppType appType) =>
      profile?.role?.allowedApps.contains(appType) ?? false;
}