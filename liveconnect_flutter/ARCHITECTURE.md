# Clean Architecture - LiveConnect Flutter App

## 📁 Project Structure

The project follows Clean Architecture principles with clear separation of concerns:

```
lib/
├── core/                    # Core utilities and infrastructure
│   ├── config/             # API configuration, environment
│   ├── network/            # API client, HTTP interceptors
│   ├── storage/            # Local storage service
│   ├── errors/             # Error handling, exceptions
│   ├── theme/              # App theme, colors, typography
│   ├── widgets/            # Reusable UI widgets
│   ├── routing/            # Navigation configuration
│   ├── di/                 # Dependency injection (ServiceLocator)
│   └── data/               # Legacy mock data (to be migrated)
│
├── domain/                  # Domain Layer (Business Logic)
│   ├── entities/           # Domain entities (pure business objects)
│   │   ├── live_stream_entity.dart
│   │   ├── user_entity.dart
│   │   ├── gift_entity.dart
│   │   └── chat_message_entity.dart
│   ├── repositories/       # Repository interfaces (contracts)
│   │   ├── live_stream_repository.dart
│   │   ├── user_repository.dart
│   │   ├── chat_repository.dart
│   │   ├── gift_repository.dart
│   │   └── auth_repository.dart
│   └── usecases/           # Use cases (business logic)
│       ├── get_live_streams_usecase.dart
│       └── send_gift_usecase.dart
│
├── data/                    # Data Layer (Data Sources & Repositories)
│   ├── datasources/        # Data sources (remote & local)
│   │   ├── live_stream_remote_data_source.dart
│   │   ├── live_stream_remote_data_source_mock.dart
│   │   ├── live_stream_local_data_source.dart
│   │   ├── chat_remote_data_source.dart
│   │   └── gift_remote_data_source.dart
│   ├── repositories/       # Repository implementations
│   │   ├── live_stream_repository_impl.dart
│   │   ├── user_repository_impl.dart
│   │   ├── chat_repository_impl.dart
│   │   └── gift_repository_impl.dart
│   └── dto/                # Data Transfer Objects
│       ├── live_stream_dto.dart
│       └── user_dto.dart
│
├── presentation/            # Presentation Layer (UI & State)
│   ├── providers/          # Riverpod providers
│   │   ├── live_stream_provider.dart
│   │   ├── chat_provider.dart
│   │   ├── gift_provider.dart
│   │   └── user_provider.dart
│   ├── services/           # Presentation services
│   │   └── live_player_service.dart
│   └── features/           # Feature screens (organized by feature)
│       ├── home/
│       ├── live_stream/
│       ├── profile/
│       └── ...
│
└── main.dart               # App entry point
```

## 🏗️ Architecture Layers

### 1. Domain Layer (`lib/domain/`)

**Purpose**: Contains business logic and entities. Independent of frameworks and data sources.

**Components**:
- **Entities**: Pure business objects (e.g., `LiveStreamEntity`, `UserEntity`)
- **Repository Interfaces**: Contracts defining data operations
- **Use Cases**: Business logic operations (e.g., `GetLiveStreamsUseCase`, `SendGiftUseCase`)

**Rules**:
- ✅ No dependencies on data or presentation layers
- ✅ Pure Dart classes (no Flutter imports)
- ✅ Business logic only

### 2. Data Layer (`lib/data/`)

**Purpose**: Implements data sources and repositories. Handles API calls, caching, and data transformation.

**Components**:
- **Data Sources**: Remote (API) and local (cache) data sources
- **Repository Implementations**: Implement domain repository interfaces
- **DTOs**: Data Transfer Objects for API communication

**Rules**:
- ✅ Implements domain repository interfaces
- ✅ Handles data transformation (DTO ↔ Entity)
- ✅ Manages caching and offline support
- ✅ Contains TODO comments for API integration

### 3. Presentation Layer (`lib/presentation/`)

**Purpose**: UI components and state management. Connects to domain layer through repositories.

**Components**:
- **Providers**: Riverpod providers for state management
- **Services**: Presentation services (e.g., `LivePlayerService`)
- **Features**: Feature screens organized by feature

**Rules**:
- ✅ Uses repositories from domain layer (not data sources directly)
- ✅ State management with Riverpod
- ✅ UI components are "dumb" and subscribe to state
- ✅ Business logic in use cases, not in widgets

