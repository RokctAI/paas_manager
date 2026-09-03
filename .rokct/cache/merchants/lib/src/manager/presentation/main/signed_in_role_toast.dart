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

import 'package:flutter/widgets.dart';
import 'package:base_sdk/src/services/app_helpers.dart';
import 'package:base_sdk/src/services/local_storage.dart';
import 'package:base_sdk/src/services/tr_keys.dart';

/// The one-line "Signed in as seller" / "Signed in as admin" /
/// "Signed in as System Manager" toast the manager shell shows on its
/// first frame after sign-in.
///
/// The manager `session_policy` admits more than one role now (seller,
/// admin - the demo mock's string - and System Manager - the string users'
/// real api.user.login sends for the tenant owner - all land on /main;
/// Ray 2026-09-02 15:56Z "if you decide to
/// lift gate you can just do a toast saying you are seller, admin etc"),
/// so the landing page says which one the session is. auth_sdk's
/// DeclaredSessionPolicy lands the route and knows nothing of this SDK;
/// the installed main_page.dart template calls [showOnce] from its first
/// post-frame callback instead.
///
/// ONE toast per session: the gate is keyed on the session token, so a
/// re-mount of the shell in the same session (tab switch, hot restart of
/// the route) never repeats it, while a fresh sign-in in the same process
/// - a new token - shows it again. Role-less sessions (offline logins,
/// a backend that sent no role) show nothing.
class SignedInRoleToast {
  SignedInRoleToast._();

  static String? _shownForToken;

  /// The message for [role], or null when there is nothing to say.
  /// Built from the manager tr_key `signedInAs` ("Signed in as") plus the
  /// role string exactly as the backend sent it - the same value the
  /// session policy matched - so it reads "Signed in as seller".
  static String? messageFor(String? role) {
    final r = role?.trim();
    if (r == null || r.isEmpty) return null;
    return '${AppHelpers.getTranslation(TrKeys.signedInAs)} $r';
  }

  /// Whether [token]'s toast is still owed. Claims it, so the next call
  /// for the same token answers false. Empty tokens (no session) never
  /// claim.
  static bool claim(String token) {
    if (token.isEmpty || token == _shownForToken) return false;
    _shownForToken = token;
    return true;
  }

  /// Show the toast for the current session once. Safe to call on every
  /// mount of the landing page.
  static void showOnce(BuildContext context) {
    final message = messageFor(LocalStorage.getUser()?.role);
    if (message == null) return;
    if (!claim(LocalStorage.getToken())) return;
    AppHelpers.showCheckTopSnackBarDone(context, message);
  }

  @visibleForTesting
  static void reset() => _shownForToken = null;
}
