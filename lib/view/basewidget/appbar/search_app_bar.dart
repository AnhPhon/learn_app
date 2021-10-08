import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_controller.dart';

class SearchAppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool? centerTitle;
  final List<Widget>? action;
  final TextEditingController searchController;
  const SearchAppBarWidget({
    Key? key,
    required this.title,
    this.centerTitle = true,
    this.action = const [],
    required this.searchController,
  }); //: assert (onSwitch != null),assert(),

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<SearchAppBarWidget> {

  final AppBarController _controller = Get.put(AppBarController());

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorResources.APPBARCOLOR,
      height: MediaQuery.of(context).padding.top + kToolbarHeight,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            top: -70,
            left: -25,
            child: Container(
              height: DeviceUtils.getScaledSize(context, 0.5),
              width: DeviceUtils.getScaledSize(context, 0.4),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        ColorResources.APPBARCIRCLECOLOR.withOpacity(0.4),
                        ColorResources.APPBARCIRCLECOLOR2.withOpacity(0.2)
                      ])),
            ),
          ),
          Positioned(
            top: -90,
            right: -35,
            child: Container(
              height: DeviceUtils.getScaledSize(context, 0.5),
              width: DeviceUtils.getScaledSize(context, 0.5),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        ColorResources.APPBARCIRCLECOLOR.withOpacity(0.4),
                        ColorResources.APPBARCIRCLECOLOR2.withOpacity(0.2)
                      ])),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Builder(
                  builder: (context) {
                    return GetBuilder(
                      builder: ( AppBarController controller) {
                        return IconButton(
                        onPressed: () {
                          if(controller.isSearch){
                            controller.onChangedStatus();
                          }else{
                            Navigator.of(context).pop();
                          }
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: ColorResources.WHITE,
                        ));  
                      },
                    );
                  },
                ),

                // Form tìm kiếm
                GetBuilder(
                  builder: (AppBarController controller) {
                    if(controller.isSearch){
                      return Expanded(
                        child: search(),
                      );
                    }else{
                      return Expanded(
                        child: Container(
                            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                            child: Text(
                              widget.title,
                              overflow: TextOverflow.ellipsis,
                              textAlign: widget.centerTitle!
                                  ? TextAlign.center
                                  : TextAlign.left,
                              style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  color: ColorResources.WHITE),
                            )
                          ),
                        );
                    }
                  }
                ),
                
                // Nút tìm kiếm
                GetBuilder(
                  builder: (AppBarController controller) {
                    if(controller.isSearch){
                      return const SizedBox(width: Dimensions.ICON_SIZE_DEFAULT,);
                    }
                    return IconButton(onPressed: (){
                      _controller.onChangedStatus();
                    }, icon: const Icon(Icons.search, size: Dimensions.ICON_SIZE_DEFAULT,color: ColorResources.WHITE,));
                  },
                ),

                /// Action
                if (widget.action!.isNotEmpty)
                  ...widget.action!.map((e) => e).toList()
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget search(){
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0.0, end: 1.0), 
      duration: const Duration(milliseconds: 600), 
      builder: (context, double value, child) {
        return Opacity(
          opacity: value,
          child: TextField(
          textInputAction: TextInputAction.done,
          onSubmitted: (val){
            print(val);
          },
          keyboardType: TextInputType.text,
          textAlignVertical: TextAlignVertical.top,
          controller: widget.searchController,
          onChanged: (val){},
          decoration: InputDecoration(
            contentPadding:const EdgeInsets.symmetric(horizontal:Dimensions.PADDING_SIZE_SMALL, vertical:Dimensions.PADDING_SIZE_DEFAULT ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: ColorResources.PRIMARYCOLOR),
              borderRadius: BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: ColorResources.PRIMARYCOLOR),
              borderRadius: BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL),
            ),
            disabledBorder:  OutlineInputBorder(
              borderSide: const BorderSide(color: ColorResources.PRIMARYCOLOR),
              borderRadius: BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL),
            ),
            isDense: true,
            hintText: "Tìm kiếm",
            hintStyle: TextStyle(
              color: ColorResources.BLACK.withOpacity(0.5),
              fontSize: Dimensions.FONT_SIZE_LARGE,
            ),
            fillColor: ColorResources.WHITE,
            filled: true,
            suffixIcon: GestureDetector(
              onTap:(){
                print("Search");
              },
              child: const Icon(Icons.search)
            )
          )
        ),
        );
      },
    );
  }
}


