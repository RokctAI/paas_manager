import 'package:flutter/widgets.dart';

import 'package:base_sdk/src/constants/app_constants.dart';

/// A lat/lng pair for weather lookups. Deliberately a tiny value type rather
/// than a dependency on any host's location/shop model: the SDK only ever
/// needs two doubles.
class WeatherLocation {
  final double latitude;
  final double longitude;

  const WeatherLocation({required this.latitude, required this.longitude});
}

/// Resolves where to fetch weather for. Hosts wire their own source (POS
/// wires the shop's stored lat/lng; see the installed
/// `components/weather/weather_widget.dart` template).
typedef WeatherLocationResolver = WeatherLocation? Function();

/// Runtime configuration for weather_sdk.
///
/// Mirrors paas_pos main's pattern where `AppConstants` weather fields are
/// mutable statics hydrated by the host's remote-config bootstrap
/// (`paas.api.get_remote_config?app_type=POS` -> app_initializer.dart on pos
/// main sets `openWeatherApiKey`, `weatherIcon`, `rainPOP`,
/// `weatherRefresher`). The SDK ships the same knobs with the same defaults;
/// the host's bootstrap assigns them after fetching remote config.
abstract class WeatherSdkConfig {
  WeatherSdkConfig._();

  /// OpenWeatherMap API key, used ONLY by the extended (day 4-6) forecast,
  /// which calls api.openweathermap.org directly. The primary current+3-day
  /// feed goes through the tenant backend proxy (see [weatherEndpoint]) and
  /// needs no client key.
  ///
  /// NEVER hardcode a key here. Sourcing order, matching pos main:
  /// 1. `--dart-define=OPEN_WEATHER_API_KEY=...` build-time default, then
  /// 2. the host's remote-config bootstrap overwrites it at startup
  ///    (pos main: `getString('openWeatherApiKey')`).
  static String openWeatherApiKey =
      const String.fromEnvironment('OPEN_WEATHER_API_KEY');

  /// Tenant-relative Frappe endpoint for the proxied current+forecast feed
  /// (weatherapi.com-shaped payload, served by the control plane through the
  /// tenant). This is what pos main calls today. NOTE: this repo's
  /// `weather/frappe` module whitelists the same proxy as
  /// `{app_name}.tenant.api.get_weather` - reconcile the two paths when the
  /// backend package is installed per-tenant (recorded in the PR).
  static String weatherEndpoint =
      'api/method/paas.api.system.system.get_weather';

  /// GeoNames reverse-geocode service used to turn shop lat/lng into the
  /// "city,cc" string the proxy endpoint expects. Public username, not a
  /// secret (carried over from pos main).
  static String geoNamesUsername = 'juvoplatforms';

  /// Rain "probability of precipitation" threshold (percent) above which the
  /// UI shows rain badges/feedback. Remote-config key `rainPOP` on pos main.
  static int rainPop = 60;

  /// Whether to render the provider's network icons (true) or the bundled
  /// Remix glyph mapping (false). Remote-config key `weatherIcon`.
  static bool useNetworkIcons = true;

  /// Periodic background refresh interval. Remote-config key
  /// `weatherRefresher` (minutes).
  static Duration refreshInterval = const Duration(minutes: 360);

  /// Host-provided location source. When null (or when it returns null) the
  /// SDK falls back to the demo coordinates baked into the build
  /// (`DEMO_LATITUDE`/`DEMO_LONGITUDE` dart-defines via base_sdk).
  static WeatherLocationResolver? locationResolver;

  static WeatherLocation resolveLocation() {
    final resolved = locationResolver?.call();
    if (resolved != null) return resolved;
    return WeatherLocation(
      latitude: _demoCoordinate(() => AppConstants.demoLatitude),
      longitude: _demoCoordinate(() => AppConstants.demoLongitude),
    );
  }

  /// base_sdk parses DEMO_LATITUDE/DEMO_LONGITUDE with double.parse, which
  /// throws when the dart-define is absent - swallow that into 0,0 so a
  /// build without demo coordinates degrades to the weather error state
  /// instead of crashing the header.
  static double _demoCoordinate(double Function() read) {
    try {
      return read();
    } catch (_) {
      return 0;
    }
  }

  // --- Adaptive layout -----------------------------------------------------

  /// Single shared width gate for the adaptive weather UI, per Ray:
  /// "minimal if in small screen but interactive if in large screen. so no
  /// popups in small screens."
  ///
  /// base_sdk has no breakpoint primitives yet; when they land this constant
  /// and [isLargeScreen] migrate there and this becomes a re-export.
  static const double largeScreenMinShortestSide = 600;

  /// Large screens get the full interactive experience (forecast dialog,
  /// hourly drill-down); small screens get the minimal, popup-free summary.
  static bool isLargeScreen(BuildContext context) =>
      MediaQuery.sizeOf(context).shortestSide >= largeScreenMinShortestSide;
}
