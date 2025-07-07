import 'package:equatable/equatable.dart';

class Employee extends Equatable {
  final String fullName;
  final String phoneNumber;
  final String profileImage;
  final bool isDeleted;
  final String jobTitle;
  final int createdAt;
  final String Id;
  final String employeeType;
  final String permission;
  final String company;
  final int V;
  final String photoPath;
  final String functionalTitle;
  final List<String> tasks;
  final String notes;

  const Employee({
    this.fullName = '',
    this.phoneNumber = '',
    this.profileImage = '',
    this.isDeleted = false,
    this.jobTitle = '',
    this.createdAt = 0,
    this.Id = '',
    this.employeeType = '',
    this.permission = '',
    this.company = '',
    this.V = 0,
    this.photoPath = '',
    this.functionalTitle = '',
    this.tasks = const [],
    this.notes = '',
  });

  @override
  List<Object?> get props => [
        fullName,
        phoneNumber,
        profileImage,
        isDeleted,
        jobTitle,
        createdAt,
        Id,
        employeeType,
        permission,
        company,
        V,
        photoPath,
        functionalTitle,
        tasks,
        notes
      ];

  //copyWith
  Employee copyWith({
    String? fullName,
    String? phoneNumber,
    String? profileImage,
    bool? isDeleted,
    String? jobTitle,
    int? createdAt,
    String? Id,
    String? employeeType,
    String? permission,
    String? company,
    int? V,
    String? photoPath,
    String? functionalTitle,
    List<String>? tasks,
    String? notes,
  }) {
    return Employee(
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profileImage: profileImage ?? this.profileImage,
      isDeleted: isDeleted ?? this.isDeleted,
      jobTitle: jobTitle ?? this.jobTitle,
      createdAt: createdAt ?? this.createdAt,
      Id: Id ?? this.Id,
      employeeType: employeeType ?? this.employeeType,
      permission: permission ?? this.permission,
      company: company ?? this.company,
      V: V ?? this.V,
      photoPath: photoPath ?? this.photoPath,
      functionalTitle: functionalTitle ?? this.functionalTitle,
      tasks: tasks ?? this.tasks,
      notes: notes ?? this.notes,
    );
  }

  //fromJson
  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      fullName: json['fullName'],
      phoneNumber: json['phoneNumber'],
      profileImage: json['profileImage'],
      isDeleted: json['isDeleted'],
      jobTitle: json['jobTitle'],
      createdAt: json['createdAt'],
      Id: json['_id'] ?? json['Id'],
      employeeType: json['employeeType'],
      permission: json['permission'],
      company: json['company'],
      V: json['__v'],
      photoPath: json['photoPath'],
      functionalTitle: json['functionalTitle'],
      tasks: json['tasks'],
      notes: json['notes'],
    );
  }

  factory Employee.fromJsonTerms(Map<String, dynamic> json) {
    return Employee(
      fullName: json['fullName'],
      phoneNumber: json['phoneNumber'],
      profileImage: json['profileImage'],
      isDeleted: json['isDeleted'],
      jobTitle: json['jobTitle'],
      createdAt: json['createdAt'],
      Id: json['_id'],
      employeeType: json['employeeType'],
      permission: json['permission'],
      company: json['company'],
      V: json['__v'],
    );
  }
}
