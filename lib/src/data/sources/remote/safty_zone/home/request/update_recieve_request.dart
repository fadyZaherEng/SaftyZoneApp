import 'package:json_annotation/json_annotation.dart';

part 'update_recieve_request.g.dart';

@JsonSerializable()
class UpdateRecieveRequest {
  final String? scheduleJobId;

  const UpdateRecieveRequest({
    this.scheduleJobId,
  });

  factory UpdateRecieveRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateRecieveRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateRecieveRequestToJson(this);
}
