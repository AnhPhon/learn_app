
class MatHangDacTrungModel {
  String? tieuDe;

  MatHangDacTrungModel({
      this.tieuDe});
  
  ///
  /// From JSON
  ///
  MatHangDacTrungModel.fromJson(Map<String, dynamic> json) {
    tieuDe = json['tieuDe'].toString();

  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null tieuDe
    if (tieuDe != null) data['tieuDe'] = tieuDe; 


    return data;
  }
}
