import 'package:flutter/material.dart';

class SelectProvinceCustomModel {
  dynamic value;
  Function(dynamic) onChanged;

  SelectProvinceCustomModel({
    required this.value,
    required this.onChanged
  });
}