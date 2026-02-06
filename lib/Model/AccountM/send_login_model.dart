class SendLoginResponseModel {
  final bool status;
  final String message;
  final String? otp;

  SendLoginResponseModel({
    required this.status,
    required this.message,
    this.otp,
  });

  factory SendLoginResponseModel.fromJson(Map<String, dynamic> json) {
    return SendLoginResponseModel(
      status: json["status"] ?? false,
      message: json["message"] ?? "",
      otp: json["otp"]?.toString(),
    );
  }
}
