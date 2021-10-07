import 'package:flutter/material.dart';

class NewsBox extends StatelessWidget {
  final String title;
  final String describe;

  const NewsBox({
    required this.title,
    required this.describe,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 352,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0xff000000).withOpacity(.2),
            blurRadius: 5,
          )
        ],
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: Row(
        children: <Widget>[
          Container(
            width: 80,
            height: 60,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(7),
                topRight: Radius.circular(7),
                bottomLeft: Radius.circular(7),
                bottomRight: Radius.circular(7),
              ),
              image: DecorationImage(
                image: AssetImage('assets/images/news1.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            width: 270,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    title,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      color: Color.fromRGBO(42, 53, 71, 1),
                      fontFamily: 'Nunito',
                      fontSize: 16,
                      letterSpacing: -0.30000001192092896,
                      fontWeight: FontWeight.bold,
                      height: 1,
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    describe,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 0.6200000047683716),
                      fontFamily: 'Nunito',
                      fontSize: 15,
                      letterSpacing: -0.30000001192092896,
                      fontWeight: FontWeight.normal,
                      height: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Positioned(
          //   top: 32.74418640136719,
          //   left: 84,
          //   child: ,
          // ),
          // const Positioned(
          //   top: 34.23255920410156,
          //   left: 283,
          //   child: Text(
          //     '20/09/2021 ',
          //     textAlign: TextAlign.right,
          //     style: TextStyle(
          //       color: Color.fromRGBO(97, 97, 97, 1),
          //       fontFamily: 'Nunito',
          //       fontSize: 11,
          //       letterSpacing: -0.30000001192092896,
          //       fontWeight: FontWeight.normal,
          //       height: 1,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
