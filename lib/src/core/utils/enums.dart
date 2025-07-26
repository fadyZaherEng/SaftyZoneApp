/// Custom Text-Size Widget
enum TextSizes { small, medium, large }

enum RegisterStatus { Pending, Complete_Register, Home_Page }

enum RequestStatus { pending, accepted, rejected, cancelled, active }
enum ScheduleJobStatusEnum { pending, completed, inProgress }

class SystemType {
  static bool isAlarmType(String type) {
    return type == "alarm-item";
  }

  static bool isFireType(String type) {
    return type == "fire-system-item";
  }

  static bool isExtinguisherType(String type) {
    return type == "fire-extinguisher-item";
  }
}

enum RequestType {
  InstallationCertificate, //  شهادة تركيب
  EngineeringInspection, // فحص هندسي
  MaintenanceContract, // عقد صيانة
  FireExtinguisher, //طفاية حريق
}


enum ScheduleJobStepEnum {
  pending,
  goLocation, //go-location
  receive,
  offer,
  acceptOffer, //accept-offer
  deliver,
}