### 4. Core Layer (`lib/core/`)

**Purpose**: Shared utilities, infrastructure, and common code.

**Components**:
- **Config**: API configuration, environment variables
- **Network**: API client, HTTP interceptors
- **Storage**: Local storage service
- **Errors**: Error handling, exceptions
- **Theme**: App theme, colors, typography
- **Widgets**: Reusable UI widgets
- **Routing**: Navigation configuration
- **DI**: Dependency injection (ServiceLocator)

**Rules**:
- ✅ Shared across all layers
- ✅ No business logic
- ✅ Framework-agnostic where possible

## 🔄 Data Flow

### Request Flow (UI → API)

```
Presentation Layer (Widget)
    ↓
Riverpod Provider
    ↓
Use Case (optional)
    ↓
Repository Interface (Domain)
    ↓
Repository Implementation (Data)
    ↓
Remote Data Source
    ↓
API Client
    ↓
Backend API
```

### Response Flow (API → UI)

```
Backend API
    ↓
API Client
    ↓
Remote Data Source
    ↓
DTO (Data Transfer Object)
    ↓
Entity (Domain)
    ↓
Repository Implementation
    ↓
Repository Interface
    ↓
Use Case (optional)
    ↓
Riverpod Provider
    ↓
Presentation Layer (Widget)
```

## 📦 Repository Pattern

### Repository Interface (Domain Layer)

```dart
// lib/domain/repositories/live_stream_repository.dart
abstract class LiveStreamRepository {
  Future<List<LiveStreamEntity>> getLiveStreams({String? category});
  Future<LiveStreamEntity> getStreamById(String streamId);
  // ...
}
```

### Repository Implementation (Data Layer)

```dart
// lib/data/repositories/live_stream_repository_impl.dart
class LiveStreamRepositoryImpl implements LiveStreamRepository {
  final LiveStreamRemoteDataSource remoteDataSource;
  final LiveStreamLocalDataSource localDataSource;

  @override
  Future<List<LiveStreamEntity>> getLiveStreams({String? category}) async {
    try {
      // Try remote first
      final streams = await remoteDataSource.getLiveStreams(category: category);
      await localDataSource.cacheLiveStreams(streams);
      return streams;
    } catch (e) {
      // Fallback to cache
      final cached = await localDataSource.getCachedLiveStreams();
      if (cached != null) return cached;
      throw e;
    }
  }
}
```

## 🔌 API Integration Points

### 1. Update API Configuration

Edit `lib/core/config/api_config.dart`:

```dart
static const String baseUrl = 'https://your-api-url.com';
```

### 2. Implement Remote Data Sources

Edit `lib/data/datasources/live_stream_remote_data_source.dart`:

```dart
@override
Future<List<LiveStreamEntity>> getLiveStreams({String? category}) async {
  // TODO: Replace with real API call when backend is ready
  final response = await apiClient.get(
    ApiConfig.liveStreams,
    queryParameters: category != null ? {'category': category} : null,
  );
  final data = ApiResponse.fromJson(
    response.data,
    (json) => (json as List)
        .map((e) => LiveStreamDTO.fromJson(e).toEntity())
        .toList(),
  ).data;
  return data ?? [];
}
```

### 3. Update DTOs

Ensure DTOs match your API response format:

```dart
// lib/data/dto/live_stream_dto.dart
factory LiveStreamDTO.fromJson(Map<String, dynamic> json) {
  // Update to match your API response structure
  return LiveStreamDTO(
    id: json['id'] ?? '',
    streamerId: json['streamer_id'] ?? '',
    // ...
  );
}
```

## 🎯 Use Cases

Use cases encapsulate business logic:

```dart
// lib/domain/usecases/send_gift_usecase.dart
class SendGiftUseCase {
  final GiftRepository giftRepository;
  final UserRepository userRepository;

  Future<Map<String, dynamic>> execute({
    required String streamId,
    required String giftId,
    int quantity = 1,
  }) async {
    // Validate coin balance
    final balance = await giftRepository.getCoinBalance();
    final gift = await giftRepository.getAvailableGifts();
    // ...
    // Send gift
    return await giftRepository.sendGift(streamId, giftId, quantity);
  }
}
```

## 📱 State Management (Riverpod)

### Providers

