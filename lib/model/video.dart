import 'package:json_annotation/json_annotation.dart';
import "owner.dart";
part 'video.g.dart';

@JsonSerializable()
class Video {
  Video({this.vid = ''});

  late String id;
  late String vid;
  late String title;
  late String tname;
  late String url;
  late String cover;
  late num pubdate;
  late String desc;
  late num view;
  late num duration;
  late Owner owner;
  late num reply;
  late num favorite;
  late num like;
  late num coin;
  late num share;
  late String createTime;
  late num size;
  
  factory Video.fromJson(Map<String,dynamic> json) => _$VideoFromJson(json);
  Map<String, dynamic> toJson() => _$VideoToJson(this);
}
