import 'package:flutter/material.dart';

/// UV-index badge severity accents — the ONLY colors weather_sdk still owns.
///
/// Per Ray's decision, harvested pos surfaces carry no palette of their own:
/// every surface/ink/stroke color in this SDK resolves through base_sdk's
/// `AppStyle` mode-resolving tokens (`textPrimary`, `cardDark`, `cardDarkAlt`,
/// `strokeDark*`, `textDarkSecondary`, ...) so light/dark follow the host's
/// theme exactly like supacharge.
///
/// The two constants below survive because they are weather-domain SEMANTICS,
/// not palette: the UV severity scale (moderate -> high -> very high ->
/// extreme) needs fixed warning hues that read identically in both themes,
/// and base_sdk's AppStyle has no UV/warning-scale tokens. The rest of the
/// scale maps to themed tokens (moderate = `AppStyle.textDarkSecondary`,
/// low = `AppStyle.textPrimary`) and extreme = `AppStyle.red`.
abstract class WeatherColors {
  WeatherColors._();

  /// "High" UV badge (amber step of the UV severity scale).
  static const Color uvHigh = Color(0xFFFFC107);

  /// "Very high" UV badge (orange step of the UV severity scale).
  static const Color uvVeryHigh = Color(0xFFF26110);
}
