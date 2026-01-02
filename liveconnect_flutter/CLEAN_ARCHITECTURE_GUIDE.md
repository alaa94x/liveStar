# Clean Architecture Implementation Guide

## 🎯 Overview

The LiveConnect Flutter app has been refactored to follow **Clean Architecture** principles, making it:

- ✅ **Scalable**: Easy to add new features
- ✅ **Testable**: Business logic is isolated
- ✅ **API-Ready**: Clear extension points for backend integration
- ✅ **Maintainable**: Clear separation of concerns
- ✅ **Type-Safe**: Strong typing throughout

## 📁 New Project Structure

```
lib/
├── core/                    # Core utilities and infrastructure
│   ├── config/             # API configuration
│   ├── network/            # API client
│   ├── storage/            # Local storage
│   ├── errors/             # Error handling
│   ├── theme/              # App theme
│   ├── widgets/            # Reusable widgets
│   ├── routing/            # Navigation
│   └── di/                 # Dependency injection
│
├── domain/                  # Domain Layer (Business Logic)
│   ├── entities/           # Domain entities
│   ├── repositories/       # Repository interfaces
│   └── usecases/           # Use cases
│
├── data/                    # Data Layer (Data Sources & Repositories)
│   ├── datasources/        # Remote & local data sources
│   ├── repositories/       # Repository implementations
│   └── dto/                # Data Transfer Objects
│
├── presentation/            # Presentation Layer (UI & State)
│   ├── providers/          # Riverpod providers
│   ├── services/           # Presentation services
│   └── features/           # Feature screens (organized by feature)
│
└── main.dart
```

## 🏗️ Architecture Layers

### 1. Domain Layer (`lib/domain/`)

**Purpose**: Contains business logic and entities. Independent of frameworks and data sources.

#### Entities
- `LiveStreamEntity` - Live stream business object
- `UserEntity` - User business object
- `GiftEntity` - Gift business object
- `ChatMessageEntity` - Chat message business object

#### Repository Interfaces
- `LiveStreamRepository` - Stream data operations
- `UserRepository` - User data operations
- `ChatRepository` - Chat data operations
- `GiftRepository` - Gift data operations
- `AuthRepository` - Authentication operations

#### Use Cases
- `GetLiveStreamsUseCase` - Get live streams business logic
- `SendGiftUseCase` - Send gift business logic (validates coin balance)

**Rules**:
- ✅ No dependencies on data or presentation layers
- ✅ Pure Dart classes (no Flutter imports)
- ✅ Business logic only

### 2. Data Layer (`lib/data/`)

**Purpose**: Implements data sources and repositories. Handles API calls, caching, and data transformation.

#### Data Sources
- `LiveStreamRemoteDataSource` - API calls for streams
- `LiveStreamRemoteDataSourceMock` - Mock implementation (uses existing mock data)
- `LiveStreamLocalDataSource` - Local caching for streams
- `ChatRemoteDataSource` - API calls for chat
- `GiftRemoteDataSource` - API calls for gifts

#### Repository Implementations
- `LiveStreamRepositoryImpl` - Implements `LiveStreamRepository`
- `UserRepositoryImpl` - Implements `UserRepository`
- `ChatRepositoryImpl` - Implements `ChatRepository`
- `GiftRepositoryImpl` - Implements `GiftRepository`

#### DTOs
- `LiveStreamDTO` - Data Transfer Object for streams
- `UserDTO` - Data Transfer Object for users

**Rules**:
- ✅ Implements domain repository interfaces
- ✅ Handles data transformation (DTO ↔ Entity)
- ✅ Manages caching and offline support
- ✅ Contains TODO comments for API integration

### 3. Presentation Layer (`lib/presentation/`)

**Purpose**: UI components and state management. Connects to domain layer through repositories.

#### Providers
- `live_stream_provider.dart` - Stream providers
- `chat_provider.dart` - Chat providers
- `gift_provider.dart` - Gift providers
- `user_provider.dart` - User providers

