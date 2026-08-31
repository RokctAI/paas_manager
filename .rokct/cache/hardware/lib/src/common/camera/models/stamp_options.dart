// Copyright (c) 2026 ROKCT INTELLIGENCE (PTY) LTD
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

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
