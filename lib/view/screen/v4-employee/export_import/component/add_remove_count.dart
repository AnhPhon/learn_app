import 'package:flutter/material.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/screen/v4-employee/export_import/component/counter_button.dart';

// ignore: must_be_immutable
class AddAndRemoveCount extends StatelessWidget {
  AddAndRemoveCount({
    Key? key,
    required this.controller,
    required this.label,
    required this.allowEdit,
    required this.typeInput,
    required this.width,
  }) : super(key: key);

  final TextEditingController controller;
  final String label;
  bool allowEdit;
  final TextInputType typeInput;
  double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Dimensions.PADDING_SIZE_LARGE,
        top: Dimensions.PADDING_SIZE_LARGE,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Wrap(
              children: [
                Text(
                  label,
                  style: TextStyle(
                      fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                      fontWeight: FontWeight.bold,
                      color: ColorResources.BLACK.withOpacity(0.7)),
                ),
                const Text(
                  '*',
                  style: TextStyle(
                      fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                )
              ],
            ),
          ),
          // ignore: sized_box_for_whitespace
          Container(
            width: DeviceUtils.getScaledWidth(context, 0.44),
            height: DeviceUtils.getScaledHeight(context, 0.08),
            child: Row(
              // ignore: avoid_redundant_argument_values
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CounterButton(
                  icon: const Icon(
                    Icons.remove,
                    color: ColorResources.WHITE,
                    size: Dimensions.ICON_SIZE_DEFAULT,
                  ),
                  press: () {},
                ),
                const SizedBox(
                  width: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                ),
                Container(
                  width: width,
                  height: DeviceUtils.getScaledHeight(context, 0.2),
                  padding: const EdgeInsets.only(
                      top: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  child: TextField(
                    controller: controller,
                    textInputAction: TextInputAction.done,
                    keyboardType: typeInput,
                    textAlignVertical: TextAlignVertical.top,
                    enabled: allowEdit,
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_LARGE,
                          vertical: Dimensions.PADDING_SIZE_DEFAULT),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: ColorResources.PRIMARYCOLOR),
                        borderRadius: BorderRadius.circular(
                            Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: ColorResources.PRIMARYCOLOR),
                        borderRadius: BorderRadius.circular(
                            Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: ColorResources.PRIMARYCOLOR),
                        borderRadius: BorderRadius.circular(
                            Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                      ),
                      isDense: true,
                      hintText: '0',
                      hintStyle: TextStyle(
                        color: ColorResources.BLACK.withOpacity(0.5),
                        fontSize: Dimensions.FONT_SIZE_LARGE,
                      ),
                      fillColor: ColorResources.BLACK,
                    ),
                  ),
                ),
                const SizedBox(
                  width: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                ),
                CounterButton(
                  icon: const Icon(
                    Icons.add,
                    color: ColorResources.WHITE,
                    size: Dimensions.ICON_SIZE_DEFAULT,
                  ),
                  press: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
