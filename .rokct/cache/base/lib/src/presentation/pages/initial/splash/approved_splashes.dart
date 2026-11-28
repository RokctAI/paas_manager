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

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// The approved per-app splashes (Ray, 28 Nov 2026,
/// login-per-app/approved/APPROVED.md), drawn in code for [SplashArt].
/// Every size is in the design's 430 x 932 units and scales with the
/// screen width; each scene follows light and dark mode.

class _Scaled extends StatelessWidget {
  const _Scaled({required this.background, required this.builder});
  final Color background;
  final Widget Function(double u) builder;

  @override
  Widget build(BuildContext context) => ColoredBox(
        color: background,
        child: LayoutBuilder(builder: (context, box) => builder(box.maxWidth / 430)),
      );
}

bool _dark(BuildContext c) => Theme.of(c).brightness == Brightness.dark;

/// Rebuilds every second so a clock shows the phone's live time.
class _Ticker extends StatefulWidget {
  const _Ticker({required this.builder});
  final Widget Function(DateTime now) builder;
  @override
  State<_Ticker> createState() => _TickerState();
}

class _TickerState extends State<_Ticker> {
  late final Timer _t = Timer.periodic(const Duration(seconds: 1), (_) => setState(() {}));
  DateTime get _now => SplashClock.now?.call() ?? DateTime.now();

  @override
  void dispose() {
    _t.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.builder(_now);
}

/// Test and render hook: a fixed time for the clocks.
class SplashClock {
  SplashClock._();
  static DateTime Function()? now;
}

String _two(int n) => n.toString().padLeft(2, '0');
const _days = ['MONDAY', 'TUESDAY', 'WEDNESDAY', 'THURSDAY', 'FRIDAY', 'SATURDAY', 'SUNDAY'];
const _months = ['JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN', 'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'];

/// Launcher: a black and white clock with the phone's live time.
class LauncherSplash extends StatelessWidget {
  const LauncherSplash({super.key});

  @override
  Widget build(BuildContext context) {
    final d = _dark(context);
    final ink = d ? Colors.white : const Color(0xFF0B0B0B);
    final soft = d ? const Color(0xFF8C8C8C) : const Color(0xFF8A8A8A);
    return _Scaled(
      background: d ? const Color(0xFF0B0B0C) : const Color(0xFFF6F6F6),
      builder: (u) => _Ticker(
        builder: (now) => Stack(children: [
          Positioned(
            left: 0,
            right: 0,
            top: 392 * u,
            child: Column(children: [
              Text('${_two(now.hour)}:${_two(now.minute)}',
                  style: GoogleFonts.inter(fontSize: 120 * u, fontWeight: FontWeight.w200, color: ink, height: 1)),
              SizedBox(height: 26 * u),
              Text('${_days[now.weekday - 1]} ${now.day} ${_months[now.month - 1]}',
                  style: GoogleFonts.jetBrainsMono(fontSize: 11 * u, letterSpacing: 3 * u, color: soft)),
            ]),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 842 * u,
            child: Text('Launcher',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(fontSize: 15 * u, fontWeight: FontWeight.w600, color: ink)),
          ),
        ]),
      ),
    );
  }
}

/// Forex: the name and five world clocks on the phone's live time.
class ForexSplash extends StatelessWidget {
  const ForexSplash({super.key});

  static const _zones = [('NYC', -5), ('LDN', 0), ('JHB', 2), ('TYO', 9), ('SYD', 11)];

  @override
  Widget build(BuildContext context) {
    final d = _dark(context);
    final ink = d ? const Color(0xFFF4F1EA) : const Color(0xFF0B1626);
    final dot = d ? const Color(0xFF6E8BFF) : const Color(0xFF2F5BFF);
    return _Scaled(
      background: d ? const Color(0xFF0B1626) : const Color(0xFFF7F8FA),
      builder: (u) => _Ticker(builder: (now) {
        final utc = now.toUtc();
        return Stack(children: [
          Positioned(
            left: 0,
            right: 0,
            top: 388 * u,
            child: Column(children: [
              Text.rich(
                TextSpan(children: [
                  const TextSpan(text: 'Forex'),
                  TextSpan(text: '.', style: TextStyle(color: dot)),
                ]),
                style: GoogleFonts.instrumentSerif(fontSize: 72 * u, color: ink, height: 1),
              ),
              SizedBox(height: 44 * u),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (final (i, (city, off)) in _zones.indexed)
                    SizedBox(
                      width: 76 * u,
                      child: Opacity(
                        opacity: const [0.35, 0.7, 1.0, 0.7, 0.35][i],
                        child: Column(children: [
                          Text(city, style: GoogleFonts.jetBrainsMono(fontSize: 8 * u, letterSpacing: 1.5 * u, color: ink, fontWeight: FontWeight.w600)),
                          SizedBox(height: 6 * u),
                          Builder(builder: (_) {
                            final t = utc.add(Duration(hours: off));
                            return Text('${_two(t.hour)}:${_two(t.minute)}',
                                style: GoogleFonts.inter(fontSize: 22 * u, fontWeight: i == 2 ? FontWeight.w500 : FontWeight.w300, color: ink));
                          }),
                        ]),
                      ),
                    ),
                ],
              ),
            ]),
          ),
        ]);
      }),
    );
  }
}

/// Polaris: the P mark in a soft green glow.
class PolarisSplash extends StatelessWidget {
  const PolarisSplash({super.key});

