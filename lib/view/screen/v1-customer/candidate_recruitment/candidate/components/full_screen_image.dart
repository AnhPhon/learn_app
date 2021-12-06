import 'package:flutter/material.dart';

class FullScreenImage extends StatelessWidget {
  final String urlImage;
  final String tag;

  const FullScreenImage({required this.urlImage, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Hero(
            tag: tag,
            child: Image.network(
              urlImage,
              height: double.infinity,
              width: double.infinity,
            ),
          ),
        ),
      ),
    );
  }
}
