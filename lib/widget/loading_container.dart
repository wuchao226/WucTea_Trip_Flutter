import 'package:flutter/material.dart';

/// 加载进度条
class LoadingContainer extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final bool cover;

  const LoadingContainer({
    super.key,
    required this.child,
    required this.isLoading,
    this.cover = false,
  });

  get _loadingView => const Center(
        child: CircularProgressIndicator(
          color: Colors.blue,
        ),
      );

  get coverView => Stack(
        //堆叠效果
        children: [
          child,
          isLoading ? _loadingView : Container(),
        ],
      );

  get normalView => isLoading ? _loadingView : child;

  @override
  Widget build(BuildContext context) {
    return cover ? coverView : normalView;
  }
}
