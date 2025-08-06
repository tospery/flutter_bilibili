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

  factory Banner.fromJson(Map<String,dynamic> json) => Banner()
    ..id = json['id'] as String
    ..sticky = json['sticky'] as num
    ..type = json['type'] as String
    ..title = json['title'] as String
    ..subtitle = json['subtitle'] as String
    ..url = json['url'] as String
    ..cover = json['cover'] as String
    ..createTime = json['createTime'] as String;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'sticky': sticky,
    'type': type,
    'title': title,
    'subtitle': subtitle,
    'url': url,
    'cover': cover,
    'createTime': createTime,
  };
}