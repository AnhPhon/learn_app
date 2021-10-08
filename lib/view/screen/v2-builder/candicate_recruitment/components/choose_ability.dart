

import 'package:flutter/material.dart';
import 'package:template/utils/dimensions.dart';

TableRow chooseAbility(BuildContext context,{required String title,required List<Object> ability}){
  return TableRow(
    children: [
      Padding(
        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        child: Align(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title, textAlign: TextAlign.center,style: const TextStyle(
                fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
              ),),
            ],
          ),
        ),
      ),
      ...ability.map((e) => Align(
        child: e is Widget ? e : Padding(
          padding: const EdgeInsets.only(
            right: Dimensions.FONT_SIZE_EXTRA_LARGE * 2,
            top: Dimensions.FONT_SIZE_EXTRA_SMALL
          ),
          child: Text(e as String, textAlign: TextAlign.left, style: const TextStyle(
            fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
          ),),
        ),
      ),)
    ]
  );
}