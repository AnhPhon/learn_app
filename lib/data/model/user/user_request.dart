import 'package:template/data/model/user/user_response.dart';
import 'package:template/helper/izi_validate.dart';

class UserRequest extends UserResponse{

  ///
  /// From JSON
  ///
  UserRequest.fromJson(Map<String, dynamic> json) {
    id = !IZIValidate.nullOrEmpty(json['id']) ? json['id'].toString() : null;
    series = !IZIValidate.nullOrEmpty(json['series']) ? json['series'].toString() : null;
    salutation = !IZIValidate.nullOrEmpty(json['salutation']) ? json['salutation'].toString() : null;
    fullName = !IZIValidate.nullOrEmpty(json['fullName']) ? json['fullName'].toString() : null;
    identityNo = !IZIValidate.nullOrEmpty(json['identityNo']) ? json['identityNo'].toString() : null;
    identityDate = !IZIValidate.nullOrEmpty(json['identityDate']) ? json['identityDate'].toString() : null;
    identityPlace = !IZIValidate.nullOrEmpty(json['identityPlace']) ? json['identityPlace'].toString() : null;
    dateOfBirth = !IZIValidate.nullOrEmpty(json['dateOfBirth']) ? json['dateOfBirth'].toString() : null;
    phone = !IZIValidate.nullOrEmpty(json['phone']) ? json['phone'].toString() : null;
    address = !IZIValidate.nullOrEmpty(json['address']) ? json['address'].toString() : null;
    postalCode = !IZIValidate.nullOrEmpty(json['postalCode']) ? json['postalCode'].toString() : null;
    temporaryAddress = !IZIValidate.nullOrEmpty(json['temporaryAddress']) ? json['temporaryAddress'].toString() : null;
    bank = !IZIValidate.nullOrEmpty(json['bank']) ? json['bank'].toString() : null;
    bankAccountNo = !IZIValidate.nullOrEmpty(json['bankAccountNo']) ? json['bankAccountNo'].toString() : null;
    gender = !IZIValidate.nullOrEmpty(json['gender']) ? json['gender'].toString() : null;
    type = !IZIValidate.nullOrEmpty(json['type']) ? json['type'].toString() : null;
    fromOpportunity = !IZIValidate.nullOrEmpty(json['fromOpportunity']) ? json['fromOpportunity'].toString() : null;
    linkWithEmployee = !IZIValidate.nullOrEmpty(json['linkWithEmployee']) ? json['linkWithEmployee'].toString() : null;
    dateOfJoining = !IZIValidate.nullOrEmpty(json['dateOfJoining']) ? json['dateOfJoining'].toString() : null;
    zone = !IZIValidate.nullOrEmpty(json['zone']) ? json['zone'].toString() : null;
    mLMAddressGroup = !IZIValidate.nullOrEmpty(json['mLMAddressGroup']) ? json['mLMAddressGroup'].toString() : null;
    collaborator = !IZIValidate.nullOrEmpty(json['collaborator']) ? json['collaborator'].toString() : null;
    customerGroup = !IZIValidate.nullOrEmpty(json['customerGroup']) ? json['customerGroup'].toString() : null;
    territory = !IZIValidate.nullOrEmpty(json['territory']) ? json['territory'].toString() : null;
    taxID = !IZIValidate.nullOrEmpty(json['taxID']) ? json['taxID'].toString() : null;
  }

  //TODO: Bỏ commet trong method
  ///
  /// To JSON
  ///
  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null id
    if (!IZIValidate.nullOrEmpty(id)) data['id'] = id;

    // check null series
    if (!IZIValidate.nullOrEmpty(series)) data['series'] = series;

    // check null salutation
    if (!IZIValidate.nullOrEmpty(salutation)) data['salutation'] = salutation;

    // check null fullName
    if (!IZIValidate.nullOrEmpty(fullName)) data['fullName'] = fullName;

    // check null identityNo
    if (!IZIValidate.nullOrEmpty(identityNo)) data['identityNo '] = identityNo;

    // check null identityDate
    if (!IZIValidate.nullOrEmpty(identityDate)) data['identityDate'] = identityDate;

    // check nullidentityPlace
    if (!IZIValidate.nullOrEmpty(identityPlace)) data['identityPlace'] = identityPlace;

    // check null dateOfBirth
    if (!IZIValidate.nullOrEmpty(dateOfBirth)) data['dateOfBirth '] = dateOfBirth;

    // check null phone
    if (!IZIValidate.nullOrEmpty(phone)) data['phone'] = phone;

    // check null address
    if (!IZIValidate.nullOrEmpty(address)) data['address '] = address;

    // check null postalCode
    if (!IZIValidate.nullOrEmpty(postalCode)) data[' postalCode'] = postalCode;

    // check null temporaryAddress
    if (!IZIValidate.nullOrEmpty(temporaryAddress)) data[' temporaryAddress'] = temporaryAddress;

    // check null bank
    if (!IZIValidate.nullOrEmpty(bank)) data[' bank'] = bank;

    // check null bankAccountNo
    if (!IZIValidate.nullOrEmpty(bankAccountNo)) data['  bankAccountNo'] = bankAccountNo;

    // check null gender
    if (!IZIValidate.nullOrEmpty(gender)) data[' gender'] = gender;

    // check type
    if (!IZIValidate.nullOrEmpty(type)) data[' type'] = type;

    // check nullfromOpportunity
    if (!IZIValidate.nullOrEmpty(fromOpportunity)) data[' fromOpportunity'] = fromOpportunity;

    // check null linkWithEmployee
    if (!IZIValidate.nullOrEmpty(linkWithEmployee)) data['linkWithEmployee '] = linkWithEmployee;

    // check null dateOfJoining
    if (!IZIValidate.nullOrEmpty(dateOfJoining)) data[' dateOfJoining '] = dateOfJoining;

    // check null zone
    if (!IZIValidate.nullOrEmpty(zone)) data[' zone'] = zone;

    // check mLMAddressGroup
    if (!IZIValidate.nullOrEmpty(mLMAddressGroup)) data['mLMAddressGroup '] = mLMAddressGroup;

    // check collaborator
    if (!IZIValidate.nullOrEmpty(collaborator)) data['collaborator '] = collaborator;

    // check null customerGroup
    if (!IZIValidate.nullOrEmpty(customerGroup)) data['customerGroup '] = customerGroup;

    // check null  territory
    if (!IZIValidate.nullOrEmpty(territory)) data['  territory '] = territory;

    // check null taxID
    if (!IZIValidate.nullOrEmpty(taxID)) data['  taxID '] = taxID;

    return data;
  }
}
