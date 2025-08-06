import 'package:flutter_bilibili/model/banner.dart';
import 'package:flutter_bilibili/model/category.dart';
import 'package:flutter_bilibili/model/video.dart' show Video;

class Home {
  Home();

  late List<Banner> bannerList;
  late List<Category> categoryList;
  late List<Video> videoList;

  factory Home.fromJson(Map<String,dynamic> json) => Home()
    ..bannerList = (json['bannerList'] as List<dynamic>? ?? [])
        .map((e) => Banner.fromJson(e as Map<String, dynamic>))
        .toList()
    ..categoryList = (json['categoryList'] as List<dynamic>? ?? [])
        .map((e) => Category.fromJson(e as Map<String, dynamic>))
        .toList()
    ..videoList = (json['videoList'] as List<dynamic>? ?? [])
        .map((e) => Video.fromJson(e as Map<String, dynamic>))
        .toList();
  Map<String, dynamic> toJson() => <String, dynamic>{
    'bannerList': bannerList,
    'categoryList': categoryList,
    'videoList': videoList,
  };
}