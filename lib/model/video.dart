import 'package:flutter_bilibili/model/owner.dart';

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

  factory Video.fromJson(Map<String,dynamic> json) => Video()
    ..id = json['id'] as String
    ..vid = json['vid'] as String
    ..title = json['title'] as String
    ..tname = json['tname'] as String
    ..url = json['url'] as String
    ..cover = json['cover'] as String
    ..pubdate = json['pubdate'] as num
    ..desc = json['desc'] as String
    ..view = json['view'] as num
    ..duration = json['duration'] as num
    ..owner = Owner.fromJson(json['owner'] as Map<String, dynamic>)
    ..reply = json['reply'] as num
    ..favorite = json['favorite'] as num
    ..like = json['like'] as num
    ..coin = json['coin'] as num
    ..share = json['share'] as num
    ..createTime = json['createTime'] as String
    ..size = json['size'] as num;
  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'vid': vid,
    'title': title,
    'tname': tname,
    'url': url,
    'cover': cover,
    'pubdate': pubdate,
    'desc': desc,
    'view': view,
    'duration': duration,
    'owner': owner,
    'reply': reply,
    'favorite': favorite,
    'like': like,
    'coin': coin,
    'share': share,
    'createTime': createTime,
    'size': size,
  };
}