#### Services
- `live_player_service.dart` - Video player service

#### Features
- Feature screens organized by feature (home, live_stream, profile, etc.)

**Rules**:
- ✅ Uses repositories from domain layer (not data sources directly)
- ✅ State management with Riverpod
- ✅ UI components are "dumb" and subscribe to state
- ✅ Business logic in use cases, not in widgets

### 4. Core Layer (`lib/core/`)

**Purpose**: Shared utilities, infrastructure, and common code.

**Components**:
- Config, Network, Storage, Errors, Theme, Widgets, Routing, DI

**Rules**:
- ✅ Shared across all layers
- ✅ No business logic
- ✅ Framework-agnostic where possible

## 🔄 Data Flow

### Request Flow (UI → API)

```
Widget (Presentation)
    ↓
Riverpod Provider (Presentation)
    ↓
Use Case (Domain) [optional]
    ↓
Repository Interface (Domain)
    ↓
Repository Implementation (Data)
    ↓
Remote Data Source (Data)
    ↓
API Client (Core)
    ↓
Backend API
```

### Response Flow (API → UI)

```
Backend API
    ↓
API Client (Core)
    ↓
Remote Data Source (Data)
    ↓
DTO (Data)
    ↓
Entity (Domain)
    ↓
Repository Implementation (Data)
    ↓
Repository Interface (Domain)
    ↓
Use Case (Domain) [optional]
    ↓
Riverpod Provider (Presentation)
    ↓
Widget (Presentation)
```

## 📦 Repository Pattern

### Repository Interface (Domain)

```dart
// lib/domain/repositories/live_stream_repository.dart
abstract class LiveStreamRepository {
  Future<List<LiveStreamEntity>> getLiveStreams({String? category});
  Future<LiveStreamEntity> getStreamById(String streamId);
  Stream<List<LiveStreamEntity>> watchLiveStreams();
  Stream<LiveStreamEntity> watchStream(String streamId);
}
```

