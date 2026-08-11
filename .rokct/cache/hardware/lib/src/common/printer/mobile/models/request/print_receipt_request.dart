class PrintReceiptRequest {
  final String shopName;
  final String address1;
  final String address2;
  final String phone;
  final List<Map<String, dynamic>> items;
  final double total;
  final String footer;

  PrintReceiptRequest({
    required this.shopName,
    required this.address1,
    required this.address2,
    required this.phone,
    required this.items,
    required this.total,
    required this.footer,
  });
}
