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

// ApiResult's `when` lives in the freezed extension declared by this
// library, so the import is load-bearing even though no type is named.
import 'package:base_sdk/src/handlers/api_result.dart';
import 'package:merchants_sdk/src/manager/domain/interface/pos_orders.dart';
import 'package:merchants_sdk/src/manager/utils/pos_receipt_printer.dart';

/// Why a finish did not record the sale.
class PosSaleFinishFailure {
  /// The printer threw — the sale stays open (atomic print-then-record).
  const PosSaleFinishFailure.print()
      : printFailed = true,
        message = null;

  /// The offline-first submit refused (a local storage failure) —
  /// [message] is the facade's text, null for the generic server line.
  const PosSaleFinishFailure.submit(this.message) : printFailed = false;

  final bool printFailed;
  final String? message;
}

/// ONE finish pipeline for the checkout's dual finish (chips 293/294)
/// and the receipt preview's (frames 11k/11r): the sale as the checkout
/// snapshotted it when the operator tapped — the receipt lines, the
/// total and the offline-first [draft] — run in the ONE order Ray's
/// rulings fixed: print FIRST (only when asked) and record ONLY after the
/// printer returned, so a dead printer leaves the sale open instead of
/// silently eating the receipt (the retired Spazafy checkout recorded
/// first). The submit is the existing PosOrdersFacade.submitSale — local
/// drift store, then the SyncEngine queue — so nothing here waits on the
/// network.
///
/// A plain value, deliberately: the receipt preview is pushed ABOVE the
/// checkout on a phone (11k) and REPLACES it in the till's planes (11r,
/// "checkout POPS off the stack"), so the pipeline cannot live in the
/// checkout's widget state. Cart clearing (posCartProvider.finishSale)
/// stays with the caller — it owns the provider.
class PosSaleFinish {
  const PosSaleFinish({
    required this.orderId,
    required this.lines,
    required this.total,
    required this.draft,
  });

  final String orderId;

  /// Exactly what PosReceiptPrinter prints — no unit price is invented.
  final List<PosReceiptLine> lines;
  final double total;

  /// Null when no PosOrdersFacade is registered: the checkout degrades
  /// honestly to a local-only completion (demo builds register the mock).
  final PosSaleDraft? draft;

  /// Print (when [withReceipt]) THEN submit. Null means the sale is
  /// recorded; the caller clears the cart and leaves.
  Future<PosSaleFinishFailure?> run({
    required bool withReceipt,
    required PosOrdersFacade? facade,
  }) async {
    if (withReceipt) {
      try {
        await PosReceiptPrinter.print(orderId, lines, total);
      } catch (_) {
        return const PosSaleFinishFailure.print();
      }
    }
    final pending = draft;
    if (facade != null && pending != null) {
      final result = await facade.submitSale(pending);
      var submitted = false;
      String? failure;
      result.when(
        success: (_) => submitted = true,
        failure: (error, statusCode) => failure = error,
      );
      if (!submitted) return PosSaleFinishFailure.submit(failure);
    }
    return null;
  }
}
