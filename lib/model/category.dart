class Category {
  Category();

  late String name;
  late num count;

  factory Category.fromJson(Map<String,dynamic> json) => Category()
    ..name = json['name'] as String
    ..count = json['count'] as num;
  Map<String, dynamic> toJson() => <String, dynamic>{
    'name': name,
    'count': count,
  };
}