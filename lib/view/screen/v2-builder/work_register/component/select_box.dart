import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:template/helper/izi_alert.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/helper/dimensions.dart';

typedef OnChangedCallback<T> = Function(T? value);

class SelectBox<T> extends StatefulWidget {
  SelectBox({
    Key? key,
    this.label,
    this.obligatory,
    this.hint,
    this.items,
    this.initValue,
    this.onChanged,
    this.decoration,
    this.padding,
    this.margin,
    this.selectedItem,
  }) : super(key: key);
  final String? label;
  final bool? obligatory;
  final String? hint;
  final List<T>? items;
  final T? initValue;
  final OnChangedCallback? onChanged;
  final BoxDecoration? decoration;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  T? selectedItem;

  @override
  _SelectBoxSupremeState createState() => _SelectBoxSupremeState();
}

class _SelectBoxSupremeState<T> extends State<SelectBox<T?>> {

  @override
  Widget build(BuildContext context) {
    if((widget.selectedItem == null || widget.selectedItem.toString() == 'null') && (widget.initValue != null && widget.initValue.toString() != 'null')){
      widget.selectedItem = widget.initValue;
    }
    return GestureDetector(
      onTap: () => showPicker(),
      child: Column(
        children: [
          if (widget.label != null)
            Container(
              margin: widget.margin ??
                  EdgeInsets.only(
                    top: (widget.label == null ? Dimensions.PADDING_SIZE_DEFAULT : 0.0).toDouble(),
                    // bottom: Dimensions.PADDING_SIZE_DEFAULT,
                  ),
              padding: widget.padding ??
                  const EdgeInsets.only(
                    top: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                    bottom: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                  ),
              child: Row(
                children: [
                  Text(
                    widget.label.toString(),
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: Dimensions.FONT_SIZE_LARGE,
                      fontWeight: FontWeight.w600,
                      color: ColorResources.BLACK,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    widget.obligatory != null && widget.obligatory == true ? ' *' : '',
                    style: const TextStyle(
                      fontSize: Dimensions.FONT_SIZE_LARGE,
                      fontWeight: FontWeight.bold,
                      color: ColorResources.RED,
                    ),
                  ),
                ],
              ),
            )
          else
            const SizedBox(),
          Container(
            padding: widget.padding ??
                const EdgeInsets.only(
                  top: Dimensions.PADDING_SIZE_SMALL,
                  bottom: Dimensions.PADDING_SIZE_SMALL,
                ),
            margin: widget.margin ??
                EdgeInsets.only(
                  top: (widget.label == null ? Dimensions.PADDING_SIZE_DEFAULT : 0.0).toDouble(),
                  // bottom: Dimensions.PADDING_SIZE_DEFAULT,
                ),
            decoration: widget.decoration ??
                BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xff000000).withOpacity(.2),
                      blurRadius: 5,
                    )
                  ],
                  borderRadius: const BorderRadius.all(
                    Radius.circular(
                      Dimensions.BORDER_RADIUS_DEFAULT,
                    ),
                  ),
                  border: Border.all(
                    color: ColorResources.PRIMARY,
                  ),
                ),
            child: Row(
              children: [
                Expanded(
                  flex: 8,
                  child: Container(
                    padding: widget.padding ??
                        const EdgeInsets.only(
                          left: Dimensions.PADDING_SIZE_DEFAULT,
                          right: Dimensions.PADDING_SIZE_DEFAULT,
                        ),
                    child: widget.selectedItem == null
                        ? Text(
                            widget.hint != null ? widget.hint.toString() : '-- Chọn --',
                            maxLines: 1,
                            style: const TextStyle(
                              fontSize: Dimensions.FONT_SIZE_LARGE,
                              color: ColorResources.GREY,
                            ),
                            overflow: TextOverflow.ellipsis,
                          )
                        : Text(
                            widget.selectedItem.toString(),
                            maxLines: 1,
                            style: const TextStyle(
                              fontSize: Dimensions.FONT_SIZE_DEFAULT,
                              color: ColorResources.BLACK,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                  ),
                ),
                const SizedBox(
                    // color: Colors.red,
                    width: Dimensions.ICON_SIZE_DEFAULT,
                    child: Icon(
                      Icons.arrow_drop_down,
                      size: Dimensions.ICON_SIZE_DEFAULT,
                      color: ColorResources.GREY,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showPicker() {
    if (widget.items == null || widget.items!.isEmpty) {
      IZIAlert.info(message: 'Danh sách rỗng');
    } else {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return CupertinoPicker(
            scrollController: FixedExtentScrollController(
              initialItem: widget.items != null ? widget.items!.indexOf(widget.selectedItem) : 0,
            ),
            backgroundColor: Colors.white,
            onSelectedItemChanged: (int index) {
              if (widget.items != null && widget.items![index] != null) {
                setState(() {
                  widget.selectedItem = widget.items![index];
                });
              }
              // if(widget.onChanged != null){
              //   widget.onChanged!(widget.selectedItem as T);
              // }
            },
            itemExtent: Dimensions.FONT_SIZE_LARGE * 4,
            useMagnifier: true,
            children: widget.items!
                .map(
                  (e) => Center(
                    child: Container(
                      padding: const EdgeInsets.only(
                        // top: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                        left: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                        right: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                        // bottom: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                      ),
                      child: Text(
                        e.toString(),
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: Dimensions.FONT_SIZE_LARGE,
                          color: ColorResources.BLACK,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                )
                .toList(),
          );
        },
      ).then((value) {
        if (widget.onChanged != null) {
          widget.onChanged!(widget.selectedItem);
        }
      });
    }
  }
}
