import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/di_container.dart';
import 'package:template/utils/value_global_notifier.dart';
import 'getx_smart_refresh_controller.dart';

class GetXSmartRefreshPage extends StatefulWidget {
  final VoidFutureCallBack onLoading;
  final VoidFutureCallBack onRefresh;
  final bool? enablePullUp;
  final bool? enablePullDown;
  final bool? primary;
  final Widget child;

  const GetXSmartRefreshPage({
    Key? key,
    required this.onLoading,
    required this.onRefresh,
    this.enablePullUp,
    this.enablePullDown,
    this.primary,
    required this.child,
  }) : super(key: key);

  @override
  _GetXSmartRefreshPageState createState() => _GetXSmartRefreshPageState();
}

class _GetXSmartRefreshPageState extends State<GetXSmartRefreshPage> with AutomaticKeepAliveClientMixin {
  GetXSmartRefreshController? controller;
  ScrollController scrollController = ScrollController();
  final valueGlobalNotifier = sl.get<ValueGlobalNotifier>();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // print('GetXSmartRefreshPage initState ${widget.key.toString()}');
    super.initState();
    controller = Get.put(
      GetXSmartRefreshController(),
      tag: widget.key.toString(),
    );
    controller!.onRefresh = widget.onRefresh;
    controller!.onLoading = widget.onLoading;
    controller!.keyRefresh = (widget.key as ValueKey<String>).value;
    print('GetXSmartRefreshController key full ${(widget.key as ValueKey<String>).value}');

    // valueGlobalNotifier.smartRefreshNoData.listen((p0) {
    //   Future.delayed(const Duration(seconds: 1), () {
    //     // if (mounted) {
    //       setState(() {});
    //     // }
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    // print('GetXSmartRefreshPage build ${widget.key.toString()}');

    super.build(context);
    if (!mounted) return const SizedBox();
    return SmartRefresher(
      primary: widget.primary ?? false,
      scrollController: scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      key: Key('SmartRefresher_${widget.key}'),
      controller: controller!.refreshController,
      enablePullUp: widget.enablePullUp ?? false,
      enablePullDown: widget.enablePullDown ?? false,
      // enableTwoLevel: false,
      onLoading: controller!.runLoading,
      onRefresh: controller!.runRefresh,
      header: const ClassicHeader(
        idleText: "Kéo xuống để làm mới",
        releaseText: "Thả ra để làm mới dữ liệu",
        completeText: "Làm mới dữ liệu thành công",
        refreshingText: "Đang làm mới dữ liệu",
        failedText: "Làm mới dữ liệu bị lỗi",
        canTwoLevelText: "Thả ra để làm mới",
      ),
      footer: const ClassicFooter(
        loadingText: "Đang tải...",
        noDataText: "Không có dữ liệu",
        canLoadingText: "Kéo lên để tải thêm dữ liệu",
        failedText: "Tải thêm dữ liệu bị lỗi",
        idleText: "Kéo lên để tải thêm dữ liệu",
        // idleText: "Kéo lên để tải thêm dữ liệu",
      ),
      child: widget.child,
    );
  }
}
