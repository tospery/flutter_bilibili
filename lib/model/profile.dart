import 'package:json_annotation/json_annotation.dart';
import "banner.dart";
import "course.dart";
import "benefit.dart";
part 'profile.g.dart';

@JsonSerializable()
class Profile {
  Profile();

  late String name;
  late String face;
  @JsonKey(name: 'fans') late int fans;
  @JsonKey(name: 'favorite') late int favorite;
  @JsonKey(name: 'like') late int like;
  @JsonKey(name: 'coin') late int coin;
  @JsonKey(name: 'browsing') late int browsing;
  late List<Banner> bannerList;
  late List<Course> courseList;
  late List<Benefit> benefitList;
  
  factory Profile.fromJson(Map<String,dynamic> json) => _$ProfileFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
