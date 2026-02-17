# Foodyman Seller (Manager) App

A comprehensive Flutter-based mobile application for restaurant and food delivery business management. This seller/manager app provides complete control over orders, products, inventory, and business operations.

## Features

### Order Management
- Real-time order tracking and status updates
- Order history and analytics
- Automated notification system for new orders
- Order filtering and search capabilities

### Product Management
- **Dual Product Types**: Support for both single products and combo packages
- **Category Management**: Separate categories for single and combo products
- Product creation and editing with multiple images
- Stock and inventory tracking
- Product pricing and tax management
- Add-ons and extras configuration

### Business Operations
- Restaurant/shop profile management
- Menu and category organization
- Kitchen workflow management
- Order statistics and reporting
- Revenue tracking and analytics

### Customer Interaction
- Order notifications
- Customer order history
- Review and rating management

## Tech Stack

### Framework & Language
- **Flutter** 3.38.5+
- **Dart** 3.10.0+

### State Management & Architecture
- **Riverpod** 2.6.1 - State management
- **Freezed** 3.2.3 - Immutable data classes
- **Auto Route** 11.1.0 - Navigation

### Backend & API
- **Dio** 5.9.0 - HTTP client
- **Connectivity Plus** 7.0.0 - Network monitoring

### UI & Design
- **Flutter ScreenUtil** 5.9.3 - Responsive design
- **Google Fonts** 6.3.3 - Typography
- **Flutter SVG** 2.2.3 - Vector graphics
- **Lottie** 3.3.2 - Animations
- **Shimmer** 3.0.0 - Loading effects
- **Pull to Refresh** 2.0.0 - List refresh
- **FL Chart** 1.1.1 - Data visualization

### Firebase Integration
- **Firebase Core** 4.3.0
- **Firebase Auth** 6.1.3 - Authentication
- **Firebase Messaging** 16.1.0 - Push notifications

### Maps & Location
- **Google Maps Flutter** 2.14.0
- **Geolocator** 14.0.2
- **Geocoding** 4.0.0
- **Location** 8.0.1
- **OSM Nominatim** 4.0.1

### Media & File Handling
- **Image Picker** 1.2.1
- **File Picker** 10.3.8
- **Cached Network Image** 3.4.1

### Other Dependencies
- **Shared Preferences** 2.5.4 - Local storage
- **Intl** 0.20.2 - Internationalization
- **Jiffy** 6.4.4 - Date formatting
- **Get It** 9.2.0 - Dependency injection
- **WebView Flutter** 4.13.0 - In-app browser

## Project Structure

```
lib/
├── application/              # Business logic & state management
│   ├── auth/                # Authentication logic
│   ├── category/            # Category management
│   ├── foods/               # Food/product management
│   │   ├── create/         # Product creation flow
│   │   ├── edit/           # Product editing flow
│   │   └── categories/     # Food category handling
│   ├── order/               # Order management
│   ├── order_products/      # Order product handling
│   ├── order_cart/          # Shopping cart logic
│   ├── profile/             # User profile management
│   ├── restaurant/          # Restaurant/shop management
│   └── providers.dart       # Riverpod providers
│
├── domain/                   # Business entities & interfaces
│   ├── di/                  # Dependency injection
│   └── interface/           # Repository interfaces
│
├── infrastructure/           # External implementations
│   ├── models/              # Data models
│   │   ├── data/           # Domain models
│   │   ├── request/        # API request models
│   │   └── response/       # API response models
│   ├── repositories/        # API implementations
│   └── services/            # Utility services
│       ├── app_helpers.dart
│       ├── local_storage.dart
│       └── tr_keys.dart     # Translation keys
│
└── presentation/             # UI layer
    ├── pages/               # App screens
    │   └── main/
    │       ├── foods/       # Product management UI
    │       ├── orders/      # Order management UI
    │       ├── profile/     # Profile UI
    │       └── create_order/ # Order creation UI
    ├── component/           # Reusable widgets
    └── styles/              # Theme & styling
        └── style.dart       # App-wide styles
```

## Key Architecture Features

### State Management
The app uses **Riverpod** with **StateNotifier** pattern for predictable state management:
```dart
// Example: Product state management
class FoodsNotifier extends StateNotifier<FoodsState> {
  void fetchProducts({String? type}) {
    // Handles both 'single' and 'combo' product types
  }
}
```

### Data Layer
- **Repository Pattern** for data abstraction
- **Freezed** for immutable data classes
- Automatic JSON serialization/deserialization

### Product Type System
The app supports two distinct product types:
- **Single Products**: Individual food items
- **Combo Products**: Package deals with multiple items

Categories and inventory are managed separately for each type, with API calls automatically routing to the appropriate endpoints:
```dart
// API automatically sends c_shop_id for combo, p_shop_id for single
final response = await catalogRepository.getCategories(
  type: 'combo', // or 'single'
  hasProducts: true,
);
```

### Performance Optimizations

#### Color Caching
App styles use an optimized caching system for theme colors:
```dart
// Primary color is cached after first access
static Color get primary => _getColorFromSettings(
  'primary_color',
  const Color(0xFF83EA00),
);
```

#### Font System
Base font method reduces code duplication:
```dart
static TextStyle _interFont({
  required FontWeight weight,
  // ... shared parameters
}) => GoogleFonts.inter(...);
```

## Getting Started

### Prerequisites
- Flutter SDK 3.38.5 or higher
- Dart SDK 3.10.0 or higher
- Android Studio / VS Code
- Xcode (for iOS development)

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd foodyman_seller
```

2. Install dependencies:
```bash
flutter pub get
```

3. Generate required files:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

4. Configure Firebase:
   - Add `google-services.json` to `android/app/`
   - Add `GoogleService-Info.plist` to `ios/Runner/`

5. Run the app:
```bash
flutter run
```

## Build Commands

### Generate Code (Freezed, Auto Route)
```bash
dart run build_runner build --delete-conflicting-outputs
```

### Build APK
```bash
flutter build apk --release
```

### Build iOS
```bash
flutter build ios --release
```

### Generate App Icons
```bash
flutter pub run flutter_launcher_icons
```

### Generate Splash Screen
```bash
flutter pub run flutter_native_splash:create
```

## Configuration

### App Settings
Global app settings are fetched from the backend and cached locally:
- Primary color theme
- Button text color
- Supported languages
- Currency settings

### Local Storage
The app uses `SharedPreferences` for:
- User authentication tokens
- Shop/restaurant data
- App settings cache
- User preferences

## API Integration

### Base Structure
```dart
// Repository interface
abstract class CatalogInterface {
  Future<ApiResult<CategoriesPaginateResponse>> getCategories({
    int? page,
    String? query,
    String? type,      // 'combo' or 'single'
    bool hasProducts,
  });
}
```

### Type-Based Routing
API requests automatically include appropriate shop IDs:
- `c_shop_id`: for combo products
- `p_shop_id`: for single products
- `has_products=1`: only when filtering by products

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

### Code Style
- Follow [Effective Dart](https://dart.dev/guides/language/effective-dart) guidelines
- Use `flutter analyze` to check for issues
- Format code with `dart format .`

## Troubleshooting

### Common Issues

**Build runner fails:**
```bash
flutter clean
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

**Riverpod state not updating:**
- Check if you're using `ref.watch()` in build method
- Ensure StateNotifier is updating state correctly

**Categories not loading:**
- Verify `type` parameter is set correctly ('combo' or 'single')
- Check network connectivity
- Clear app cache and retry

## License

This project is proprietary and confidential.

## Contact

For support or queries, please contact the development team.

---

**Version:** 1.0.0+1

**Last Updated:** December 2024
