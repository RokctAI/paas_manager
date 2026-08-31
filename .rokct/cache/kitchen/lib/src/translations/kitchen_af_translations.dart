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


// Bundled Afrikaans (af) UI strings covering this SDK's manifest.json tr_keys backend keys.
// Keys are BACKEND translation keys (the values TrKeys constants hold),
// not Dart field names. Served-translation rows from the backend always
// win; these values are the offline/unseeded fallback consulted by
// base_sdk's BundledTranslations registry before the humanized-key
// fallback. Generated from the SDK's key set; keep in sync when keys
// change. Locale 'af' is left-to-right.
const Map<String, String> kKitchenAfTranslations = {
  'kitchen': 'Kombuis',
  'kitchens': 'Kombuise',
  // Manager Kitchen screen (1.3.0, approved frames 34a-34d).
  'live': 'lewendig',
  'just_in': 'Pas ontvang',
  'delayed': 'Vertraag',
  'preparing': 'Berei voor',
  'dish': 'gereg',
  'dishes': 'geregte',
  'customer_note': 'Klantnota',
  'mark_order_ready': 'Merk bestelling gereed',
  'start_cooking': 'Begin kook',
  'hand_over': 'Oorhandig',
  'tap_a_dish_to_advance_double_tap_cancels':
      'Tik \'n gereg om aan te beweeg · dubbeltik kanselleer dit',
};
