// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Video _$VideoFromJson(Map<String, dynamic> json) => Video()
  ..id = json['id'] as String
  ..vid = json['vid'] as String
  ..title = json['title'] as String
  ..tname = json['tname'] as String
  ..url = json['url'] as String
  ..cover = json['cover'] as String;

Map<String, dynamic> _$VideoToJson(Video instance) => <String, dynamic>{
      'id': instance.id,
      'vid': instance.vid,
      'title': instance.title,
      'tname': instance.tname,
      'url': instance.url,
      'cover': instance.cover,
    };
