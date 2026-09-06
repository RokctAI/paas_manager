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

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:base_sdk/src/presentation/theme/app_style.dart';
import 'package:base_sdk/src/services/app_helpers.dart';
import 'package:base_sdk/src/services/tr_keys.dart';
import 'package:merchants_sdk/src/manager/utils/pos_receipt_printer.dart';

/// One tender line on the slip — how the sale is being taken (Cash,
/// QR / Pay link, On credit), with the amount that method carries.
/// [label] is already translated by the caller, the FloatingNavBack
/// rule: this widget owns no copy for the checkout's own words.
class PosReceiptTender {
  const PosReceiptTender({required this.label, required this.amount});

  final String label;
  final double amount;
}

/// What the slip prints — EXACTLY the receipt data the checkout already
/// hands PosReceiptPrinter.print (PosReceiptLine per line plus the
/// total; approved frame 11k: "no unit price is invented"), plus the
/// tender the checkout already computes for its 292 summary. Nothing
/// here is a new field of the sale: no tax, service or discount exists
/// on the POS cart, so none is drawn.
class PosReceiptData {
  const PosReceiptData({
    required this.shopName,
    required this.orderId,
    required this.issuedAt,
    required this.lines,
    required this.total,
    this.tender = const [],
    this.customerName,
    this.delivery = false,
    this.deliveryAddress,
  });

  /// The masthead (chip 323). Empty draws no shop line.
  final String shopName;
  final String orderId;
  final DateTime issuedAt;

  /// Chip 324: title, quantity, line total — the printer's own model.
  final List<PosReceiptLine> lines;

  /// Chip 326.
  final double total;

  /// Cash / QR paying-now and the on-credit remainder (the 292 split).
  final List<PosReceiptTender> tender;

  /// The attached "Billing to" customer (chip 305), when any.
  final String? customerName;

  /// Send-for-delivery is on (chips 312/313): the slip carries the
  /// delivery line, with [deliveryAddress] (chip 314) when entered.
  final bool delivery;
  final String? deliveryAddress;

  /// Sum of quantities — the Items row, the same figure as the cart chip.
  double get itemCount =>
      (lines.fold<double>(0, (sum, l) => sum + l.quantity) * 100)
          .roundToDouble() /
      100;
}

/// Chip 322 — the receipt as PAPER (approved 2026-08-29 13:53Z, Ray
/// 21:35Z "receipt i wanted it to be paperlike"): a 58mm-style thermal
/// strip on the screen — off-white paper with a faint speckle and feed
/// bands, serrated tear edges top and bottom, condensed monospace
/// receipt type, the centered shop masthead (323), the printed line rows
/// (324), the dashed tear line (325) and TOTAL emphasized in printed ink
/// (326; 292's blue total language stays on the dark-surface screens —
/// a thermal slip prints monochrome).
///
/// The paper is paper in both modes — the same off-white, the same ink —
/// so the SURROUND is what follows the theme (AppStyle.isDark): a soft
/// drop shadow lifts the slip off the dark surface; on the light surface
/// (close to the paper's own tone) a hairline edge keeps it legible.
///
/// Intrinsic width: [paperWidth] at most, centered, never stretched (11r:
/// "paper never stretches"); it grows as lines print (11p/11s: "receipt
/// can grow"). [compact] is 11n's live slip above 292 — the same paper
/// in tighter type and padding, "compact so 292 stays on screen".
class ReceiptSlip extends StatelessWidget {
  const ReceiptSlip({super.key, required this.receipt, this.compact = false});

  final PosReceiptData receipt;
  final bool compact;

  /// The 58mm strip's widest reading, in logical pixels.
  static const double paperWidth = 320;

  /// Printed paper and ink — fixed, mode-independent (see the class note).
  static const Color paper = Color(0xFFF6F2E8);
  static const Color ink = Color(0xFF1B1B20);
  static const Color inkFaint = Color(0xFF6E6A62);

  /// Serration: tooth pitch and depth along both tear edges.
  static const double toothWidth = 8;
  static const double toothDepth = 5;

