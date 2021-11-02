import 'package:flutter/material.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';

class CandidateRecruitmentDialogAccept extends StatelessWidget {
  CandidateRecruitmentDialogAccept({
    Key? key,
    required this.textContent,
  }) : super(key: key);
  String? textContent;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: DeviceUtils.getScaledWidth(context, 1),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
            child: Center(child: Text(textContent.toString())),
          ),
        ));
  }
}
