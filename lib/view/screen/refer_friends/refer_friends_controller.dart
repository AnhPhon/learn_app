import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:template/helper/izi_alert.dart';
import 'package:url_launcher/url_launcher.dart';

class ReferFriendsController extends GetxController {
  //Khai báo isLoading
  bool isLoading = true;

  //Khai báo link share
  String linkShare = "https://izisoft.io/";

  //Khai báo List Danh bạ
  List<Contact> contactList = [];

  //Khai báo Itemcount List Contact
  int itemCountContactList = 0;

  //Khai báo isXemThem
  bool isReadMore = false;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    //Get all Contact
    askContactPermission();

    //is Read More is false
    isReadMore = false;
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  ///
  ///Void Xem them
  ///
  void xemThem() {
    itemCountContactList = contactList.length;
    isReadMore = true;
    update();
  }

  ///
  ///Void rút gọn
  ///
  void rutGon() {
    if (contactList.length >= 3) {
      itemCountContactList = 3;
    } else {
      itemCountContactList = contactList.length;
    }
    isReadMore = false;
    update();
  }

  ///
  ///Get all contact
  ///
  Future getAllContact() async {
    final _contacts = (await ContactsService.getContacts(withThumbnails: false)).toList();
    contactList = _contacts;
    if (contactList.length >= 3) {
      itemCountContactList = 3;
    } else {
      itemCountContactList = contactList.length;
    }
    print(contactList);
    update();
  }

  ///
  ///Copy Link Share
  ///
  void copyLinkShare({required String content}) {
    Clipboard.setData(ClipboardData(text: content));
    IZIAlert.success(message: 'Copy link giới thiệu $content thành công');
  }

  ///
  /// Ask Contact Permission
  ///
  Future askContactPermission() async {
    //check permission
    final status = await Permission.contacts.request();
    if (status == PermissionStatus.granted) {
      getAllContact();
    } else if (status == PermissionStatus.denied) {
      await openAppSettings();
    } else if (status == PermissionStatus.permanentlyDenied) {
      await openAppSettings();
    }
  }

  ///
  /// btn contact
  ///
  Future<void> btnCall({required String url}) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
