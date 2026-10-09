## 1.3.3

* fix(android): flutter_braintree resolves to a vendored copy of 4.0.0
  (`third_party/flutter_braintree`, MIT, upstream LICENSE kept) with the
  v1-embedding `registerWith(Registrar)` methods removed. Current Flutter no
  longer ships `PluginRegistry.Registrar`, so the pub.dev 4.0.0 (the newest
  release) failed every Android release build. The v2 `FlutterPlugin` /
  `ActivityAware` paths are unchanged.

## 1.3.2

* fix(icons): Material `Icons.*` replaced with Remixicon (`Remix.*`) per
  the fleet icon standard; adds the `remixicon: ^1.4.1` dependency.

## 1.3.1

* fix(cards): PaymentsRepository calls the platform gateway
  (`api.payment.*`) instead of the legacy `/api/method/paas.api.payment.*`
  URLs. getSavedCards reads the bare list the backend returns,
  tokenizeCard reads `name` from the returned map, and the saved-card and
  direct-card charges create the order first and send its id (they sent
  the cart id). Needs the orders SDK's `ordersRepository` registered.

## 1.3.0

* feat(braintree): native Braintree checkout on Android and iOS.
  `BraintreeNativeCheckout.pay(targetType, targetId)` fetches a client token
  (`api.payment.braintree_client_token`), opens Braintree's drop-in (cards,
  PayPal, Google Pay, and Apple Pay when `APPLE_PAY_MERCHANT_ID` is set at
  build time) and sends the nonce and device data to
  `api.payment.braintree_checkout`. The server charges the document's own
  amount and currency. Adds `flutter_braintree` ^4.0.0 (MIT).
* The flow is registered for other SDKs in GetIt as a `BraintreeNativeSeam` function named
  `payments.braintree_native_checkout`. On web and desktop, or when the
  drop-in cannot start, it answers `unavailable` so callers keep their
  WebView path. No WebView path changes.

## 1.2.3

* Dark mode: the saved-card tile and the Windows PayFast app bar now use
  `AppStyle.cardFor(brightness)` instead of the fixed dark card colour.

## 1.2.2

* fix(payfast): cancelling on PayFast no longer reports the payment as
  successful. Failure is decided first, markers are matched on the URL path
  only, PayFast's own pages are never a completion, and the own-site fallback
  compares hosts.
* fix(payfast): the PayFast passphrase, merchant key, signature, customer
  details, card token and card details are no longer written to device logs.
  Logged URLs are cut to scheme, host and path.

## 1.2.0

* Saved-card payment no longer handles the gateway reuse credential.
  `get_saved_cards` and `tokenize_card` stopped returning it, so
  `processTokenPayment` names the card by its docname and sends it on
  `saved_card`, and `tokenizeCard` returns the new card's docname. The
  credential is resolved server-side. Requires the matching wallet
  backend: an older backend reads `token` and will reject the charge
  rather than charge the wrong thing.

## 1.1.1

* Baseline: first CHANGELOG entry for this SDK. Earlier versions
  predate the file.
