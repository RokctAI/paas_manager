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

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SwipeButton extends StatefulWidget {
  final Widget child;
  final Widget? thumb;
  final Color? activeThumbColor;
  final Color? inactiveThumbColor;
  final EdgeInsets thumbPadding;
  final Color? activeTrackColor;
  final Color? inactiveTrackColor;
  final EdgeInsets trackPadding;
  final BorderRadius? borderRadius;
  final double width;
  final double height;
  final bool enabled;
  final double elevationThumb;
  final double elevationTrack;
  final VoidCallback? onSwipeStart;
  final VoidCallback? onSwipe;
  final VoidCallback? onSwipeEnd;
  final Duration duration;

  const SwipeButton.expand({
    super.key,
    required this.child,
    this.thumb,
    this.activeThumbColor,
    this.inactiveThumbColor,
    this.thumbPadding = EdgeInsets.zero,
    this.activeTrackColor,
    this.inactiveTrackColor,
    this.trackPadding = EdgeInsets.zero,
    this.borderRadius,
    this.width = double.infinity,
    this.height = 50,
    this.enabled = true,
    this.elevationThumb = 0,
    this.elevationTrack = 0,
    this.onSwipeStart,
    this.onSwipe,
    this.onSwipeEnd,
    this.duration = const Duration(milliseconds: 250),
  })  : assert(elevationThumb >= 0.0),
        assert(elevationTrack >= 0.0);

  @override
  State<SwipeButton> createState() => _SwipeState();
}

class _SwipeState extends State<SwipeButton> with TickerProviderStateMixin {
  late AnimationController swipeAnimationController;
  late AnimationController expandAnimationController;

  bool swiped = false;

  @override
  void initState() {
    _initAnimationControllers();
    super.initState();
  }

  _initAnimationControllers() {
    swipeAnimationController = AnimationController(
      vsync: this,
      duration: widget.duration,
      lowerBound: 0,
      upperBound: 1,
      value: 0,
    );
    expandAnimationController = AnimationController(
      vsync: this,
      duration: widget.duration,
      lowerBound: 0,
      upperBound: 1,
      value: 0,
    );
  }

  @override
  void didUpdateWidget(covariant SwipeButton oldWidget) {
    if (oldWidget.duration != widget.duration) {
      _initAnimationControllers();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    swipeAnimationController.dispose();
    expandAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: LayoutBuilder(
        builder: (context, constraints) => Stack(
          clipBehavior: Clip.none,
          children: [
            _buildTrack(context, constraints),
            _buildThumb(context, constraints),
          ],
        ),
      ),
    );
  }

  Widget _buildTrack(BuildContext context, BoxConstraints constraints) {
    final ThemeData theme = Theme.of(context);
    final trackColor = widget.enabled
        ? widget.activeTrackColor ?? theme.colorScheme.surface
        : widget.inactiveTrackColor ?? theme.disabledColor;
    final borderRadius = widget.borderRadius ?? BorderRadius.circular(150);
    final elevationTrack = widget.enabled ? widget.elevationTrack : 0.0;
    return Padding(
      padding: widget.trackPadding,
      child: Material(
        elevation: elevationTrack,
        borderRadius: borderRadius,
        clipBehavior: Clip.antiAlias,
        color: trackColor,
        child: Container(
          width: constraints.maxWidth,
          height: widget.height,
          decoration: BoxDecoration(borderRadius: borderRadius),
          clipBehavior: Clip.antiAlias,
          alignment: Alignment.center,
          child: widget.child,
        ),
      ),
    );
  }

  Widget _buildThumb(BuildContext context, BoxConstraints constraints) {
    final ThemeData theme = Theme.of(context);
    final thumbColor = widget.enabled
        ? widget.activeThumbColor ?? theme.colorScheme.secondary
        : widget.inactiveThumbColor ?? theme.disabledColor;
    final borderRadius = widget.borderRadius ?? BorderRadius.circular(150);
    final elevationThumb = widget.enabled ? widget.elevationThumb : 0.0;
    return AnimatedBuilder(
      animation: swipeAnimationController,
      builder: (context, child) => Transform(
        transform: Matrix4.identity()
          ..translate(swipeAnimationController.value *
              (constraints.maxWidth - widget.height)),
        child: Container(
          padding: widget.thumbPadding,
          child: GestureDetector(
            onHorizontalDragStart: _onHorizontalDragStart,
            onHorizontalDragUpdate: (details) =>
                _onHorizontalDragUpdate(details, constraints.maxWidth),
            onHorizontalDragEnd: _onHorizontalDragEnd,
            child: Material(
              elevation: elevationThumb,
              borderRadius: borderRadius,
              color: thumbColor,
              clipBehavior: Clip.antiAlias,
              child: AnimatedBuilder(
                animation: expandAnimationController,
                builder: (context, child) => SizedBox(
                  width: 16.r +
                      widget.height +
                      (expandAnimationController.value *
                          (constraints.maxWidth - widget.height)) -
                      widget.thumbPadding.horizontal,
                  height: widget.height - widget.thumbPadding.vertical,
                  child: widget.thumb ??
                      Icon(
                        Icons.arrow_forward,
                        color: widget.activeTrackColor ??
                            widget.inactiveTrackColor,
                      ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _onHorizontalDragStart(DragStartDetails details) {
    setState(() {
      swiped = false;
    });
    widget.onSwipeStart?.call();
  }

  _onHorizontalDragUpdate(DragUpdateDetails details, double width) {
    if (!swiped && widget.enabled) {
      expandAnimationController.value +=
          details.primaryDelta! / (width - widget.height);
      if (expandAnimationController.value == 1) {
        setState(
          () {
            swiped = true;
            widget.onSwipe?.call();
          },
        );
      }
    }
  }

  _onHorizontalDragEnd(DragEndDetails details) {
    setState(
      () {
        swipeAnimationController.animateTo(0);
        expandAnimationController.animateTo(0);
      },
    );
    widget.onSwipeEnd?.call();
  }
}
