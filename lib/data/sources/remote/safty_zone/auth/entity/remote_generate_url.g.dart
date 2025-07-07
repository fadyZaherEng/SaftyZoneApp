// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_generate_url.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteGenerateUrl _$RemoteGenerateUrlFromJson(Map<String, dynamic> json) =>
    RemoteGenerateUrl(
      presignedURL: json['presignedURL'] as String?,
      mediaUrl: json['mediaUrl'] as String?,
    );

Map<String, dynamic> _$RemoteGenerateUrlToJson(RemoteGenerateUrl instance) =>
    <String, dynamic>{
      'presignedURL': instance.presignedURL,
      'mediaUrl': instance.mediaUrl,
    };
