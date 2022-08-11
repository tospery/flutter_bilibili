// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile()
  ..name = json['name'] as String
  ..face = json['face'] as String
  ..fans = json['fans'] as int
  ..favorite = json['favorite'] as int
  ..like = json['like'] as int
  ..coin = json['coin'] as int
  ..browsing = json['browsing'] as int
  ..bannerList = (json['bannerList'] as List<dynamic>? ?? [])
      .map((e) => Banner.fromJson(e as Map<String, dynamic>))
      .toList()
  ..courseList = (json['courseList'] as List<dynamic>? ?? [])
      .map((e) => Course.fromJson(e as Map<String, dynamic>))
      .toList()
  ..benefitList = (json['benefitList'] as List<dynamic>? ?? [])
      .map((e) => Benefit.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'name': instance.name,
      'face': instance.face,
      'fans': instance.fans,
      'favorite': instance.favorite,
      'like': instance.like,
      'coin': instance.coin,
      'browsing': instance.browsing,
      'bannerList': instance.bannerList,
      'courseList': instance.courseList,
      'benefitList': instance.benefitList,
    };
