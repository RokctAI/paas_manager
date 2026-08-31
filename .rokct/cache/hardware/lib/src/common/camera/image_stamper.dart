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

import 'dart:typed_data';

import 'package:image/image.dart' as img;

import 'models/stamp_options.dart';

/// Thrown when an image cannot be decoded for stamping.
class ImageStampException implements Exception {
  final String message;
  ImageStampException(this.message);

  @override
  String toString() => 'ImageStampException: $message';
}

/// Burns text directly into the pixels of an encoded image using the `image`
/// package (decode -> draw -> re-encode). The stamp becomes part of the raster,
/// so it survives copying, cropping and re-sharing — unlike EXIF metadata.
///
/// This class is pure and side-effect free, which keeps it trivially testable.
class ImageStamper {
  const ImageStamper();

  /// Returns a new set of encoded image bytes with [lines] drawn onto [source].
  ///
  /// Empty/whitespace-only lines are skipped. When no drawable lines remain the
  /// image is still decoded and re-encoded so the returned bytes are always a
  /// valid image in the requested [StampOptions.format].
  Uint8List stamp(
    Uint8List source,
    List<String> lines, {
    StampOptions options = const StampOptions(),
  }) {
    // decodeImage returns null for unrecognised data, but can also throw
    // (e.g. RangeError) when probing a truncated buffer, so both paths are
    // funnelled into ImageStampException.
    final img.Image? image;
    try {
      image = img.decodeImage(source);
    } catch (error) {
      throw ImageStampException('Unable to decode source image bytes: $error');
    }
    if (image == null) {
      throw ImageStampException('Unable to decode source image bytes');
    }

    final drawable = lines
        .where((line) => line.trim().isNotEmpty)
        .toList(growable: false);
    if (drawable.isNotEmpty) {
      _drawStamp(image, drawable, options);
    }

    return _encode(image, options);
  }

  void _drawStamp(img.Image image, List<String> lines, StampOptions options) {
    final font = _font(options.fontSize);
    final lineHeight = font.lineHeight;
    final pad = options.padding;
    final blockHeight = lineHeight * lines.length + pad * 2;

    final top = options.position == StampPosition.topLeft
        ? 0
        : (image.height - blockHeight).clamp(0, image.height);
    final bottom = (top + blockHeight - 1).clamp(0, image.height - 1);

    if (options.drawBackground) {
      img.fillRect(
        image,
        x1: 0,
        y1: top,
        x2: image.width - 1,
        y2: bottom,
        color: img.ColorRgba8(0, 0, 0, options.backgroundOpacity),
      );
    }

    final textColor = img.ColorRgba8(255, 255, 255, 255);
    var y = top + pad;
    for (final line in lines) {
      img.drawString(
        image,
        line,
        font: font,
        x: pad,
        y: y,
        color: textColor,
      );
      y += lineHeight;
    }
  }

  Uint8List _encode(img.Image image, StampOptions options) {
    switch (options.format) {
      case StampImageFormat.png:
        return img.encodePng(image);
      case StampImageFormat.jpg:
        return img.encodeJpg(image, quality: options.jpegQuality);
    }
  }

  img.BitmapFont _font(StampFontSize size) {
    switch (size) {
      case StampFontSize.small:
        return img.arial14;
      case StampFontSize.medium:
        return img.arial24;
      case StampFontSize.large:
        return img.arial48;
    }
  }
}
