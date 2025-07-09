class APIKeys {
  static const String baseUrl = "http://safty-zone-env.eba-rhpc9ydc.us-east-1.elasticbeanstalk.com";
  static const String sendOtp = "/api/provider/authentication/send-otp";
  static const String reSendOtp = "/api/provider/authentication/resend-otp";
  static const String verifyOtp = "/api/provider/authentication/verify-otp";
  static const String register = "/api/provider/authentication/register";
  static const String checkAuth = "/api/provider/authentication/check-auth";
  static const String installationsFees = "/api/provider/installation-fees";
  static const String controlPanel =
      "/api/provider/installation-fees/alarm-item/control panel";
  static const String getInstallationStatus =
      "/api/provider/installation-fees/status";
  static const String termAndConditions = "/api/provider/terms-and-condition";
  static const String getFirstEmployee = "/api/provider/employee/first-employee";
  static const String generateImageUrl = "/api/media/generate-url?type=image&count=1";
  static const String generateFileUrl = "/api/media/generate-url?type=file&count=1";
  static const String consumerRequests = "/api/provider/consumer-requests";
  static const String getConsumerRequestDetails = "/api/provider/consumer-requests/{id}";
}
