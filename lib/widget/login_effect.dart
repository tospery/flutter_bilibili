import 'package:flutter/material.dart';

class LoginEffect extends StatefulWidget {
  final bool protect;

  const LoginEffect({super.key, required this.protect});

  @override
  State<LoginEffect> createState() => _LoginEffectState();
}

class _LoginEffectState extends State<LoginEffect> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          color: Colors.grey[100],
          border: Border(bottom: BorderSide(color: Colors.grey[300]!))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _image(true),
          const Image(
            height: 90,
            width: 90,
            image: AssetImage('res/image/logo.png'),
          ),
          _image(false),
        ],
      ),
    );
  }

  _image(bool left) {
    var headLeft = widget.protect
        ? 'res/image/head_left_protect.png'
        : 'res/image/head_left.png';
    var headRight = widget.protect
        ? 'res/image/head_right_protect.png'
        : 'res/image/head_right.png';
    return Image(
      image: AssetImage(left ? headLeft : headRight),
      height: 90,
    );
  }
}
