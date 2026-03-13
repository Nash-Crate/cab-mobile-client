import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mobile_client/infrastructure/constants/constants.dart';

const _accessToken =
    'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJPbmxpbmUgSldUIEJ1aWxkZXIiLCJpYXQiOjE3NTY0MTk5MjUsImV4cCI6MTc4Nzk1NTkzNCwiYXVkIjoid3d3LmV4YW1wbGUuY29tIiwic3ViIjoianJvY2tldEBleGFtcGxlLmNvbSIsIkdpdmVuTmFtZSI6IkpvaG5ueSIsIlN1cm5hbWUiOiJSb2NrZXQiLCJFbWFpbCI6Impyb2NrZXRAZXhhbXBsZS5jb20iLCJSb2xlIjpbIk1hbmFnZXIiLCJQcm9qZWN0IEFkbWluaXN0cmF0b3IiXX0.gIqTcYz3eLWX8p7mp0WjXsjzEwcB1tgZeOSX9ry315k';
const _refreshToken =
    'eyJhbGciOiJIUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICI0YWI5OTA1ZS01MjkyLTRkYjctOGY5MC01NjcxYzNlMmNhN2YifQ.eyJleHAiOjE3NDQ1MDI5NzEsImlhdCI6MTc0NDUwMTE3MSwianRpIjoiZWIyOTE3M2EtNjgyMy00NWUxLTliNzQtYTlmY2UwODM2MDVlIiwiaXNzIjoiaHR0cHM6Ly9pZHAucmljaGF0LXNvbHV0aW9ucy5jb20vcmVhbG1zL3JpbWNhYiIsImF1ZCI6Imh0dHBzOi8vaWRwLnJpY2hhdC1zb2x1dGlvbnMuY29tL3JlYWxtcy9yaW1jYWIiLCJzdWIiOiI0OTY2MWY5NC05Njc5LTRlZjctYTU1YS01NzNkNDBmOTkwNGEiLCJ0eXAiOiJSZWZyZXNoIiwiYXpwIjoicmlkZXIiLCJzZXNzaW9uX3N0YXRlIjoiMDUyNjBjYmUtYzBiMC00NGRjLWI1Y2QtMDUzNDRhNTYwNWZkIiwic2NvcGUiOiJlbWFpbCBwcm9maWxlIiwic2lkIjoiMDUyNjBjYmUtYzBiMC00NGRjLWI1Y2QtMDUzNDRhNTYwNWZkIn0.oJTtQV2buieYEMoKo4dQhdVJTsn5XIJn-EljOOfGPmc';

/// Mocking
class MockingData {
  /// init
  static void init(DioAdapter dioAdapter) {
    mockAuthData(dioAdapter);
  }

  /// authentication
  static void mockAuthData(DioAdapter dioAdapter) {
    /// Login
    /// Request OTP
    // Success - 200
    dioAdapter
      ..onPost(
        loginCheckOtpUrl,
        data: {'username': '+46712345678'},
        (server) => server.reply(
          200,
          <String, dynamic>{},
          delay: const Duration(milliseconds: 300),
        ),
      )
      // User not found - 404
      // BadRequest - 404
      ..onPost(
        loginCheckOtpUrl,
        data: {'username': '+46712345679'},
        (server) => server.reply(
          400,
          <String, dynamic>{},
          delay: const Duration(milliseconds: 300),
        ),
      )
      /// login with code
      /// Success - 200
      ..onPost(
        loginUserUrl,
        data: {
          'grant_type': 'password',
          'client_id': 'rider',
          'username': '+46712345678',
          'password': '123456',
        },
        (server) => server.reply(
          200,
          {
            'access_token': _accessToken,
            'expires_in': 300,
            'refresh_expires_in': 1800,
            'refresh_token': _refreshToken,
            'token_type': 'Bearer',
            'not-before-policy': 0,
            'session_state': 'a1b2c3d4-e5f6-7890-abcd-ef1234567890',
            'scope': 'openid profile email',
          },
          delay: const Duration(milliseconds: 300),
        ),
      )
      /// Signup with code
      /// Success - 200
      ..onPost(
        loginUserUrl,
        data: {
          'grant_type': 'password',
          'client_id': 'rider',
          'username': '+46712345679',
          'password': '123456',
        },
        (server) => server.reply(
          200,
          {
            'access_token': _accessToken,
            'expires_in': 300,
            'refresh_expires_in': 1800,
            'refresh_token': _refreshToken,
            'token_type': 'Bearer',
            'not-before-policy': 0,
            'session_state': 'a1b2c3d4-e5f6-7890-abcd-ef1234567890',
            'scope': 'openid profile email',
          },
          delay: const Duration(milliseconds: 300),
        ),
      )
      /// Token refresh
      /// Success - 200
      ..onPost(
        loginUserUrl,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        data: {
          'grant_type': 'refresh_token',
          'client_id': 'rider',
          'refresh_token': _refreshToken,
        },
        (server) => server.reply(
          200,
          {
            'access_token': _accessToken,
            'expires_in': 300,
            'refresh_expires_in': 1800,
            'refresh_token': _refreshToken,
            'token_type': 'Bearer',
            'not-before-policy': 0,
            'session_state': 'a1b2c3d4-e5f6-7890-abcd-ef1234567890',
            'scope': 'openid profile email',
          },
          delay: const Duration(milliseconds: 300),
        ),
      )
      /// Resend verification code
      /// Success - 200
      ..onPost(
        resendVerificationCodeUrl,
        data: <String, dynamic>{},
        (server) => server.reply(
          200,
          <String, dynamic>{},
          delay: const Duration(milliseconds: 300),
        ),
      )
      /// get user
      ..onGet(
        retrieveUserUrl,
        headers: {
          'Authorization': 'Bearer $_accessToken',
        },
        (server) => server.reply(
          200,
          'userId123',
          delay: const Duration(milliseconds: 300),
        ),
      )
      /// logout
      /// Success - 200
      ..onPost(
        logoutUserUrl,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        data: <String, dynamic>{
          'client_id': 'rider',
          'refresh_token': _refreshToken,
        },
        (server) => server.reply(
          200,
          <String, dynamic>{},
          delay: const Duration(milliseconds: 300),
        ),
      )
      /// refresh token
      /// Success - 200
      ..onPost(
        loginUserUrl,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        data: <String, dynamic>{
          'client_id': 'rider',
          'grant_type': 'refresh_token',
          'refresh_token': _refreshToken,
        },
        (server) => server.reply(
          200,
          <String, dynamic>{
            'access_token': _accessToken,
            'expires_in': 300,
            'refresh_expires_in': 1800,
            'refresh_token': _refreshToken,
            'token_type': 'Bearer',
            'not-before-policy': 0,
            'session_state': 'a1b2c3d4-e5f6-7890-abcd-ef1234567890',
            'scope': 'openid profile email',
          },
          delay: const Duration(milliseconds: 300),
        ),
      );
  }
}
