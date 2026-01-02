# API Integration Guide

This guide explains how to integrate your backend APIs with the LiveConnect Flutter app.

## 📁 Project Structure

The project follows Clean Architecture principles:

```
lib/core/
├── config/
│   └── api_config.dart          # API endpoints configuration
├── network/
│   ├── api_client.dart          # Base API client (Dio)
│   └── models/
│       └── api_response.dart    # API response models
├── storage/
│   └── storage_service.dart     # Local storage service
├── data/
│   ├── datasources/
│   │   ├── remote_data_source.dart  # API calls interface
│   │   └── local_data_source.dart   # Local cache interface
│   └── repositories/
│       ├── stream_repository.dart   # Stream data repository
│       └── user_repository.dart     # User data repository
└── di/
    └── service_locator.dart     # Dependency injection
```

## 🚀 Quick Start

### 1. Update API Configuration

Edit `lib/core/config/api_config.dart`:

```dart
static const String baseUrl = 'https://your-api-url.com';
```

### 2. Implement API Calls

Edit `lib/core/data/datasources/remote_data_source.dart` and replace the mock implementations with your actual API calls.

Example:

```dart
@override
Future<List<LiveStream>> getLiveStreams({String? category}) async {
  final response = await apiClient.get(
    ApiConfig.liveStreams,
    queryParameters: category != null ? {'category': category} : null,
  );
  
  final data = ApiResponse.fromJson(
    response.data,
    (json) => (json as List)
        .map((e) => LiveStream.fromJson(e))
        .toList(),
  ).data;
  
  return data ?? [];
}
```

### 3. Update API Response Format

Your backend should return responses in this format:

```json
{
  "success": true,
  "data": {
    // Your actual data
  },
  "message": "Optional message",
  "errors": null,
  "statusCode": 200
}
```

If your API uses a different format, update the `ApiResponse.fromJson` method in `lib/core/network/models/api_response.dart`.

## 📝 API Endpoints

All API endpoints are defined in `lib/core/config/api_config.dart`. Update them to match your backend:

### Auth Endpoints
- `POST /auth/login` - Login
- `POST /auth/register` - Register
- `POST /auth/verify` - Verify email
- `POST /auth/refresh` - Refresh token
- `POST /auth/logout` - Logout

### User Endpoints
- `GET /users/:id` - Get user profile
- `GET /users/:id/followers` - Get followers
- `GET /users/:id/following` - Get following
- `POST /users/:id/follow` - Follow user
- `DELETE /users/:id/unfollow` - Unfollow user

### Stream Endpoints
- `GET /streams/live` - Get live streams
- `GET /streams/:id` - Get stream by ID
- `POST /streams/go-live` - Start live stream
- `POST /streams/:id/end` - End stream
- `POST /streams/:id/like` - Like stream

### Gift Endpoints
- `GET /gifts` - Get available gifts
- `POST /gifts/send/:streamId` - Send gift

### Message Endpoints
- `GET /messages/conversations` - Get conversations
- `GET /messages/conversations/:id` - Get messages
- `POST /messages/conversations/:id/messages` - Send message

## 🔐 Authentication

The API client automatically handles authentication:

1. **Token Storage**: Tokens are stored using `StorageService`
2. **Token Refresh**: Automatically refreshes tokens on 401 errors
3. **Auto Logout**: Logs out user if token refresh fails

### Setting Auth Token

After login, save the token:

```dart
final serviceLocator = ServiceLocator();
await serviceLocator.storageService.saveAuthToken('your_access_token');
await serviceLocator.storageService.saveRefreshToken('your_refresh_token');
```

## 🔄 Using Repositories

Repositories provide a clean interface for data operations:

```dart
// Get stream repository
final streamRepository = ServiceLocator().streamRepository;

// Get live streams
final streams = await streamRepository.getLiveStreams(category: 'gaming');

// Get user repository
final userRepository = ServiceLocator().userRepository;

// Get user profile
final user = await userRepository.getUserProfile('user_id');
```

## 📦 Caching

The repository pattern includes caching:

1. **Remote First**: Fetches from API first
2. **Cache Fallback**: Falls back to cache if API fails
3. **Background Update**: Updates cache in background

To implement caching, update `lib/core/data/datasources/local_data_source.dart`.

## 🛠️ Error Handling

All API errors are automatically converted to `AppException`:

- `NetworkException` - Network errors
- `AuthenticationException` - Auth errors (401)
- `AuthorizationException` - Permission errors (403)
- `NotFoundException` - Resource not found (404)
- `ValidationException` - Validation errors (400, 422)
- `TimeoutException` - Request timeout

Handle errors in your UI:

```dart
try {
  final streams = await streamRepository.getLiveStreams();
} on NetworkException catch (e) {
  // Handle network error
} on AuthenticationException catch (e) {
  // Handle auth error
} catch (e) {
  // Handle other errors
}
```

## 🔧 Environment Variables

You can use environment variables for API configuration:

### Run with environment variable:

```bash
flutter run --dart-define=API_BASE_URL=https://your-api-url.com
```

### Access in code:

```dart
static const String baseUrl = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: 'https://api.liveconnect.app',
);
```

## 📱 Testing

### Mock Mode

The app currently uses mock data. To test with real APIs:

1. Update `RemoteDataSourceImpl` with your API calls
2. Set `API_BASE_URL` environment variable
3. Run the app

### Testing with Mock Data

The app will automatically fall back to mock data if:
- API calls fail
- No internet connection
- API returns error

## 🎯 Next Steps

1. **Update API Config**: Set your API base URL
2. **Implement API Calls**: Replace mock implementations in `RemoteDataSourceImpl`
3. **Update Models**: Ensure your models match API response format
4. **Test Integration**: Test with your backend
5. **Handle Errors**: Add error handling for edge cases
6. **Add Caching**: Implement local caching for offline support

## 📚 Additional Resources

- [Dio Documentation](https://pub.dev/packages/dio)
- [Clean Architecture Guide](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Repository Pattern](https://martinfowler.com/eaaCatalog/repository.html)

## 🐛 Troubleshooting

### API calls not working

1. Check API base URL in `api_config.dart`
2. Verify API endpoints match your backend
3. Check authentication tokens are set
4. Review error logs in console

### Authentication issues

1. Verify token format matches backend expectations
2. Check token expiration handling
3. Verify refresh token endpoint
4. Check token storage in SharedPreferences

### Caching issues

1. Verify local data source implementation
2. Check cache expiration logic
3. Verify cache invalidation on updates

## 📞 Support

For issues or questions:
1. Check error logs in console
2. Review API integration guide
3. Verify backend API documentation
4. Check network requests in debug mode




