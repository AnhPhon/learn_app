import 'package:template/helper/izi_validate.dart';

class ProductPortfolioResponse {
  String? id;
  String? name;
  String? description;
  String? image;
  String? endPoint;

  ProductPortfolioResponse({
    this.id,
    this.name,
    this.description,
    this.image,
    this.endPoint,
  });

  ///
  /// From JSON
  ///
  ProductPortfolioResponse.fromJson(Map<String, dynamic> json) {
    id = !IZIValidate.nullOrEmpty(json['id']) ? json['id'].toString() : null;
    name = !IZIValidate.nullOrEmpty(json['name']) ? json['name'].toString() : null;
    description = !IZIValidate.nullOrEmpty(json['description']) ? json['description'].toString() : null;
    image = !IZIValidate.nullOrEmpty(json['image']) ? json['image'].toString() : null;
    endPoint = !IZIValidate.nullOrEmpty(json['endPoint']) ? json['endPoint'].toString() : null;
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null id
    if (!IZIValidate.nullOrEmpty(id)) data['id'] = id;

    // check null ten
    if (!IZIValidate.nullOrEmpty(name)) data['name'] = name;

    // check null moTa
    if (!IZIValidate.nullOrEmpty(description)) data['description'] = description;

    // check null hinhAnh
    if (!IZIValidate.nullOrEmpty(image)) data['image'] = image;

    // check null endPoint
    if (!IZIValidate.nullOrEmpty(endPoint)) data['endPoint'] = endPoint;

    return data;
  }

  @override
  String toString() {
    return 'ProductPortfolioResponse(id: $id, name: $name, description: $description, image: $image, endPoint: $endPoint)';
  }
}