```dart
// lib/presentation/providers/live_stream_provider.dart
final liveStreamRepositoryProvider = Provider<LiveStreamRepository>((ref) {
  return ServiceLocator().liveStreamRepository;
});

final liveStreamsProvider = FutureProvider.family<List<LiveStreamEntity>, String?>((ref, category) async {
  final repository = ref.watch(liveStreamRepositoryProvider);
  return await repository.getLiveStreams(category: category);
});
```

### Usage in Widgets

```dart
class MyWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final streamsAsync = ref.watch(liveStreamsProvider('gaming'));
    
    return streamsAsync.when(
      data: (streams) => ListView.builder(...),
      loading: () => CircularProgressIndicator(),
      error: (error, stack) => ErrorWidget(error),
    );
  }
}
```

## 🔐 Dependency Injection

### Service Locator

```dart
// lib/core/di/service_locator.dart
class ServiceLocator {
  static final ServiceLocator _instance = ServiceLocator._internal();
  factory ServiceLocator() => _instance;
  
  Future<void> init() async {
    // Initialize services
    _storageService = StorageService(_sharedPreferences!);
    _apiClient = ApiClient(storageService: _storageService!);
    
    // Initialize data sources
    _liveStreamRemoteDataSource = LiveStreamRemoteDataSourceMock(); // TODO: Replace with real implementation
    
    // Initialize repositories
    _liveStreamRepository = LiveStreamRepositoryImpl(
      remoteDataSource: _liveStreamRemoteDataSource!,
      localDataSource: _liveStreamLocalDataSource!,
    );
  }
  
  LiveStreamRepository get liveStreamRepository => _liveStreamRepository!;
}
```

### Initialization

```dart
// lib/main.dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ServiceLocator().init(); // Initialize services
  runApp(const MyApp());
}
```

## 🚀 Migration Guide

### Current State

- ✅ Clean architecture structure created
- ✅ Domain layer with entities and repository interfaces
- ✅ Data layer with repository implementations and data sources
- ✅ Presentation layer with Riverpod providers
- ✅ Mock implementations using existing mock data
- ✅ API-ready structure with TODO comments

### Next Steps

1. **Replace Mock Implementations**:
   - Update `LiveStreamRemoteDataSourceImpl` with real API calls
   - Update `ChatRemoteDataSourceImpl` with WebSocket connection
   - Update `GiftRemoteDataSourceImpl` with real API calls

2. **Update DTOs**:
   - Match DTOs to your API response format
   - Add missing fields
   - Update JSON serialization

3. **Implement Real-time Features**:
   - Replace mock streams with WebSocket connections
   - Implement real-time chat
   - Implement real-time stream updates

4. **Update Providers**:
   - Update existing providers to use new repositories
   - Add new providers for new features
   - Remove old mock data dependencies

## 📚 Key Principles

1. **Dependency Rule**: Dependencies point inward (presentation → domain ← data)
2. **Separation of Concerns**: Each layer has a single responsibility
3. **Testability**: Business logic is independent and testable
4. **Maintainability**: Clear structure makes it easy to find and modify code
5. **Scalability**: Easy to add new features and integrate APIs

## 🔍 File Naming Conventions

- **Entities**: `*_entity.dart` (e.g., `live_stream_entity.dart`)
- **Repositories**: `*_repository.dart` (interface), `*_repository_impl.dart` (implementation)
- **Data Sources**: `*_remote_data_source.dart`, `*_local_data_source.dart`
- **DTOs**: `*_dto.dart` (e.g., `live_stream_dto.dart`)
- **Use Cases**: `*_usecase.dart` (e.g., `get_live_streams_usecase.dart`)
- **Providers**: `*_provider.dart` (e.g., `live_stream_provider.dart`)

## 🎯 Benefits

1. **API-Ready**: Clear extension points for API integration
2. **Testable**: Business logic is isolated and testable
3. **Maintainable**: Clear structure and separation of concerns
4. **Scalable**: Easy to add new features
5. **Type-Safe**: Strong typing throughout
6. **Mock-Supported**: Easy to switch between mock and real data

## 📝 TODO: API Integration

When integrating your backend:

1. Update `lib/core/config/api_config.dart` with your API base URL
2. Implement API calls in `lib/data/datasources/*_remote_data_source.dart`
3. Update DTOs to match your API response format
4. Update entities if needed
5. Test with your backend
6. Remove mock implementations

See `API_INTEGRATION_GUIDE.md` for detailed instructions.
