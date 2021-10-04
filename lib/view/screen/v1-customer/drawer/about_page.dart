import 'package:flutter/material.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: Icon(Icons.arrow_back),
      //   title: Text("Giới thiêu"),
      //   centerTitle: true,
      //   actions: [
      //     IconButton(onPressed: (){}, icon: Icon(Icons.ac_unit_outlined)),
      //     IconButton(onPressed: (){}, icon: Icon(Icons.ac_unit_outlined)),
      //     IconButton(onPressed: (){}, icon: Icon(Icons.ac_unit_outlined)),
      //   ],
      // ),
      appBar: AppBarWidget(title: "Giới thiệu"),
      body: Center(
        child: Text("Giới thiệu "),
      ),
    );
  }
}