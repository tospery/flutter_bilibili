// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ranking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ranking _$RankingFromJson(Map<String, dynamic> json) => Ranking()
  ..total = json['total'] as int
  ..list = (json['list'] as List<dynamic>? ?? [])
      .map((e) => Video.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$RankingToJson(Ranking instance) => <String, dynamic>{
      'total': instance.total,
      'list': instance.list,
    };
