import 'package:flutter/material.dart';
import 'package:flutter_bilibili/util/hi_functions.dart';

///可动态改变位置的Header组件
///性能优化：局部刷新的应用@刷新原理
class HiFlexibleHeader extends StatefulWidget {
  final String name;
  final String face;
  final ScrollController controller;

  const HiFlexibleHeader({super.key, required this.name, required this.face, required this.controller});



  @override
  State<HiFlexibleHeader> createState() => _HiFlexibleHeaderState();
}

class _HiFlexibleHeaderState extends State<HiFlexibleHeader> {
  static const double maxBottom = 40;
  static const double minBottom = 10;
  static const double maxOffset = 80;

  double _dyBottom = maxBottom;

@override
void initState() { 
  super.initState();
    widget.controller.addListener(() {
      var offset = widget.controller.offset;
      //算出padding变化系数0-1
      var dyOffset = (maxOffset - offset) / maxOffset;
      //根据dyOffset算出具体的变化的padding值
      var dy = dyOffset * (maxBottom - minBottom);
      //临界值保护
      if (dy > (maxBottom - minBottom)) {
        dy = maxBottom - minBottom;
      } else if (dy < 0) {
        dy = 0;
      }
      setState(() {
        //算出实际的padding
        _dyBottom = minBottom + dy;
      });
    });
}

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      padding: EdgeInsets.only(bottom: _dyBottom, left: 10),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(23),
            child: cachedImage(widget.face, width: 46, height: 46),
          ),
          hiSpace(width: 8),
          Text(
            widget.name,
            style: const TextStyle(fontSize: 11),
          )
        ],
      ),
    );
  }
}