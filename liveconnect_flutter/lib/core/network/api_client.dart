import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../config/api_config.dart';
import '../errors/app_exceptions.dart';
import '../storage/storage_service.dart';

/// Base API Client using Dio
/// 
/// This client handles:
/// - Authentication headers
/// - Request/Response interceptors
/// - Error handling
/// - Logging
/// - Retry logic
class ApiClient {
  late final Dio _dio;
  final StorageService _storageService;

  ApiClient({
    required StorageService storageService,
    String? baseUrl,
  }) : _storageService = storageService {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl ?? ApiConfig.apiUrl,
        connectTimeout: ApiConfig.connectTimeout,
        receiveTimeout: ApiConfig.receiveTimeout,
        sendTimeout: ApiConfig.sendTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _setupInterceptors();
  }

  void _setupInterceptors() {
    // Request Interceptor - Add auth token
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Add auth token if available
          final token = await _storageService.getAuthToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          // Log request in debug mode
          if (kDebugMode) {
            print('🌐 API Request: ${options.method} ${options.path}');
            print('   Headers: ${options.headers}');
            if (options.data != null) {
              print('   Body: ${options.data}');
            }
          }

          return handler.next(options);
        },
        onResponse: (response, handler) {
          // Log response in debug mode
          if (kDebugMode) {
            print('✅ API Response: ${response.statusCode} ${response.requestOptions.path}');
            print('   Data: ${response.data}');
          }

          return handler.next(response);
        },
        onError: (error, handler) async {
          // Log error in debug mode
          if (kDebugMode) {
            print('❌ API Error: ${error.requestOptions.method} ${error.requestOptions.path}');
            print('   Error: ${error.message}');
            print('   Response: ${error.response?.data}');
          }

          // Handle 401 Unauthorized - Refresh token or logout
          if (error.response?.statusCode == 401) {
            final refreshed = await _handleTokenRefresh();
            if (refreshed) {
              // Retry the request with new token
              return handler.resolve(await _retry(error.requestOptions));
            } else {
              // Logout user
              await _storageService.clearAuthToken();
              return handler.reject(
                DioException(
                  requestOptions: error.requestOptions,
                  error: AuthenticationException('Session expired. Please login again.'),
                ),
              );
            }
          }

          // Convert DioError to AppException
          final appException = _convertError(error);
          return handler.reject(
            DioException(
              requestOptions: error.requestOptions,
              error: appException,
              response: error.response,
            ),
          );
        },
      ),
    );

    // Retry Interceptor
    _dio.interceptors.add(
      QueuedInterceptorsWrapper(
        onError: (error, handler) async {
          if (_shouldRetry(error)) {
            final retries = error.requestOptions.extra['retries'] ?? 0;
            if (retries < ApiConfig.maxRetries) {
              error.requestOptions.extra['retries'] = retries + 1;
              
              await Future.delayed(ApiConfig.retryDelay);
              
              try {
                final response = await _dio.fetch(error.requestOptions);
                return handler.resolve(response);
              } catch (e) {
                return handler.next(error);
              }
            }
          }
          return handler.next(error);
        },
      ),
    );
  }

  bool _shouldRetry(DioException error) {
    // Retry on network errors or 5xx server errors
    return error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.sendTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.connectionError ||
        (error.response?.statusCode != null &&
            error.response!.statusCode! >= 500);
  }

  Future<bool> _handleTokenRefresh() async {
    try {
      final refreshToken = await _storageService.getRefreshToken();
      if (refreshToken == null || refreshToken.isEmpty) {
        return false;
      }

      // Call refresh token endpoint
      final response = await _dio.post(
        ApiConfig.refreshToken,
        data: {'refreshToken': refreshToken},
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        await _storageService.saveAuthToken(data['accessToken'] as String);
        if (data['refreshToken'] != null) {
          await _storageService.saveRefreshToken(data['refreshToken'] as String);
        }
        return true;
      }

      return false;
    } catch (e) {
      return false;
    }
  }

  Future<Response> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );

    return _dio.request(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }

  AppException _convertError(DioException error) {
    if (error.response != null) {
      final statusCode = error.response!.statusCode;
      final data = error.response!.data;

      switch (statusCode) {
        case 400:
          return ValidationException(
            data['message'] ?? 'Invalid request',
            errors: data['errors'],
          );
        case 401:
          return AuthenticationException(
            data['message'] ?? 'Unauthorized',
          );
        case 403:
          return AuthorizationException(
            data['message'] ?? 'Forbidden',
          );
        case 404:
          return NotFoundException(
            data['message'] ?? 'Resource not found',
          );
        case 422:
          return ValidationException(
            data['message'] ?? 'Validation failed',
            errors: data['errors'],
          );
        case 500:
        case 502:
        case 503:
          return NetworkException(
            data['message'] ?? 'Server error',
          );
        default:
          return NetworkException(
            data['message'] ?? 'Unknown error occurred',
          );
      }
    } else if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.sendTimeout ||
        error.type == DioExceptionType.receiveTimeout) {
      return TimeoutException('Request timeout');
    } else if (error.type == DioExceptionType.connectionError) {
      return ConnectionException('No internet connection');
    } else {
      return UnknownException(error.message ?? 'Unknown error occurred');
    }
  }

  // HTTP Methods
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw _convertError(e);
    }
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw _convertError(e);
    }
  }

  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw _convertError(e);
    }
  }

  Future<Response<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.patch<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw _convertError(e);
    }
  }

  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw _convertError(e);
    }
  }

  // File Upload
  Future<Response<T>> uploadFile<T>(
    String path,
    String filePath, {
    String fileKey = 'file',
    Map<String, dynamic>? data,
    ProgressCallback? onSendProgress,
    CancelToken? cancelToken,
  }) async {
    try {
      final formData = FormData.fromMap({
        fileKey: await MultipartFile.fromFile(filePath),
        ...?data,
      });

      return await _dio.post<T>(
        path,
        data: formData,
        onSendProgress: onSendProgress,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw _convertError(e);
    }
  }

  // Get Dio instance (for advanced usage)
  Dio get dio => _dio;
}




