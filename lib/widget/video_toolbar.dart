import 'package:flutter/material.dart';
import 'package:flutter_bilibili/model/index.dart';
import 'package:flutter_bilibili/util/color.dart';
import 'package:flutter_bilibili/util/hi_functions.dart';

class VideoToolBar extends StatelessWidget {
  final Video video;
  final VideoDetail? videoDetail;
  final VoidCallback? onLike;
  final VoidCallback? onUnLike;
  final VoidCallback? onCoin;
  final VoidCallback? onFavorite;
  final VoidCallback? onShare;

  const VideoToolBar({super.key, required this.video, required this.videoDetail, this.onLike, this.onUnLike, this.onCoin, this.onFavorite, this.onShare});

  @override
  Widget build(BuildContext context) {
      return Container(
        padding: const EdgeInsets.only(top: 15, bottom: 10),
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(border: borderLine(context)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildIconText(Icons.thumb_up_alt_rounded, video.like, onClick: onLike, tint: videoDetail?.isLike ?? false),
            _buildIconText(Icons.thumb_down_alt_rounded, '不喜欢', onClick: onUnLike),
            _buildIconText(Icons.monetization_on, video.coin, onClick: onCoin),
            _buildIconText(Icons.grade_rounded, video.favorite, onClick: onFavorite, tint: videoDetail?.isFavorite ?? false),
            _buildIconText(Icons.share_rounded, video.share, onClick: onShare),
          ],
        ),
      );
  }
  
  _buildIconText(IconData iconData, text, {VoidCallback? onClick, bool tint = false}) {
    if (text is int) {
      text = countFormat(text);
    } else {
      text ??= '';
    }
    return InkWell(
      onTap: onClick,
      child: Column(
        children: [
          Icon(iconData, color: tint ? primary : Colors.grey, size: 20,),
          hiSpace(height: 5),
          Text(text, style: const TextStyle(color: Colors.grey, fontSize: 12),)
        ],
      ),
    );
  }
}