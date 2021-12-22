import 'package:template/data/model/danh_muc_san_pham/product_portfolio_response.dart';
import 'package:template/helper/izi_date.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_validate.dart';

class ProductResponse {
  String? id;
  ProductPortfolioResponse? productPortfolio;
  String? name;
  String? image;
  String? description;
  int? price;
  String? unit;
  String? warrantyPeriod;
  DateTime? expiry;
  String? productCode;
  String? tradeMark;
  String? shippingType;
  String? conditionOfProducts;
  String? specification;
  String? endPoint;

  ProductResponse({
    this.id,
    this.productPortfolio,
    this.name,
    this.image,
    this.description,
    this.price,
    this.unit,
    this.warrantyPeriod,
    this.expiry,
    this.productCode,
    this.tradeMark,
    this.shippingType,
    this.conditionOfProducts,
    this.specification,
    this.endPoint,
  });

  ///
  /// From JSON
  ///
  ProductResponse.fromJson(Map<String, dynamic> json) {
    id = !IZIValidate.nullOrEmpty(json['id']) ? json['id'].toString() : null;

    if (!IZIValidate.nullOrEmpty(json['idProductPortfolio']) && json['idProductPortfolio'].toString().length != 24) {
      productPortfolio = ProductPortfolioResponse.fromJson(json['idProductPortfolio'] as Map<String, dynamic>);
    } else {
      productPortfolio = null;
    }
    name = !IZIValidate.nullOrEmpty(json['name']) ? json['name'].toString() : null;
    image = !IZIValidate.nullOrEmpty(json['image']) ? json['image'].toString() : null;
    description = !IZIValidate.nullOrEmpty(json['description']) ? json['description'].toString() : null;
    price = !IZIValidate.nullOrEmpty(json['price']) ? IZINumber.parseInt(json['price']) : null;
    unit = !IZIValidate.nullOrEmpty(json['unit']) ? json['unit'].toString() : null;
    warrantyPeriod = !IZIValidate.nullOrEmpty(json['warrantyPeriod']) ? json['warrantyPeriod'].toString() : null;
    expiry = !IZIValidate.nullOrEmpty(json['expiry']) ? IZIDate.parse(json['expiry'].toString()) : null;
    productCode = !IZIValidate.nullOrEmpty(json['productCode']) ? json['productCode'].toString() : null;
    tradeMark = !IZIValidate.nullOrEmpty(json['tradeMark']) ? json['tradeMark'].toString() : null;
    shippingType = !IZIValidate.nullOrEmpty(json['shippingType']) ? json['shippingType'].toString() : null;
    conditionOfProducts = !IZIValidate.nullOrEmpty(json['conditionOfProducts']) ? json['conditionOfProducts'].toString() : null;
    specification = !IZIValidate.nullOrEmpty(json['specification']) ? json['specification'].toString() : null;
    endPoint = !IZIValidate.nullOrEmpty(json['endPoint']) ? json['endPoint'].toString() : null;
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null id
    if (!IZIValidate.nullOrEmpty(id)) data['id'] = id;

    // check null idProductPortfolio
    if (!IZIValidate.nullOrEmpty(productPortfolio)) data['idProductPortfolio'] = productPortfolio;

    // check null name
    if (!IZIValidate.nullOrEmpty(name)) data['name'] = name;

    // check null description
    if (!IZIValidate.nullOrEmpty(description)) data['description'] = description;

    // check null image
    if (!IZIValidate.nullOrEmpty(image)) data['image'] = image;

    // check null price
    if (!IZIValidate.nullOrEmpty(price)) data['price'] = price;

    // check null unit
    if (!IZIValidate.nullOrEmpty(unit)) data['unit'] = unit;

    // check null warrantyPeriod
    if (!IZIValidate.nullOrEmpty(warrantyPeriod)) data['warrantyPeriod'] = warrantyPeriod;

    // check null expiry
    if (!IZIValidate.nullOrEmpty(expiry)) data['expiry'] = expiry;

    // check null productCode
    if (!IZIValidate.nullOrEmpty(productCode)) data['productCode'] = productCode;

    // check null tradeMark
    if (!IZIValidate.nullOrEmpty(tradeMark)) data['tradeMark'] = tradeMark;

    // check null shippingType
    if (!IZIValidate.nullOrEmpty(shippingType)) data['shippingType'] = shippingType;

    // check null tradeMark
    if (!IZIValidate.nullOrEmpty(conditionOfProducts)) data['conditionOfProducts'] = conditionOfProducts;

    // check null specification
    if (!IZIValidate.nullOrEmpty(specification)) data['specification'] = specification;

    // check null endPoint
    if (!IZIValidate.nullOrEmpty(endPoint)) data['endPoint'] = endPoint;

    return data;
  }

  @override
  String toString() {
    return 'ProductResponse(id: $id, idProductPortfolio: $productPortfolio, name: $name, image: $image, description: $description, price: $price, unit: $unit, warrantyPeriod: $warrantyPeriod, expiry: $expiry, productCode: $productCode, tradeMark: $tradeMark, shippingType: $shippingType, conditionOfProducts: $conditionOfProducts, specification: $specification, endPoint: $endPoint)';
  }
}
