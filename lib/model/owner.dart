class Owner {
  Owner();

  late String name;
  late String face;
  late num fans;

  factory Owner.fromJson(Map<String,dynamic> json) => Owner()
    ..name = json['name'] as String
    ..face = json['face'] as String
    ..fans = json['fans'] as num;
  Map<String, dynamic> toJson() => <String, dynamic>{
    'name': name,
    'face': face,
    'fans': fans,
  };

}
