import 'package:flutter/material.dart';
import 'package:flutter_bilibili/model/index.dart';
import 'package:flutter_bilibili/util/color.dart';
import 'package:flutter_bilibili/util/hi_functions.dart';

class VideoHeader extends StatelessWidget {
  final Owner owner;

  const VideoHeader({super.key, required this.owner});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 15, right: 15, left: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  owner.face,
                  width: 30,
                  height: 30,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      owner.name,
                      style: const TextStyle(
                          fontSize: 13,
                          color: primary,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${countFormat(owner.fans as int)}粉丝',
                      style: const TextStyle(fontSize: 10, color: Colors.grey),
                    )
                  ],
                ),
              ),
            ],
          ),
          MaterialButton(
            onPressed: () {
              hiPrint('------关注-----');
            },
            color: primary,
            height: 24,
            minWidth: 50,
            child: const Text(
              '+ 关注',
              style: TextStyle(color: Colors.white, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
