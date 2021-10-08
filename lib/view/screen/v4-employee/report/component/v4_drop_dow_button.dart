import 'package:flutter/material.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';

class V4DropButtonAppBar extends StatelessWidget {
  const V4DropButtonAppBar({
    Key? key,
    required this.hint,
    required this.onChanged,
    required this.data,
    this.value,
  }) : super(key: key);

  final String hint;
  final Function(String? i) onChanged;
  final List<String> data;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        dropdownColor: ColorResources.APPBARCOLOR,
        hint: Text(hint),
        value: value,
        icon: const Icon(
          Icons.filter_alt_outlined,
          color: ColorResources.WHITE,
        ),
        // ignore: avoid_redundant_argument_values
        iconSize: Dimensions.ICON_SIZE_DEFAULT,
        elevation: 16,
        onChanged: onChanged,
        items: data
            .map<DropdownMenuItem<String>>(
                (String e) => DropdownMenuItem<String>(
                    value: e,
                    child: Text(
                      e,
                      style: const TextStyle(
                        fontSize: Dimensions.PADDING_SIZE_DEFAULT,
                        color: ColorResources.WHITE,
                      ),
                      overflow: TextOverflow.ellipsis,
                    )))
            .toList(),
      ),
    );
  }
}
