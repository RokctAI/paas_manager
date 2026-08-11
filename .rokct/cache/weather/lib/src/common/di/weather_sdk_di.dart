import 'package:get_it/get_it.dart';

/// weather_sdk's DI entry point, called from the host app's generated
/// `main()` (the composer emits a `WeatherSdkDependencies.register(...)`
/// call for every SDK it composes).
///
/// Deliberately registers nothing: the weather suite is riverpod-provider
/// wired end to end (`weatherProvider` / `openWeatherProvider` own their
/// services), and its only host seam is a plain callback -
/// [WeatherSdkConfig.locationResolver] - which the installed
/// `components/weather/weather_widget.dart` template assigns at startup.
/// A GetIt facade would duplicate that one-function seam for no gain.
class WeatherSdkDependencies {
  static void register(GetIt getIt) {
    // Intentionally empty - see class doc.
  }
}
