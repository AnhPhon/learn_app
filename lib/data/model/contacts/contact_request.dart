import 'package:template/data/model/contacts/contact_response.dart';
import 'package:template/helper/izi_validate.dart';

class ContactRequest extends ContactResponse {
  ///
  /// From JSON
  ///
  ContactRequest.fromJson(Map<String, dynamic> json) {
    id = !IZIValidate.nullOrEmpty(json['id']) ? json['id'].toString() : null;
    name = !IZIValidate.nullOrEmpty(json['name']) ? json['name'].toString() : null;
    phone = !IZIValidate.nullOrEmpty(json['phone']) ? json['phone'].toString() : null;
  }

  ///
  /// To JSON
  ///
  @override
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
