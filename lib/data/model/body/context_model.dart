class ContextModel {
  String? name;
  String? thumbnail;
  String? content;
  String? beginContext;
  String? endContext;

  ContextModel({
      this.name,
      this.thumbnail,
      this.content,
      this.beginContext,
      this.endContext
      });

  ContextModel.fromJson(Map<String, dynamic> json) {
    name = json['name'].toString();
    thumbnail = json['thumbnail'].toString();
    content = json['content'].toString();
    beginContext = json['beginContext'].toString();
    endContext = json['endContext'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['thumbnail'] = thumbnail;
    data['content'] = content;
    data['beginContext'] = beginContext;
    data['endContext'] = endContext;
    return data;
  }
}
