import 'package:flutter/material.dart';
import 'package:template/data/model/response/phuong_xa_response.dart';
import 'package:template/data/model/response/quan_huyen_response.dart';
import 'package:template/data/model/response/tinh_tp_response.dart';

class KhoHangModel {
  String? idKhoHang;
  TextEditingController? warehouseAddress = TextEditingController();
  TextEditingController? warehouseName = TextEditingController();
  TinhTpResponse? tinhTpResponse;
  QuanHuyenResponse? quanHuyenResponse;
  PhuongXaResponse? phuongXaResponse;
  List<TinhTpResponse>? tinhTpList;
  List<QuanHuyenResponse>? quanHuyenList;
  List<PhuongXaResponse>? phuongXaList;
  KhoHangModel({
    this.idKhoHang,
    this.warehouseAddress,
    this.warehouseName,
    this.tinhTpResponse,
    this.quanHuyenResponse,
    this.phuongXaResponse,
    this.tinhTpList,
    this.quanHuyenList,
    this.phuongXaList,
  });
}