// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Banner _$BannerFromJson(Map<String, dynamic> json) => Banner()
  ..id = json['id'] as String
  ..sticky = json['sticky'] as num
  ..type = json['type'] as String
  ..title = json['title'] as String
  ..subtitle = json['subtitle'] as String
  ..url = json['url'] as String
  ..cover = json['cover'] as String
  ..createTime = json['createTime'] as String;

Map<String, dynamic> _$BannerToJson(Banner instance) => <String, dynamic>{
      'id': instance.id,
      'sticky': instance.sticky,
      'type': instance.type,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'url': instance.url,
      'cover': instance.cover,
      'createTime': instance.createTime,
    };
