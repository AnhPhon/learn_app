import 'package:template/data/model/capital_contribution/capital_contribution_response.dart';
import 'package:template/helper/izi_date.dart';
import 'package:template/helper/izi_validate.dart';

class CapitalContributionRequest extends CapitalContributionResponse {

  ///
  /// From JSON
  ///
  CapitalContributionRequest.fromJson(Map<String, dynamic> json) {
    id = !IZIValidate.nullOrEmpty(json['id']) ? json['id'].toString() : null;
    fullName = !IZIValidate.nullOrEmpty(json['fullName']) ? json['fullName'].toString() : null;
    identity = !IZIValidate.nullOrEmpty(json['identity']) ? json['identity'].toString() : null;
    identityDate = !IZIValidate.nullOrEmpty(json['identityDate']) ? IZIDate.parse(json['identityDate'].toString()) : null;
    identityPlace = !IZIValidate.nullOrEmpty(json['identityPlace']) ? json['identityPlace'].toString() : null;
    dateOfBirth = !IZIValidate.nullOrEmpty(json['dateOfBirth']) ? IZIDate.parse(json['dateOfBirth'].toString()) : null;
    gender = !IZIValidate.nullOrEmpty(json['gender']) ? json['gender'].toString() : null;
    phone = !IZIValidate.nullOrEmpty(json['phone']) ? json['phone'].toString() : null;
    permanentAddress = !IZIValidate.nullOrEmpty(json['permanentAddress']) ? json['permanentAddress'].toString() : null;
    currentResidence = !IZIValidate.nullOrEmpty(json['currentResidence']) ? json['currentResidence'].toString() : null;
    bank = !IZIValidate.nullOrEmpty(json['bank']) ? json['bank'].toString() : null;
    bankAccount = !IZIValidate.nullOrEmpty(json['bankAccount']) ? json['bankAccount'].toString() : null;
  }

  ///
  /// To JSON
  ///
  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null id
    if (!IZIValidate.nullOrEmpty(id)) data['id'] = id;

    // check null fullName
    if (!IZIValidate.nullOrEmpty(fullName)) data['fullName'] = fullName;

    // check null identity
    if (!IZIValidate.nullOrEmpty(identity)) data['identity'] = identity;

    // check null identityDate
    if (!IZIValidate.nullOrEmpty(identityDate)) data['identityDate'] = IZIDate.formatDate(identityDate!);

    // check null identityPlace
    if (!IZIValidate.nullOrEmpty(identityPlace)) data['identityPlace'] = identityPlace;

    // check null dateOfBirth
    if (!IZIValidate.nullOrEmpty(dateOfBirth)) data['dateOfBirth'] = IZIDate.formatDate(dateOfBirth!);

    // check null gender
    if (!IZIValidate.nullOrEmpty(gender)) data['gender'] = gender;

    // check null phone
    if (!IZIValidate.nullOrEmpty(phone)) data['phone'] = phone;

    // check null permanentAddress
    if (!IZIValidate.nullOrEmpty(permanentAddress)) data['permanentAddress'] = permanentAddress;

    // check null phone
    if (!IZIValidate.nullOrEmpty(currentResidence)) data['currentResidence'] = currentResidence;

    // check null bank
    if (!IZIValidate.nullOrEmpty(bank)) data['bank'] = bank;

    // check null bank
    if (!IZIValidate.nullOrEmpty(bankAccount)) data['bankAccount'] = bankAccount;


    return data;
  }

 

  

  @override
  String toString() {
    return 'CapitalContributionResponse(id: $id, fullName: $fullName, identity: $identity, identityDate: $identityDate, identityPlace: $identityPlace, dateOfBirth: $dateOfBirth, gender: $gender, phone: $phone, permanentAddress: $permanentAddress, currentResidence: $currentResidence, bank: $bank, bankAccount: $bankAccount)';
  }
  
}
