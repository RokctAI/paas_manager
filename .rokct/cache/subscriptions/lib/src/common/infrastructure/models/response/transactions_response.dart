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


/// Response of the subscription transaction-creation endpoint.
///
/// Owned by subscriptions_sdk so the facade carries no compile dependency on
/// wallet_sdk. The purchase flow currently only branches on the request's
/// success/failure; the raw `data` payload is kept available for callers
/// that need transaction details.
class SubscriptionTransactionsResponse {
  final Map<String, dynamic>? data;

  SubscriptionTransactionsResponse({this.data});

  factory SubscriptionTransactionsResponse.fromJson(dynamic json) {
    if (json is! Map<String, dynamic>) {
      return SubscriptionTransactionsResponse();
    }
    final data = json['data'];
    return SubscriptionTransactionsResponse(
      data: data is Map<String, dynamic> ? data : null,
    );
  }

  Map<String, dynamic> toJson() => {'data': data};
}
