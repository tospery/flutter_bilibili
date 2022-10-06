import 'package:flutter/material.dart';
import 'package:flutter_bilibili/model/index.dart';
import 'package:flutter_bilibili/util/hi_functions.dart';

class ExpandableContent extends StatefulWidget {
  final Video video;

  const ExpandableContent({super.key, required this.video});

  @override
  State<ExpandableContent> createState() => _ExpandableContentState();
}

class _ExpandableContentState extends State<ExpandableContent>
    with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);
  bool _expand = false;
  late AnimationController _controller;
  late Animation<double> _heightFactor;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(microseconds: 200), vsync: this);
    _heightFactor = _controller.drive(_easeInTween);
    _controller.addListener(() {
      hiPrint(_heightFactor.value);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 15,
        right: 15,
        top: 5,
      ),
      child: Column(
        children: [
          _buildTitle(),
          const Padding(padding: EdgeInsets.only(bottom: 8)),
          _buildInfo(),
          _buildDes(),
        ],
      ),
    );
  }

  _buildTitle() {
    return InkWell(
      onTap: _toggleExpand,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Text(
            widget.video.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )),
          const Padding(padding: EdgeInsets.only(left: 15)),
          Icon(
            _expand
                ? Icons.keyboard_arrow_up_sharp
                : Icons.keyboard_arrow_down_sharp,
            color: Colors.grey,
            size: 16,
          )
        ],
      ),
    );
  }

  _buildInfo() {
    var style = const TextStyle(fontSize: 12, color: Colors.grey);
    var dateStr = widget.video.createTime.length > 10
        ? widget.video.createTime.substring(5, 10)
        : widget.video.createTime;
    return Row(
      children: [
        ...smallIconText(Icons.ondemand_video, widget.video.view),
        const Padding(padding: EdgeInsets.only(left: 10)),
        ...smallIconText(Icons.list_alt, widget.video.reply),
        Text(
          '    $dateStr',
          style: style,
        )
      ],
    );
  }

  _buildDes() {
    var child = _expand
        ? Text(
            widget.video.desc,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          )
        : null;
    return AnimatedBuilder(
      animation: _controller.view,
      child: child,
      builder: (BuildContext context, Widget? child) {
        return Align(
          heightFactor: _heightFactor.value,
          alignment: Alignment.topCenter,
          child: Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(top: 8),
            child: child,
          ),
        );
      },
    );
  }

  void _toggleExpand() {
    setState(() {
      _expand = !_expand;
      if (_expand) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }
}
