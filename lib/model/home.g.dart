// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Home _$HomeFromJson(Map<String, dynamic> json) => Home()
  ..bannerList = (json['bannerList'] as List<dynamic>? ?? [])
      .map((e) => Banner.fromJson(e as Map<String, dynamic>))
      .toList()
  ..categoryList = (json['categoryList'] as List<dynamic>? ?? [])
      .map((e) => Category.fromJson(e as Map<String, dynamic>))
      .toList()
  ..videoList = (json['videoList'] as List<dynamic>? ?? [])
      .map((e) => Video.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$HomeToJson(Home instance) => <String, dynamic>{
      'bannerList': instance.bannerList,
      'categoryList': instance.categoryList,
      'videoList': instance.videoList,
    };
