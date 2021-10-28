import 'package:flutter/material.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';

class TaskNeedWorker extends StatelessWidget {
  final String tenTask;
  final String maTask;
  final String trangThai;
  String? imageURL;

  TaskNeedWorker({
    required this.tenTask,
    required this.maTask,
    required this.trangThai,
    this.imageURL,
  });

  @override
  Widget build(BuildContext context) {
    const double height = 100;
    return Container(
      width: DeviceUtils.getScaledWidth(context, 1),
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0xff000000).withOpacity(.2),
            blurRadius: 5,
          )
        ],
        borderRadius: const BorderRadius.all(
          Radius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
        ),
      ),
      margin: const EdgeInsets.only(top: Dimensions.MARGIN_SIZE_DEFAULT),
      padding: const EdgeInsets.only(right: Dimensions.MARGIN_SIZE_EXTRA_SMALL),
      child: Row(
        children: <Widget>[
          Container(
            width: height,
            height: height,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(Dimensions.BORDER_RADIUS_SMALL),
                bottomRight: Radius.circular(Dimensions.BORDER_RADIUS_SMALL),
                bottomLeft: Radius.circular(Dimensions.BORDER_RADIUS_SMALL),
                topLeft: Radius.circular(Dimensions.BORDER_RADIUS_SMALL),
              ),
              image: DecorationImage(
                image: NetworkImage(imageURL!),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            width: DeviceUtils.getScaledWidth(context, .67),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    tenTask,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      color: Color.fromRGBO(42, 53, 71, 1),
                      fontSize: Dimensions.FONT_SIZE_LARGE,
                      fontWeight: FontWeight.bold,
                      height: 1,
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Text(
                        "Dự án: $maTask",
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 0.7),
                          fontSize: Dimensions.FONT_SIZE_SMALL,
                          letterSpacing: -0.3,
                          fontWeight: FontWeight.normal,
                          height: 1,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        alignment: Alignment.centerRight,
                        child: Row(
                          children: [
                            const Icon(
                              Icons.person_search,
                              color: Color(0xff8E8A8A),
                            ),
                            Text(
                              trangThai,
                              style: const TextStyle(
                                color: Color(0xff8E8A8A),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
