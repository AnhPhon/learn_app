import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class GetXSmartRefresh extends StatelessWidget {
  final RefreshController controller;
  final VoidCallback onLoading;
  final VoidCallback onRefresh;
  final bool? enablePullUp;
  final bool? enablePullDown;
  final Widget child;

  const GetXSmartRefresh({
    required this.controller,
    required this.onLoading,
    required this.onRefresh,
    this.enablePullUp,
    this.enablePullDown,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      key: UniqueKey(),
      controller: controller,
      enablePullUp: enablePullUp ?? false,
      enablePullDown: enablePullDown ?? false,
      onLoading: onLoading,
      onRefresh: onRefresh,
      child: child,
    );
  }
}
