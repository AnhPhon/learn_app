

import 'package:flutter/material.dart';
import 'package:template/utils/color_resources.dart';

class AppBarWidget extends StatefulWidget implements PreferredSizeWidget {
    final String title;
    final bool? centerTitle;
    final List<Widget>? action;
  const AppBarWidget({
    Key? key,
    required this.title,
    this.centerTitle = true,
    this.action = const [],
  }) : super(key: key);

    @override
    _CustomAppBarState createState() => _CustomAppBarState();

    @override
    Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<AppBarWidget>{
    @override
    Widget build(BuildContext context) {
      return Container(
        color: ColorResources.APPBARCOLOR,
        height: Scaffold.of(context).appBarMaxHeight,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Positioned(
              top:-45,
              left: -25,
              child: Container(
                height: 170,
                width: 170,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      ColorResources.APPBARCIRCLECOLOR.withOpacity(0.4),
                      ColorResources.APPBARCIRCLECOLOR2.withOpacity(0.2)
                    ]
                  )
                ),
              ),
            ),
            Positioned(
              top:-60,
              right: -40,
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      ColorResources.APPBARCIRCLECOLOR.withOpacity(0.4),
                      ColorResources.APPBARCIRCLECOLOR2.withOpacity(0.2)
                    ]
                  )
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Builder(builder: (context) {
                    return IconButton(onPressed: (){
                      Navigator.of(context).pop();
                    }, icon: const Icon(Icons.arrow_back_ios, color: ColorResources.WHITE,));
                  },),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Text(widget.title, textAlign: widget.centerTitle! ?  TextAlign.center : TextAlign.left,style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: ColorResources.WHITE
                      ),)
                    ),
                  ),
                  if (widget.action!.isNotEmpty) 
                  ...widget.action!.map((e) => e).toList()
                  else const SizedBox(width: 30,)
                ],
              ),
            ),
          ],
        ),
      );
    }
}