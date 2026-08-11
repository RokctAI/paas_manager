class PrinterResponse {
  final bool isSuccess;
  final String? message;
  final dynamic data;

  PrinterResponse({required this.isSuccess, this.message, this.data});

  factory PrinterResponse.success({dynamic data}) =>
      PrinterResponse(isSuccess: true, data: data);
  factory PrinterResponse.failure(String message) =>
      PrinterResponse(isSuccess: false, message: message);
}
