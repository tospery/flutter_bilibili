import 'package:json_annotation/json_annotation.dart';

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
  
  factory Video.fromJson(Map<String,dynamic> json) => _$VideoFromJson(json);
  Map<String, dynamic> toJson() => _$VideoToJson(this);
}