  @override
  Widget build(BuildContext context) {
    final d = _dark(context);
    final bg = d ? const Color(0xFF0A1411) : const Color(0xFFF3F6EC);
    final glow = d ? const Color(0xFF1C2416) : const Color(0xFFCFD9BB);
    final ink = d ? const Color(0xFFF4F3EC) : const Color(0xFF0E1A16);
    return _Scaled(
      background: bg,
      builder: (u) => Stack(children: [
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: RadialGradient(colors: [glow, bg], radius: 0.55, center: const Alignment(0, -0.05)),
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          top: 341 * u,
          child: Column(children: [
            Container(
              width: 96 * u,
              height: 96 * u,
              decoration: BoxDecoration(color: const Color(0xFF12302B), borderRadius: BorderRadius.circular(24 * u)),
              alignment: Alignment.center,
              child: Text('P', style: GoogleFonts.inter(fontSize: 46 * u, fontWeight: FontWeight.w700, color: const Color(0xFFFF6A2B))),
            ),
            SizedBox(height: 20 * u),
            Text('Polaris', style: GoogleFonts.inter(fontSize: 36 * u, fontWeight: FontWeight.w700, letterSpacing: -1.5 * u, color: ink)),
            SizedBox(height: 10 * u),
            Text('Loans with clear terms', style: GoogleFonts.inter(fontSize: 15 * u, color: ink.withValues(alpha: 0.6))),
          ]),
        ),
        Positioned(
          left: 0,
          right: 0,
          top: 864 * u,
          child: Text('FROM ROKCT',
              textAlign: TextAlign.center,
              style: GoogleFonts.jetBrainsMono(fontSize: 10 * u, letterSpacing: 4 * u, color: const Color(0xFF6E8A3C))),
        ),
      ]),
    );
  }
}

/// BetAssist: the name and its line, with the responsible-betting footer.
class BetAssistSplash extends StatelessWidget {
  const BetAssistSplash({super.key});

  @override
  Widget build(BuildContext context) {
    final d = _dark(context);
    final ink = d ? const Color(0xFFF1F5F2) : const Color(0xFF0A120D);
    const green = Color(0xFF1FA463);
    return _Scaled(
      background: d ? const Color(0xFF050A08) : const Color(0xFFF3F7F4),
      builder: (u) => Stack(children: [
        Positioned(
          left: 0,
          right: 0,
          top: 422 * u,
          child: Column(children: [
            Text.rich(
              TextSpan(children: [
                TextSpan(text: 'Bet', style: TextStyle(color: ink)),
                const TextSpan(text: 'Assist', style: TextStyle(color: green)),
              ]),
              style: GoogleFonts.inter(fontSize: 40 * u, fontWeight: FontWeight.w800, letterSpacing: -1.5 * u),
            ),
            SizedBox(height: 18 * u),
            Text('Every match, with the numbers behind it.',
                style: GoogleFonts.inter(fontSize: 16 * u, fontWeight: FontWeight.w600, color: ink)),
          ]),
        ),
        Positioned(
          left: 0,
          right: 0,
          top: 862 * u,
          child: Text('MODEL ESTIMATES · BET RESPONSIBLY',
              textAlign: TextAlign.center,
              style: GoogleFonts.jetBrainsMono(fontSize: 9 * u, letterSpacing: 2.5 * u, color: ink.withValues(alpha: 0.45))),
        ),
      ]),
    );
  }
}

/// Drive: a violet block with file tiles and the name; the private line under it.
class DriveSplash extends StatelessWidget {
  const DriveSplash({super.key});

  @override
  Widget build(BuildContext context) {
    final d = _dark(context);
    const violet = Color(0xFF5B3DF5);
    Widget tile(String label, Color c, double u) => Container(
          width: 96 * u,
          height: 84 * u,
          margin: EdgeInsets.only(right: 10 * u),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12 * u)),
          alignment: Alignment.center,
          child: Container(
            width: 34 * u,
            height: 42 * u,
            decoration: BoxDecoration(color: c, borderRadius: BorderRadius.circular(4 * u)),
            alignment: Alignment.center,
            child: Text(label, style: GoogleFonts.inter(fontSize: 8 * u, fontWeight: FontWeight.w700, color: Colors.white)),
          ),
        );
    return _Scaled(
      background: d ? const Color(0xFF0E0D16) : Colors.white,
      builder: (u) => Stack(children: [
        Positioned(left: 0, right: 0, top: 0, height: 620 * u, child: const ColoredBox(color: violet)),
        Positioned(
          left: 28 * u,
          top: 300 * u,
          child: Row(children: [
            tile('PDF', const Color(0xFFE5322D), u),
            tile('XLSX', const Color(0xFF1E7145), u),
            tile('JPG', const Color(0xFFF2A007), u),
          ]),
        ),
        Positioned(
          left: 26 * u,
          top: 470 * u,
          child: Text('Drive',
              style: GoogleFonts.inter(fontSize: 84 * u, fontWeight: FontWeight.w800, letterSpacing: -4 * u, color: Colors.white, height: 1.1)),
        ),
        Positioned(
          left: 28 * u,
          top: 652 * u,
          child: Text('PRIVATE BY DEFAULT\nSHARED WHEN YOU CHOOSE',
              style: GoogleFonts.jetBrainsMono(
                  fontSize: 10 * u, letterSpacing: 2 * u, height: 1.5, color: d ? const Color(0xFF9C98B8) : const Color(0xFF55526B))),
        ),
      ]),
    );
  }
}
