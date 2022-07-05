import 'package:flutter/material.dart';
import 'package:flutter_bilibili/http/core/hi_error.dart';
import 'package:flutter_bilibili/http/dao/profile_dao.dart';
import 'package:flutter_bilibili/model/index.dart';
import 'package:flutter_bilibili/util/hi_functions.dart';
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
        body: ListView.builder(itemBuilder: (BuildContext context, int index){
          return ListTile(title: Text('标题$index'),);
        }),
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
              const Positioned.fill(child: HiBlur(sigma: 20,))
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
}
