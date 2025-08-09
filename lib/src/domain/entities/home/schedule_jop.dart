import 'package:equatable/equatable.dart';
import 'package:safety_zone/src/domain/entities/home/requests.dart';

class ScheduleJop extends Equatable {
  final String Id;
  final String provider;
  final String consumer;
  final String consumerRequest;
  final Branch branch;
  final String offer;
  final Employee responseEmployee;
  final String requestNumber;
  final String type;
  final String status;
  final int visitDate;
  final int createdAt;
  final int V;
  final String step;
  final String receiveItem;

  const ScheduleJop({
    this.Id = "",
    this.provider = "",
    this.consumer = "",
    this.branch = const Branch(),
    this.offer = "",
    this.responseEmployee = const Employee(),
    this.requestNumber = "",
    this.type = "",
    this.status = "",
    this.visitDate = 0,
    this.createdAt = 0,
    this.V = 0,
    this.step = "",
    this.receiveItem = "",
    this.consumerRequest = "",
  });

  @override
  List<Object?> get props => [
        Id,
        provider,
        consumer,
        branch,
        offer,
        responseEmployee,
        requestNumber,
        type,
        status,
        visitDate,
        createdAt,
        V,
        step,
        receiveItem,
        consumerRequest,
      ];
}
