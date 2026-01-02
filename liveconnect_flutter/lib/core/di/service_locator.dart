import 'package:shared_preferences/shared_preferences.dart';
import '../network/api_client.dart';
import '../storage/storage_service.dart';
import '../config/api_config.dart';

// Domain Repositories (interfaces)
import '../../domain/repositories/live_stream_repository.dart';
import '../../domain/repositories/user_repository.dart';
import '../../domain/repositories/chat_repository.dart';
import '../../domain/repositories/gift_repository.dart';
import '../../domain/repositories/auth_repository.dart';

// Data Repositories (implementations)
import '../../data/repositories/live_stream_repository_impl.dart';
import '../../data/repositories/user_repository_impl.dart';
import '../../data/repositories/chat_repository_impl.dart';
import '../../data/repositories/gift_repository_impl.dart';

// Data Sources
import '../../data/datasources/live_stream_remote_data_source.dart';
import '../../data/datasources/live_stream_remote_data_source_mock.dart';
import '../../data/datasources/live_stream_local_data_source.dart';
import '../../data/datasources/chat_remote_data_source.dart';
import '../../data/datasources/gift_remote_data_source.dart';

/// Service Locator for Dependency Injection
/// 
/// This sets up all dependencies and makes them available throughout the app.
/// Initialize this in main.dart before running the app.
/// 
/// Uses Clean Architecture with:
/// - Domain layer (entities, repository interfaces, use cases)
/// - Data layer (repository implementations, data sources, DTOs)
/// - Presentation layer (UI, state management)
class ServiceLocator {
  static final ServiceLocator _instance = ServiceLocator._internal();
  factory ServiceLocator() => _instance;
  ServiceLocator._internal();

  // Core Services
  SharedPreferences? _sharedPreferences;
  StorageService? _storageService;
  ApiClient? _apiClient;

  // Data Sources
  LiveStreamRemoteDataSource? _liveStreamRemoteDataSource;
  LiveStreamLocalDataSource? _liveStreamLocalDataSource;
  ChatRemoteDataSource? _chatRemoteDataSource;
  GiftRemoteDataSource? _giftRemoteDataSource;

  // Repositories (Domain Interfaces)
  LiveStreamRepository? _liveStreamRepository;
  UserRepository? _userRepository;
  ChatRepository? _chatRepository;
  GiftRepository? _giftRepository;
  AuthRepository? _authRepository;

  /// Initialize all services
  /// 
  /// Call this in main() before runApp()
  Future<void> init() async {
    // Initialize SharedPreferences
    _sharedPreferences = await SharedPreferences.getInstance();

    // Initialize Storage Service
    _storageService = StorageService(_sharedPreferences!);

    // Initialize API Client
    _apiClient = ApiClient(
      storageService: _storageService!,
      baseUrl: ApiConfig.baseUrl, // You can override this with environment variables
    );

    // Initialize Data Sources
    // TODO: Switch to real API implementation when backend is ready
    // For now, use mock implementations
    _liveStreamRemoteDataSource = LiveStreamRemoteDataSourceMock();
    _liveStreamLocalDataSource = LiveStreamLocalDataSourceImpl(_storageService!);
    _chatRemoteDataSource = ChatRemoteDataSourceImpl();
    _giftRemoteDataSource = GiftRemoteDataSourceImpl();

    // Initialize Repositories (Domain Layer)
    _liveStreamRepository = LiveStreamRepositoryImpl(
      remoteDataSource: _liveStreamRemoteDataSource!,
      localDataSource: _liveStreamLocalDataSource!,
    );

    _userRepository = UserRepositoryImpl();

    _chatRepository = ChatRepositoryImpl(_chatRemoteDataSource!);

    _giftRepository = GiftRepositoryImpl(_giftRemoteDataSource!);

    // TODO: Implement AuthRepository when backend is ready
    // _authRepository = AuthRepositoryImpl(...);
  }

  /// Reset all services (useful for testing or logout)
  Future<void> reset() async {
    // Dispose chat data source
    if (_chatRemoteDataSource is ChatRemoteDataSourceImpl) {
      (_chatRemoteDataSource as ChatRemoteDataSourceImpl).dispose();
    }
    
    _sharedPreferences = null;
    _storageService = null;
    _apiClient = null;
    _liveStreamRemoteDataSource = null;
    _liveStreamLocalDataSource = null;
    _chatRemoteDataSource = null;
    _giftRemoteDataSource = null;
    _liveStreamRepository = null;
    _userRepository = null;
    _chatRepository = null;
    _giftRepository = null;
    _authRepository = null;
    
    // Reinitialize
    await init();
  }

  // Getters for Core Services
  StorageService get storageService {
    if (_storageService == null) {
      throw Exception('ServiceLocator not initialized. Call init() first.');
    }
    return _storageService!;
  }

  ApiClient get apiClient {
    if (_apiClient == null) {
      throw Exception('ServiceLocator not initialized. Call init() first.');
    }
    return _apiClient!;
  }

  // Getters for Repositories (Domain Layer)
  LiveStreamRepository get liveStreamRepository {
    if (_liveStreamRepository == null) {
      throw Exception('ServiceLocator not initialized. Call init() first.');
    }
    return _liveStreamRepository!;
  }

  UserRepository get userRepository {
    if (_userRepository == null) {
      throw Exception('ServiceLocator not initialized. Call init() first.');
    }
    return _userRepository!;
  }

  ChatRepository get chatRepository {
    if (_chatRepository == null) {
      throw Exception('ServiceLocator not initialized. Call init() first.');
    }
    return _chatRepository!;
  }

  GiftRepository get giftRepository {
    if (_giftRepository == null) {
      throw Exception('ServiceLocator not initialized. Call init() first.');
    }
    return _giftRepository!;
  }

  AuthRepository? get authRepository {
    // Auth repository is optional until backend is ready
    return _authRepository;
  }
}

