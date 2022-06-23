import 'package:json_annotation/json_annotation.dart';

part 'banner.g.dart';

@JsonSerializable()
class Banner {
  Banner();

  late String id;
  late num sticky;
  late String type;
  late String title;
  late String subtitle;
  late String url;
  late String cover;
  late String createTime;
  
  factory Banner.fromJson(Map<String,dynamic> json) => _$BannerFromJson(json);
  Map<String, dynamic> toJson() => _$BannerToJson(this);
}
