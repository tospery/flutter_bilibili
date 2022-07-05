import 'package:json_annotation/json_annotation.dart';
import "video.dart";
part 'ranking.g.dart';

@JsonSerializable()
class Ranking {
  Ranking();

  @JsonKey(name: 'total') late int total;
  late List<Video> list;
  
  factory Ranking.fromJson(Map<String,dynamic> json) => _$RankingFromJson(json);
  Map<String, dynamic> toJson() => _$RankingToJson(this);
}