  @override
  Widget build(BuildContext context) {
    final double pad = (compact ? 14 : 18).r;
    final bool dark = AppStyle.isDark;
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: paperWidth.r),
        child: CustomPaint(
          painter: _PaperPainter(dark: dark),
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              pad,
              toothDepth.r + pad,
              pad,
              toothDepth.r + pad,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: _content(context),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _content(BuildContext context) {
    final double base = compact ? 11 : 12.5;
    final double gap = (compact ? 6 : 8).h;
    final tear = _TearLine(color: inkFaint.withValues(alpha: .7));
    return [
      // 323 — the printed masthead.
      if (receipt.shopName.isNotEmpty)
        Text(
          receipt.shopName.toUpperCase(),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: _mono(
            size: base + 2.5,
            weight: FontWeight.w700,
            letterSpacing: 1.6,
          ),
        ),
      SizedBox(height: gap / 2),
      Text(
        AppHelpers.getTranslation(TrKeys.saleReceipt).toUpperCase(),
        textAlign: TextAlign.center,
        style: _mono(size: base - 2, color: inkFaint, letterSpacing: 2.2),
      ),
      SizedBox(height: gap),
      tear,
      SizedBox(height: gap),
      _row(
        AppHelpers.getTranslation(TrKeys.receiptOrder),
        receipt.orderId,
        size: base - 1.5,
        color: inkFaint,
      ),
      SizedBox(height: gap / 3),
      _row(_stamp(receipt.issuedAt), '', size: base - 1.5, color: inkFaint),
      SizedBox(height: gap),
      tear,
      SizedBox(height: gap),
      // 324 — the line rows: title + line total, QTY beneath.
      for (final line in receipt.lines) ...[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                line.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: _mono(size: base),
              ),
            ),
            SizedBox(width: 10.w),
            Text(
              AppHelpers.numberFormat(number: line.lineTotal),
              style: _mono(size: base),
            ),
          ],
        ),
        Text(
          '${AppHelpers.getTranslation(TrKeys.qty).toUpperCase()} '
          '${_trimQty(line.quantity)}',
          style: _mono(size: base - 1.5, color: inkFaint),
        ),
        SizedBox(height: gap / 2),
      ],
      SizedBox(height: gap / 2),
      // 325 — the dashed tear line before the totals.
      tear,
      SizedBox(height: gap),
      _row(
        AppHelpers.getTranslation(TrKeys.items),
        _trimQty(receipt.itemCount),
        size: base - 0.5,
        color: inkFaint,
      ),
      SizedBox(height: gap / 2),
      // 326 — TOTAL, emphasized in printed ink.
      _row(
        AppHelpers.getTranslation(TrKeys.total).toUpperCase(),
        AppHelpers.numberFormat(number: receipt.total),
        size: base + 3.5,
        weight: FontWeight.w700,
      ),
      if (receipt.tender.isNotEmpty ||
          receipt.customerName != null ||
          receipt.delivery) ...[
        SizedBox(height: gap),
        tear,
        SizedBox(height: gap),
        if (receipt.tender.isNotEmpty) ...[
          Text(
            AppHelpers.getTranslation(TrKeys.paid).toUpperCase(),
            style: _mono(size: base - 2, color: inkFaint, letterSpacing: 1.6),
          ),
          SizedBox(height: gap / 3),
          for (final t in receipt.tender) ...[
            _row(
              t.label,
              AppHelpers.numberFormat(number: t.amount),
              size: base,
            ),
            SizedBox(height: gap / 3),
          ],
        ],
        if (receipt.customerName != null)
          _row(
            AppHelpers.getTranslation(TrKeys.billingTo),
            receipt.customerName!,
            size: base - 0.5,
            color: inkFaint,
          ),
        if (receipt.delivery) ...[
          if (receipt.customerName != null) SizedBox(height: gap / 3),
          _row(
            AppHelpers.getTranslation(TrKeys.delivery),
            receipt.deliveryAddress ?? '',
            size: base - 0.5,
            color: inkFaint,
          ),
        ],
      ],
      SizedBox(height: gap),
      tear,
      SizedBox(height: gap),
      Text(
        AppHelpers.getTranslation(TrKeys.thankYou),
        textAlign: TextAlign.center,
        style: _mono(size: base - 1, color: inkFaint, letterSpacing: 1.2),
      ),
    ];
  }

  Widget _row(
    String label,
    String value, {
    required double size,
    FontWeight weight = FontWeight.w400,
    Color color = ink,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            label,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: _mono(size: size, weight: weight, color: color),
          ),
        ),
        if (value.isNotEmpty) ...[
          SizedBox(width: 10.w),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: _mono(size: size, weight: weight, color: color),
            ),
          ),
        ],
      ],
    );
  }

  /// The printer face: the platform's monospace (no receipt face ships
  /// in the app — 11k's IBM Plex Mono was the render stand-in), tabular
  /// figures so the money column lines up.
  static TextStyle _mono({
    required double size,
    FontWeight weight = FontWeight.w400,
    Color color = ink,
    double letterSpacing = 0.2,
  }) {
    return TextStyle(
      fontFamily: 'monospace',
      fontFamilyFallback: const [
        'Menlo',
        'Roboto Mono',
        'Courier New',
        'Courier',
      ],
      fontSize: size.sp,
      fontWeight: weight,
      color: color,
      height: 1.35,
      letterSpacing: letterSpacing,
      fontFeatures: const [FontFeature.tabularFigures()],
    );
  }

  /// "2" not "2.0", "0.75" as sold — the till's own rule.
  static String _trimQty(double quantity) {
    if (quantity == quantity.roundToDouble()) {
      return quantity.round().toString();
    }
    return quantity.toString();
  }

  /// yyyy-MM-dd HH:mm, printer style — unambiguous in every locale and
  /// free of a date-format dependency this package does not carry.
  static String _stamp(DateTime at) {
    String two(int n) => n.toString().padLeft(2, '0');
    return '${at.year}-${two(at.month)}-${two(at.day)} '
        '${two(at.hour)}:${two(at.minute)}';
  }
}