### Repository Implementation (Data)

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
      data: (streams) => ListView.builder(
        itemCount: streams.length,
        itemBuilder: (context, index) {
          final stream = streams[index];
          return StreamCard(stream: stream);
        },
      ),
      loading: () => CircularProgressIndicator(),
      error: (error, stack) => ErrorWidget(error),
    );
  }
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
    final gifts = await giftRepository.getAvailableGifts();
    final gift = gifts.firstWhere((g) => g.id == giftId);
    
    // Check if user has enough coins
    final totalCost = gift.price * quantity;
    if (balance < totalCost) {
      throw InsufficientCoinsException('Insufficient coins');
    }
    
    // Send the gift
    return await giftRepository.sendGift(streamId, giftId, quantity);
  }
}
```

## 🔐 Dependency Injection

### Service Locator

```dart
// lib/core/di/service_locator.dart
class ServiceLocator {
  Future<void> init() async {
    // Initialize services
    _storageService = StorageService(_sharedPreferences!);
    _apiClient = ApiClient(storageService: _storageService!);
    
    // Initialize data sources
    // TODO: Switch to real API implementation when backend is ready
    _liveStreamRemoteDataSource = LiveStreamRemoteDataSourceMock();
    
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

## 🚀 Migration from Old Structure

### Old Structure

```
lib/
├── core/
│   ├── models/          # Models (mixed with entities)
│   ├── providers/       # Providers (mixed concerns)
│   ├── data/            # Data (mixed with domain)
│   └── ...
└── features/            # Feature screens
```

### New Structure

```
lib/
├── domain/              # Domain layer (entities, repositories, use cases)
├── data/                # Data layer (data sources, repositories, DTOs)
├── presentation/        # Presentation layer (providers, services, features)
└── core/                # Core utilities
```

### Migration Steps

1. ✅ **Created Domain Layer**:
   - Created entities (`LiveStreamEntity`, `UserEntity`, etc.)
   - Created repository interfaces
   - Created use cases

2. ✅ **Created Data Layer**:
   - Created data sources (remote and local)
   - Created repository implementations
   - Created DTOs

3. ✅ **Created Presentation Layer**:
   - Created Riverpod providers
   - Created presentation services
   - Organized features

4. ✅ **Updated Service Locator**:
   - Updated to use new repositories
   - Updated dependency injection

5. 🔄 **Next Steps**:
   - Update existing screens to use new providers
   - Update imports across codebase
   - Remove old mock data dependencies

## 📝 Key Changes

### 1. Entities vs Models

**Old**: Models in `core/models/` (mixed concerns)
**New**: Entities in `domain/entities/` (pure business objects)

### 2. Repository Pattern

**Old**: Direct data access in providers
**New**: Repository pattern with interfaces in domain and implementations in data

### 3. State Management

**Old**: Providers in `core/providers/` (mixed concerns)
**New**: Providers in `presentation/providers/` (presentation layer)

### 4. Data Sources

**Old**: Mock data service in `core/data/`
**New**: Data sources in `data/datasources/` (remote and local)

### 5. DTOs

**Old**: Models with JSON serialization
**New**: DTOs in `data/dto/` (data transfer objects)

## 🎯 Benefits

1. **API-Ready**: Clear extension points for API integration
2. **Testable**: Business logic is isolated and testable
3. **Maintainable**: Clear structure and separation of concerns
4. **Scalable**: Easy to add new features
5. **Type-Safe**: Strong typing throughout
6. **Mock-Supported**: Easy to switch between mock and real data

## 📚 Next Steps

1. **Update Existing Screens**:
   - Update `LiveStreamScreen` to use new providers
   - Update `HomeScreen` to use new providers
   - Update `ProfileScreen` to use new providers

2. **Update Imports**:
   - Update imports to use new structure
   - Remove old mock data dependencies

3. **Implement API Integration**:
   - Update remote data sources with real API calls
   - Update DTOs to match API response format
   - Test with backend

4. **Add More Use Cases**:
   - Create more use cases for business logic
   - Add validation logic
   - Add error handling

5. **Add Tests**:
   - Unit tests for use cases
   - Unit tests for repositories
   - Widget tests for screens

## 📖 Documentation

- `ARCHITECTURE.md` - Detailed architecture documentation
- `API_INTEGRATION_GUIDE.md` - API integration guide
- `README_API_SETUP.md` - Quick setup guide

## 🐛 Troubleshooting

### Import Errors

If you see import errors, update imports to use new structure:

**Old**:
```dart
import 'package:liveconnect/core/models/live_stream_model.dart';
```

**New**:
```dart
import 'package:liveconnect/domain/entities/live_stream_entity.dart';
```

### Provider Errors

If you see provider errors, update to use new providers:

**Old**:
```dart
final streams = ref.watch(streamProvider);
```

**New**:
```dart
final streamsAsync = ref.watch(liveStreamsProvider(null));
```

### Repository Errors

If you see repository errors, use repositories from ServiceLocator:

**Old**:
```dart
final streams = await MockDataService.getLiveStreams();
```

**New**:
```dart
final repository = ServiceLocator().liveStreamRepository;
final streams = await repository.getLiveStreams();
```

## ✅ Checklist

- [x] Domain layer created (entities, repositories, use cases)
- [x] Data layer created (data sources, repositories, DTOs)
- [x] Presentation layer created (providers, services)
- [x] Service Locator updated
- [x] API client configured
- [x] Mock implementations created
- [ ] Existing screens updated
- [ ] Imports updated
- [ ] Tests added
- [ ] Documentation updated

## 📞 Support

For issues or questions:
1. Check `ARCHITECTURE.md` for detailed architecture
2. Check `API_INTEGRATION_GUIDE.md` for API integration
3. Review repository implementations
4. Check error logs




