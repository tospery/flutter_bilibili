import 'package:json_annotation/json_annotation.dart';
import "video.dart";
part 'video_detail.g.dart';

@JsonSerializable()
class VideoDetail {
  VideoDetail();

  late bool isFavorite;
  late bool isLike;
  late Video videoInfo;
  late List<Video> videoList;
  
  factory VideoDetail.fromJson(Map<String,dynamic> json) => _$VideoDetailFromJson(json);
  Map<String, dynamic> toJson() => _$VideoDetailToJson(this);
}
