import 'package:json_annotation/json_annotation.dart';
import "banner.dart";
import "category.dart";
import "video.dart";
part 'home.g.dart';

@JsonSerializable()
class Home {
  Home();

  late List<Banner> bannerList;
  late List<Category> categoryList;
  late List<Video> videoList;
  
  factory Home.fromJson(Map<String,dynamic> json) => _$HomeFromJson(json);
  Map<String, dynamic> toJson() => _$HomeToJson(this);
}
