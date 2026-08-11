// This file is part of paas_manager.
// Copyright (C) 2024 RokctAI
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.

import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';

import 'package:manager/presentation/styles/style.dart';

class ImageShimmer extends StatelessWidget {
  final double size;
  final bool isCircle;

  const ImageShimmer({super.key, required this.size, required this.isCircle});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Style.shimmerBase,
      highlightColor: Style.shimmerHighlight,
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
          color: Style.white,
        ),
      ),
    );
  }
}
