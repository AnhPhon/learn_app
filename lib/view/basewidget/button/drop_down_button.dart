import 'package:flutter/material.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';

class DropDownButton<T> extends StatelessWidget {
  DropDownButton({
    Key? key,
    this.hint = "",
    required this.onChanged,
    required this.data,
    required this.width,
    required this.value,
    this.label,
    required this.obligatory
  }) : super(key: key);
  final String? hint;
  final double width;
  final Function(T? value) onChanged;
  final String? label;
  final bool obligatory;
  final List<T> data;
  T value;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.only(
        left: Dimensions.PADDING_SIZE_SMALL,
        right: Dimensions.PADDING_SIZE_SMALL, 
        top: Dimensions.PADDING_SIZE_LARGE
      ),
      child: Column(
        children: [
          if(label != null)
            Container(
              padding: const EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
              alignment: Alignment.centerLeft,
              child: Wrap(
                children: [
                  Text(
                    label!,
                    style: TextStyle(
                        fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE, fontWeight: FontWeight.bold,color: ColorResources.BLACK.withOpacity(0.7)),
                  ),
                  if (obligatory) const Text(
                          '*',
                          style: TextStyle(
                              fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        ) else Container()
                ],
              ),
            ),
          FormField(
            builder: (field) {
              return InputDecorator(
                decoration: InputDecoration(
                  //isDense: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: ColorResources.PRIMARYCOLOR)
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: ColorResources.PRIMARYCOLOR)
                    ),
                    disabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: ColorResources.PRIMARYCOLOR)
                    ),
                  contentPadding: const EdgeInsets.symmetric(vertical:Dimensions.PADDING_SIZE_SMALL-3,horizontal:Dimensions.PADDING_SIZE_SMALL ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<T>(
                    hint: Text(hint!),
                    value: value,
                    style: const TextStyle(
                      fontSize: Dimensions.PADDING_SIZE_DEFAULT,
                      color: ColorResources.BLACK
                    ),
                    isDense: true,
                    isExpanded: true,
                    onChanged: onChanged,
                    items: data.map((e) => DropdownMenuItem<T>(value: e,child: Text(e.toString()))).toList(),
                  ),
                ));
              },
            ),
        ],
      ),
    );
  }
}