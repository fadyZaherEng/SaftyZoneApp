import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Requests extends Equatable {
  final int id;
  final String companyName;
  final String image;
  final String city;
  final String status;
  final String type;
  final Color statusColor;
  final int visits;

  const Requests({
    required this.id,
    required this.companyName,
    required this.image,
    required this.city,
    required this.status,
    required this.statusColor,
    required this.visits,
    this.type = '',
  });

  @override
  List<Object?> get props => [
        id,
        companyName,
        image,
        city,
        status,
        statusColor,
        visits,
        type,
      ];
}

class RequestDetailsModel {
  String systemType;
  String area;
  String quantities;
  String terms;

  RequestDetailsModel({
    this.systemType = '',
    this.area = '',
    this.quantities = '',
    this.terms = '',
  });
}
