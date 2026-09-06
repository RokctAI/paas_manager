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


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:remixicon/remixicon.dart';

import 'package:base_sdk/src/presentation/components/custom_network_image.dart';
import 'package:base_sdk/src/presentation/theme/app_style.dart';
import 'package:base_sdk/src/services/app_helpers.dart';

/// The shop avatar on the manager shell's profile tab (the pill's last
/// item, and the tablet rail's).
///
/// The tab used to hand the shop's `logo_img` straight to base_sdk's
/// [CustomNetworkImage], whose error state is a broken-image glyph — which
/// is exactly what the tab showed whenever the URL could not be resolved
/// (demo and offline shells: paas_manager guided tour 33952102598). This
/// widget degrades the way the profile header's avatar does instead: the
/// shop's initial on the brand circle, or a person glyph when there is no
/// name to take an initial from. A broken-image glyph is never drawn.
///
/// Inline `data:` logos (the demo shop's) still go through
/// [CustomNetworkImage], which decodes them itself; SVG URLs go through
/// [SvgPicture.network] with the same fallback; every other URL is a
/// cached raster through [Image] so the fallback can be its errorBuilder.
class ShopNavAvatar extends StatelessWidget {
  final String? url;
  final String? name;
  final double size;

  /// The raster provider for a non-inline, non-SVG [url]; defaults to
  /// [CachedNetworkImageProvider]. Tests hand in one that fails to prove
  /// the fallback renders without a network.
  final ImageProvider? image;

  const ShopNavAvatar({
    super.key,
    required this.url,
    required this.name,
    required this.size,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    final String source = url?.trim() ?? '';
    final Widget child;
    if (image == null && source.isEmpty) {
      child = _fallback();
    } else if (image == null && AppHelpers.isInlineImage(source)) {
      child = CustomNetworkImage(
        url: source,
        width: size,
        height: size,
        radius: size / 2,
      );
    } else if (image == null && AppHelpers.checkIsSvg(source)) {
      child = SvgPicture.network(
        source,
        width: size,
        height: size,
        fit: BoxFit.cover,
        placeholderBuilder: (_) => _loading(),
        errorBuilder: (_, __, ___) => _fallback(),
      );
    } else {
      child = Image(
        image: image ?? CachedNetworkImageProvider(source),
        width: size,
        height: size,
        fit: BoxFit.cover,
        gaplessPlayback: true,
        frameBuilder: (_, image, frame, wasSynchronouslyLoaded) =>
            frame == null && !wasSynchronouslyLoaded ? _loading() : image,
        errorBuilder: (_, __, ___) => _fallback(),
      );
    }
    return ClipOval(
      child: SizedBox(width: size, height: size, child: child),
    );
  }

  Widget _loading() => Container(
        width: size,
        height: size,
        color: AppStyle.shimmerBase,
      );

  /// The profile header's fallback: the initial on the brand circle, else
  /// a person.
  Widget _fallback() {
    final String trimmed = name?.trim() ?? '';
    return Container(
      key: const Key('shopNavAvatarFallback'),
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppStyle.primary,
        shape: BoxShape.circle,
      ),
      child: trimmed.isEmpty
          ? Icon(
              Remix.user_3_fill,
              size: size * 0.55,
              color: AppStyle.white,
            )
          : Text(
              trimmed[0].toUpperCase(),
              style: AppStyle.interSemi(
                size: size * 0.4,
                color: AppStyle.white,
              ),
            ),
    );
  }
}
