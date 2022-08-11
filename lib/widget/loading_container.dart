import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingContainer extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final bool cover;

  const LoadingContainer(
      {super.key,
      required this.child,
      this.isLoading = false,
      this.cover = false});

  @override
  Widget build(BuildContext context) {
    if (cover) {
      return Stack(
        children: [
          child,
          isLoading ? _loadingView : Container(),
        ],
      );
    }
    return isLoading ? _loadingView : child;
  }

  get _loadingView {
    return Center(
      child: Lottie.asset('res/animation/loading.json'),
    );
  }
}
