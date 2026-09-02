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

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:base_sdk/src/presentation/theme/app_style.dart';
import 'package:base_sdk/src/services/app_helpers.dart';
import 'package:base_sdk/src/services/local_storage.dart';
import 'package:base_sdk/src/services/tr_keys.dart';

/// Small dialogs the manager booking screens share.

class BookingPromptField {
  final String key;
  final String label;
  final bool numeric;
  final String initial;

  const BookingPromptField({
    required this.key,
    required this.label,
    this.numeric = false,
    this.initial = '',
  });
}

/// A dialog with one text field per [fields]; resolves to the values by
/// key, or null when dismissed.
Future<Map<String, String>?> promptBookingFields(
  BuildContext context, {
  required String title,
  required List<BookingPromptField> fields,
}) async {
  final isDark = LocalStorage.getAppThemeMode();
  final controllers = {
    for (final f in fields) f.key: TextEditingController(text: f.initial),
  };
  final textColor = isDark ? AppStyle.white : AppStyle.black;
  final result = await showDialog<Map<String, String>>(
    context: context,
    builder: (ctx) => AlertDialog(
      backgroundColor: isDark ? AppStyle.mainBackDark : AppStyle.white,
      title: Text(title, style: AppStyle.interSemi(size: 16, color: textColor)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final f in fields)
            Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: TextField(
                controller: controllers[f.key],
                keyboardType:
                    f.numeric ? TextInputType.number : TextInputType.text,
                autofocus: f == fields.first,
                style: AppStyle.interNormal(size: 14, color: textColor),
                decoration: InputDecoration(
                  labelText: f.label,
                  labelStyle:
                      AppStyle.interNormal(size: 13, color: AppStyle.textGrey),
                ),
              ),
            ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(),
          child: Text(AppHelpers.getTranslation(TrKeys.cancel)),
        ),
        TextButton(
          onPressed: () => Navigator.of(ctx).pop({
            for (final e in controllers.entries) e.key: e.value.text.trim(),
          }),
          child: Text(
            AppHelpers.getTranslation(TrKeys.save),
            style: AppStyle.interSemi(size: 14, color: AppStyle.primary),
          ),
        ),
      ],
    ),
  );
  for (final c in controllers.values) {
    c.dispose();
  }
  return result;
}

/// Yes / no confirmation.
Future<bool> confirmBooking(
  BuildContext context, {
  required String title,
  String? body,
}) async {
  final isDark = LocalStorage.getAppThemeMode();
  final ok = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      backgroundColor: isDark ? AppStyle.mainBackDark : AppStyle.white,
      title: Text(
        title,
        style: AppStyle.interSemi(
          size: 16,
          color: isDark ? AppStyle.white : AppStyle.black,
        ),
      ),
      content: body == null
          ? null
          : Text(
              body,
              style: AppStyle.interNormal(size: 14, color: AppStyle.textGrey),
            ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(false),
          child: Text(AppHelpers.getTranslation(TrKeys.cancel)),
        ),
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(true),
          child: Text(
            AppHelpers.getTranslation(TrKeys.yes),
            style: AppStyle.interSemi(size: 14, color: AppStyle.red),
          ),
        ),
      ],
    ),
  );
  return ok ?? false;
}

/// Time picker returning the Frappe Time form "HH:mm:00", or null.
Future<String?> pickBookingClock(BuildContext context, String current) async {
  final parts = current.split(':');
  final initial = TimeOfDay(
    hour: int.tryParse(parts.isNotEmpty ? parts[0] : '') ?? 10,
    minute: int.tryParse(parts.length > 1 ? parts[1] : '') ?? 0,
  );
  final picked = await showTimePicker(context: context, initialTime: initial);
  if (picked == null) return null;
  return '${picked.hour.toString().padLeft(2, '0')}:'
      '${picked.minute.toString().padLeft(2, '0')}:00';
}
