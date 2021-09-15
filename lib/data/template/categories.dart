import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryWidget extends GetView {
  CategoryWidget({required this.label, required this.content, required this.hasMore});

  String? label;
  Widget? content;
  bool? hasMore;

  double labelFontSize = 16;
  Color labelColor = Color(0XFF27272A);

  double moreFontSize = 14;
  Color moreColor = Color(0XFF1A94FF);

  double elementFontSize =14;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 20),
      child: Column(
        children: [
          Container(
            child: Row(
                children:[
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    width: width * .68,
                    child: Text(
                      this.label!,
                      style: TextStyle(
                          fontSize: labelFontSize,
                          fontWeight: FontWeight.bold,
                          color: labelColor
                      ),
                    ),
                  ),
                  Container(
                    // width: width * .5,
                    child: (this.hasMore! == true)?ElevatedButton(
                      style: ButtonStyle(
                        shadowColor: MaterialStateProperty.all(Colors.transparent),
                        backgroundColor: MaterialStateProperty.all(Colors.transparent),
                      ),
                      child: Text(
                        'Xem thêm',
                        style: TextStyle(
                            fontSize: moreFontSize,
                            color: moreColor
                        ),
                      ),
                      onPressed: () {},
                    ):Container(),
                  )
                ],
            ),
          ),
          Container(
            child: this.content!
          ),
        ],
      )
    );
  }
}