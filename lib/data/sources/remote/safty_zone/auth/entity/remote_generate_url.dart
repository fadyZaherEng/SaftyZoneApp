import 'package:json_annotation/json_annotation.dart';

part 'remote_generate_url.g.dart';

@JsonSerializable()
class RemoteGenerateUrl {
  final String? presignedURL;
  final String? mediaUrl;

  const RemoteGenerateUrl({
    this.presignedURL,
    this.mediaUrl,
  });

  factory RemoteGenerateUrl.fromJson(Map<String, dynamic> json) =>
      _$RemoteGenerateUrlFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteGenerateUrlToJson(this);
}
