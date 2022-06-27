import 'package:flutter/material.dart' hide Banner;
import 'package:flutter_bilibili/model/video.dart';
import 'package:flutter_bilibili/model/banner.dart';
import 'package:flutter_bilibili/navigator/hi_navigator.dart';
import 'package:flutter_bilibili/util/hi_functions.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

class HiBanner extends StatelessWidget {
  final List<Banner> bannerList;
  final double bannerHeight;
  final EdgeInsetsGeometry? padding;

  const HiBanner(this.bannerList, {super.key, this.bannerHeight = 160, this.padding});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: bannerHeight,
      child: _banner(),
    );
  }
  
  _banner() {
    var right = 10 + (padding?.horizontal ?? 0) / 2;
    return Swiper(
      itemBuilder: (BuildContext context, int index){
        return _image(bannerList[index]);
      },
       itemCount: bannerList.length,
       autoplay: true,
       pagination: SwiperPagination(
        alignment: Alignment.bottomRight,
        margin: EdgeInsets.only(right: right, bottom: 10),
        builder: const DotSwiperPaginationBuilder(
          color: Colors.white60,
          size: 6,
          activeSize: 6,
        ),
       ),
      );
  }
  
  _image(Banner banner) {
    return InkWell(
      onTap: (){
        hiPrint(banner.toString());
        handleBannerClick(banner);
      },
      child: Container(
        padding: padding,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          child: Image.network(banner.cover, fit: BoxFit.cover,),
        ),
      ),
    );
  }
  
  void handleBannerClick(Banner banner) {
    hiPrint('type: ${banner.type}, url: ${banner.url}', tag: 'HiBanner');
    if (banner.type == 'video') {
      HiNavigator.getInstance().onJumpTo(RouteStatus.detail, args: {
        'video': Video(vid: banner.url)
      });
    }
  }

}