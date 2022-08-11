// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Video _$VideoFromJson(Map<String, dynamic> json) => Video()
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

Map<String, dynamic> _$VideoToJson(Video instance) => <String, dynamic>{
      'id': instance.id,
      'vid': instance.vid,
      'title': instance.title,
      'tname': instance.tname,
      'url': instance.url,
      'cover': instance.cover,
      'pubdate': instance.pubdate,
      'desc': instance.desc,
      'view': instance.view,
      'duration': instance.duration,
      'owner': instance.owner,
      'reply': instance.reply,
      'favorite': instance.favorite,
      'like': instance.like,
      'coin': instance.coin,
      'share': instance.share,
      'createTime': instance.createTime,
      'size': instance.size,
    };
