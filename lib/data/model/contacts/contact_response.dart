import 'package:template/helper/izi_validate.dart';

class ContactResponse {
  String? id;
  String? name;
  String? phone;

  ContactResponse({
    this.id,
    this.name,
    this.phone,
  });



  ///
  /// From JSON
  ///
  ContactResponse.fromJson(Map<String, dynamic> json) {
    id = !IZIValidate.nullOrEmpty(json['id']) ? json['id'].toString() : null;
    name = !IZIValidate.nullOrEmpty(json['name']) ? json['name'].toString() : null;
    phone = !IZIValidate.nullOrEmpty(json['phone']) ? json['phone'].toString() : null;
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null id
    if (!IZIValidate.nullOrEmpty(id)) data['id'] = id;

    // check null name
    if (!IZIValidate.nullOrEmpty(name)) data['name'] = name;

    // check null phone
    if (!IZIValidate.nullOrEmpty(phone)) data['phone'] = phone;


    return data;
  }

  @override
  String toString() => 'ContactResponse(id: $id, name: $name, phone: $phone)';
}
