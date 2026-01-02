import '../entities/user_entity.dart';

/// Auth Repository Interface (Domain Layer)
/// 
/// This defines the contract for authentication operations.
/// Implementations are in the data layer.
abstract class AuthRepository {
  /// Login with email and password
  /// 
  /// [email] - User email
  /// [password] - User password
  /// Returns user entity and auth tokens
  Future<AuthResult> login(String email, String password);

  /// Register a new user
  /// 
  /// [userData] - Registration data
  /// Returns user entity and auth tokens
  Future<AuthResult> register(Map<String, dynamic> userData);

  /// Login with social provider
  /// 
  /// [provider] - Social provider (google, apple, facebook)
  /// [token] - Provider token
  /// Returns user entity and auth tokens
  Future<AuthResult> loginWithSocial(String provider, String token);

  /// Verify email with code
  /// 
  /// [code] - Verification code
  Future<void> verifyEmail(String code);

  /// Logout current user
  /// 
  Future<void> logout();

  /// Refresh auth token
  /// 
  /// Returns new auth tokens
  Future<AuthTokens> refreshToken();

  /// Check if user is authenticated
  /// 
  /// Returns true if user is authenticated
  Future<bool> isAuthenticated();

  /// Get current auth tokens
  /// 
  /// Returns auth tokens or null if not authenticated
  Future<AuthTokens?> getAuthTokens();
}

/// Auth Result
class AuthResult {
  final UserEntity user;
  final AuthTokens tokens;

  AuthResult({
    required this.user,
    required this.tokens,
  });
}

/// Auth Tokens
class AuthTokens {
  final String accessToken;
  final String refreshToken;
  final DateTime expiresAt;

  AuthTokens({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresAt,
  });
}




