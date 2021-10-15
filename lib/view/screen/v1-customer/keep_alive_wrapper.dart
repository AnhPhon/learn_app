import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class KeepAliveWrapper extends StatefulWidget {
  final void Function()? onRefresh;
  final void Function()? onLoading;
  final RefreshController refreshController;
  final Widget child;

  const KeepAliveWrapper(
      {Key? key,
      this.onRefresh,
      this.onLoading,
      required this.refreshController, required this.child,})
      : super(key: key);

  @override
  __KeepAliveWrapperState createState() => __KeepAliveWrapperState();
}

class __KeepAliveWrapperState extends State<KeepAliveWrapper>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SmartRefresher(
      controller: widget.refreshController,
      onRefresh: widget.onRefresh,
      onLoading: widget.onLoading,
      physics: const BouncingScrollPhysics(),
      footer: const ClassicFooter(
        loadStyle: LoadStyle.ShowWhenLoading,
      ),
      enablePullUp: true,
      child: widget.child,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
