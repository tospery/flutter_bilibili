// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoDetail _$VideoDetailFromJson(Map<String, dynamic> json) => VideoDetail()
  ..isFavorite = json['isFavorite'] as bool
  ..isLike = json['isLike'] as bool
  ..videoInfo = Video.fromJson(json['videoInfo'] as Map<String, dynamic>)
  ..videoList = (json['videoList'] as List<dynamic>? ?? [])
      .map((e) => Video.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$VideoDetailToJson(VideoDetail instance) =>
    <String, dynamic>{
      'isFavorite': instance.isFavorite,
      'isLike': instance.isLike,
      'videoInfo': instance.videoInfo,
      'videoList': instance.videoList,
    };
