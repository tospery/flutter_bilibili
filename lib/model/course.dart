import 'package:json_annotation/json_annotation.dart';

part 'course.g.dart';

@JsonSerializable()
class Course {
  Course();

  late String name;
  late String cover;
  late String url;
  @JsonKey(name: 'group') late int group;
  
  factory Course.fromJson(Map<String,dynamic> json) => _$CourseFromJson(json);
  Map<String, dynamic> toJson() => _$CourseToJson(this);
}
