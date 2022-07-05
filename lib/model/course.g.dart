// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Course _$CourseFromJson(Map<String, dynamic> json) => Course()
  ..name = json['name'] as String
  ..cover = json['cover'] as String
  ..url = json['url'] as String
  ..group = json['group'] as int;

Map<String, dynamic> _$CourseToJson(Course instance) => <String, dynamic>{
      'name': instance.name,
      'cover': instance.cover,
      'url': instance.url,
      'group': instance.group,
    };
