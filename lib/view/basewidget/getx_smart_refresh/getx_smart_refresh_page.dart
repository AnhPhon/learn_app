import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'getx_smart_refresh_controller.dart';

class GetXSmartRefreshPage extends StatefulWidget {
  final VoidFutureCallBack onLoading;
  final VoidFutureCallBack onRefresh;
  final bool? enablePullUp;
  final bool? enablePullDown;
  final Widget child;

  const GetXSmartRefreshPage({
    Key? key,
    required this.onLoading,
    required this.onRefresh,
    this.enablePullUp,
    this.enablePullDown,
    required this.child,
  }) : super(key: key);

  @override
  _GetXSmartRefreshPageState createState() => _GetXSmartRefreshPageState();
}

class _GetXSmartRefreshPageState extends State<GetXSmartRefreshPage> with AutomaticKeepAliveClientMixin {

  GetXSmartRefreshController? controller;
  ScrollController scrollController = ScrollController();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // print('GetXSmartRefreshPage initState ${widget.key.toString()}');
    // TODO: implement initState
    super.initState();
    controller = Get.put(
      GetXSmartRefreshController(),
      tag: widget.key.toString(),
    );
    controller!.onRefresh = widget.onRefresh;
    controller!.onLoading = widget.onLoading;
  }

  @override
  Widget build(BuildContext context) {
    // print('GetXSmartRefreshPage build ${widget.key.toString()}');

    super.build(context);
    if (!mounted) return const SizedBox();
    return SmartRefresher(
      scrollController: scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      key: Key('SmartRefresher' + widget.key.toString()),
      controller: controller!.refreshController,
      enablePullUp: widget.enablePullUp ?? false,
      enablePullDown: widget.enablePullDown ?? false,
      onLoading: controller!.runLoading,
      onRefresh: controller!.runRefresh,
      child: widget.child,
    );
  }

}