/// Chip 325's dashed rule.
class _TearLine extends StatelessWidget {
  const _TearLine({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1,
      width: double.infinity,
      child: CustomPaint(painter: _DashPainter(color: color)),
    );
  }
}

class _DashPainter extends CustomPainter {
  const _DashPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;
    const dash = 4.0;
    const space = 3.0;
    var x = 0.0;
    final y = size.height / 2;
    while (x < size.width) {
      canvas.drawLine(
        Offset(x, y),
        Offset(math.min(x + dash, size.width), y),
        paint,
      );
      x += dash + space;
    }
  }

  @override
  bool shouldRepaint(_DashPainter oldDelegate) => color != oldDelegate.color;
}

/// The paper: serrated tear edges top and bottom, a subtle speckle and
/// faint feed bands — drawn, not an asset, so the slip needs nothing
/// installed. Dark surfaces get a soft shadow, light ones a hairline.
class _PaperPainter extends CustomPainter {
  const _PaperPainter({required this.dark});

  final bool dark;

  @override
  void paint(Canvas canvas, Size size) {
    final path = _outline(size);
    if (dark) {
      canvas.drawShadow(path, const Color(0xFF000000), 10, false);
    }
    canvas.drawPath(path, Paint()..color = ReceiptSlip.paper);
    canvas.save();
    canvas.clipPath(path);
    // Feed bands: the thermal head's faint horizontal grain.
    final band = Paint()..color = const Color(0x0A000000);
    for (var y = 0.0; y < size.height; y += 26) {
      canvas.drawRect(Rect.fromLTWH(0, y, size.width, 9), band);
    }
    // Speckle: the same scatter every frame (seeded), never a shimmer.
    final rnd = math.Random(58);
    final speck = Paint()..color = const Color(0x14000000);
    final count = (size.width * size.height / 900).round();
    for (var i = 0; i < count; i++) {
      canvas.drawCircle(
        Offset(rnd.nextDouble() * size.width, rnd.nextDouble() * size.height),
        rnd.nextDouble() * 0.9 + 0.3,
        speck,
      );
    }
    canvas.restore();
    if (!dark) {
      canvas.drawPath(
        path,
        Paint()
          ..color = const Color(0x33000000)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1,
      );
    }
  }

  /// The strip with a row of teeth along each tear edge.
  Path _outline(Size size) {
    final w = size.width;
    final h = size.height;
    const tooth = ReceiptSlip.toothWidth;
    const depth = ReceiptSlip.toothDepth;
    final path = Path()..moveTo(0, depth);
    // Top edge, left to right: peaks at every half tooth.
    var x = 0.0;
    var up = true;
    while (x < w) {
      x = math.min(x + tooth / 2, w);
      path.lineTo(x, up ? 0 : depth);
      up = !up;
    }
    path.lineTo(w, h - depth);
    // Bottom edge, right to left.
    x = w;
    up = true;
    while (x > 0) {
      x = math.max(x - tooth / 2, 0);
      path.lineTo(x, up ? h : h - depth);
      up = !up;
    }
    path.close();
    return path;
  }

  @override
  bool shouldRepaint(_PaperPainter oldDelegate) => dark != oldDelegate.dark;
}
