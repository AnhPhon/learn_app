import 'package:flutter/material.dart';

class KhoSanPham extends StatelessWidget {
  final String tenSanPham;
  final String maSanPham;
  final String giaSanPham;
  final String quyCach;

  const KhoSanPham({
    required this.tenSanPham,
    required this.maSanPham,
    required this.giaSanPham,
    required this.quyCach,
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
      padding: const EdgeInsets.only(right: 5),
      child: Row(
        children: <Widget>[
          Container(
            width: 80,
            height: 80,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(7),
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
                    tenSanPham,
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
                  child: Row(
                    children: [
                      Text(
                        "Mã: $maSanPham",
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 0.7),
                          fontFamily: 'Nunito',
                          fontSize: 15,
                          letterSpacing: -0.30000001192092896,
                          fontWeight: FontWeight.normal,
                          height: 1,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        giaSanPham,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          color: Colors.red,
                          fontFamily: 'Nunito',
                          fontSize: 15,
                          letterSpacing: -0.30000001192092896,
                          fontWeight: FontWeight.normal,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      const Text(
                        "Quy cách:",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 0.7),
                          fontFamily: 'Nunito',
                          fontSize: 15,
                          letterSpacing: -0.30000001192092896,
                          fontWeight: FontWeight.normal,
                          height: 1,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        quyCach,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 0.7),
                          fontFamily: 'Nunito',
                          fontSize: 15,
                          letterSpacing: -0.30000001192092896,
                          fontWeight: FontWeight.normal,
                          height: 1,
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
