// Copyright (c) 2026 ROKCT INTELLIGENCE (PTY) LTD
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as published
// by the Free Software Foundation, version 3.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public License
// along with this program. If not, see <https://www.gnu.org/licenses/>.

/// Where the stamp block is anchored on the image. Text is left-aligned and
/// the translucent background band spans the full image width, so only the
/// vertical anchor needs to vary.
enum StampPosition { topLeft, bottomLeft }

/// Bitmap font size used to burn the stamp text.
enum StampFontSize { small, medium, large }

/// Output encoding for the stamped image bytes.
enum StampImageFormat { jpg, png }

/// Presentation options for [ImageStamper]. Kept free of any imaging-library
/// types so callers can configure a stamp without depending on `package:image`.
class StampOptions {
  /// Vertical anchor for the stamp block. Defaults to bottom-left (TimeMark
  /// style).
  final StampPosition position;

  /// Font size for the burned-in text.
  final StampFontSize fontSize;

  /// Inner padding, in pixels, between the text and the band edges.
  final int padding;

  /// Encoding of the returned bytes.
  final StampImageFormat format;

  /// JPEG quality (1-100) used when [format] is [StampImageFormat.jpg].
  final int jpegQuality;

  /// Whether to draw a translucent band behind the text for legibility.
  final bool drawBackground;

  /// Alpha (0-255) of the background band when [drawBackground] is true.
  final int backgroundOpacity;

  const StampOptions({
    this.position = StampPosition.bottomLeft,
    this.fontSize = StampFontSize.medium,
    this.padding = 12,
    this.format = StampImageFormat.jpg,
    this.jpegQuality = 90,
    this.drawBackground = true,
    this.backgroundOpacity = 140,
  });

  StampOptions copyWith({
    StampPosition? position,
    StampFontSize? fontSize,
    int? padding,
    StampImageFormat? format,
    int? jpegQuality,
    bool? drawBackground,
    int? backgroundOpacity,
  }) {
    return StampOptions(
      position: position ?? this.position,
      fontSize: fontSize ?? this.fontSize,
      padding: padding ?? this.padding,
      format: format ?? this.format,
      jpegQuality: jpegQuality ?? this.jpegQuality,
      drawBackground: drawBackground ?? this.drawBackground,
      backgroundOpacity: backgroundOpacity ?? this.backgroundOpacity,
    );
  }
}
