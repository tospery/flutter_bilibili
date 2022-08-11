import 'package:json_annotation/json_annotation.dart';

part 'benefit.g.dart';

@JsonSerializable()
class Benefit {
  Benefit();

  late String name;
  late String url;
  
  factory Benefit.fromJson(Map<String,dynamic> json) => _$BenefitFromJson(json);
  Map<String, dynamic> toJson() => _$BenefitToJson(this);
}
