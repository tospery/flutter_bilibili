import 'package:flutter/material.dart';
import 'package:flutter_bilibili/model/video.dart';
import 'package:flutter_bilibili/util/hi_functions.dart';

class VideoCard extends StatelessWidget {
  final Video video;

  const VideoCard({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        hiPrint(video.url);
      },
      child: Image.network(video.cover),
    );
  }
}