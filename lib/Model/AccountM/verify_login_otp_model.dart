class VerifyLoginOtpModel {
  final bool status;
  final String message;

  VerifyLoginOtpModel({
    required this.status,
    required this.message,
  });

  factory VerifyLoginOtpModel.fromJson(Map<String, dynamic> json) {
    return VerifyLoginOtpModel(
      status: json["status"] ?? false,
      message: json["message"] ?? "",
    );
  }
}
