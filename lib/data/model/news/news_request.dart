import 'package:template/data/model/news/news_response.dart';
import 'package:template/helper/izi_date.dart';
import 'package:template/helper/izi_validate.dart';

class NewsRequest extends NewsResponse {

  ///
  /// From JSON
  ///
  NewsRequest.fromJson(Map<String, dynamic> json) {
    id = !IZIValidate.nullOrEmpty(json['id']) ? json['id'].toString() : null;
    title = !IZIValidate.nullOrEmpty(json['title']) ? json['title'].toString() : null;
    content = !IZIValidate.nullOrEmpty(json['content']) ? json['content'].toString() : null;
    createAt = !IZIValidate.nullOrEmpty(json['createAt']) ? IZIDate.parse(json['content'].toString()) : null;
    imageUrl = !IZIValidate.nullOrEmpty(json['imageUrl']) ? json['imageUrl'].toString() : null;
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null id
    if (!IZIValidate.nullOrEmpty(id)) data['id'] = id;

    // check null title
    if (!IZIValidate.nullOrEmpty(title)) data['title'] = title;

    // check null content
    if (!IZIValidate.nullOrEmpty(content)) data['content'] = content;

    // check null createAt
    if (!IZIValidate.nullOrEmpty(createAt)) data['createAt'] = IZIDate.formatDate(createAt!);

    // check null imageUrl
    if (!IZIValidate.nullOrEmpty(imageUrl)) data['imageUrl'] = imageUrl;


    return data;
  }

 

  @override
  String toString() {
    return 'NewsResponse(id: $id, title: $title, content: $content, createAt: $createAt, imageUrl: $imageUrl)';
  }
  
}
