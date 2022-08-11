import 'package:flutter/material.dart';
import 'package:flutter_bilibili/http/core/hi_error.dart';
import 'package:flutter_bilibili/http/dao/profile_dao.dart';
import 'package:flutter_bilibili/model/index.dart';
import 'package:flutter_bilibili/util/hi_functions.dart';
import 'package:flutter_bilibili/widget/benefit_card.dart';
import 'package:flutter_bilibili/widget/course_card.dart';
import 'package:flutter_bilibili/widget/dark_mode_item.dart';
import 'package:flutter_bilibili/widget/hi_banner.dart';
import 'package:flutter_bilibili/widget/hi_blur.dart';
import 'package:flutter_bilibili/widget/hi_flexible_header.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with AutomaticKeepAliveClientMixin {

  Profile? _profile;
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    //fix Android切换 profile页面状态栏变白问题
    changeStatusBar(color: Colors.transparent);
    return Scaffold(
      body: NestedScrollView(
        controller: _controller,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
          return <Widget>[
            _buildAppBar(),
          ];
        },
        body: ListView(
          padding: const EdgeInsets.only(top: 10),
          children: [...buildContentList()],
        ),
      ),
    );
  }
  
  void _loadData() async {
    try {
      Profile result = await ProfileDao.get();
      setState(() {
        _profile = result;
      });
    } on HiNetError catch (e) {
      hiPrint(e);
      showWarnToast(e.message);
    }
  }
  
  @override
  bool get wantKeepAlive => true;
  
  _buildAppBar() {
      return SliverAppBar(
        expandedHeight: 160,
        pinned: true,
        flexibleSpace: FlexibleSpaceBar(
          collapseMode: CollapseMode.parallax,
          titlePadding: const EdgeInsets.only(left: 0),
          title: _buildHead(),
          background: Stack(
            children: [
              Positioned.fill(child: cachedImage('https://www.devio.org/img/beauty_camera/beauty_camera4.jpg')),
              const Positioned.fill(child: HiBlur(sigma: 20,)),
              Positioned(child: _buildProfileTab(), left: 0, right: 0, bottom: 0,),
            ],
          ),
        ),
      );
  }
  
  _buildHead() {
    if (_profile == null) {
      return Container();
    }
    return HiFlexibleHeader(name: _profile!.name, face: _profile!.face, controller: _controller);
  }
  
  buildContentList() {
    if (_profile == null) {
      return [];
    }
    return [
      _buildBanner(),
      CourseCard(courseList: _profile!.courseList),
      BenefitCard(benefitList: _profile!.benefitList),
      const DarkModelItem(),
    ];
  }
  
  _buildProfileTab() {
    if (_profile == null) {
      return Container();
    }
    var profile = _profile!;
    return Container(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      decoration: const BoxDecoration(color: Colors.white54),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children:[
          _buildIconText('收藏', profile.favorite),
          _buildIconText('点赞', profile.like),
          _buildIconText('浏览', profile.browsing),
          _buildIconText('金币', profile.coin),
          _buildIconText('粉丝', profile.fans),
        ]
      ),
    );
  }
  
  _buildBanner() {
      return HiBanner(_profile!.bannerList, bannerHeight: 120, padding: const EdgeInsets.only(left: 10, right: 10),);
  }

  _buildIconText(String text, int count) {
    return Column(
      children: [
        Text('$count', style: const TextStyle(fontSize: 15, color: Colors.black87),),
        Text(text, style: TextStyle(fontSize: 12, color: Colors.grey[600]),)
      ],
    );
  }

}
