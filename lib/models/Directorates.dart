import 'dart:convert';

List<Directorate> directorateFromJson(String str) => List<Directorate>.from(
    json.decode(str).map((x) => Directorate.fromJson(x)));

String directorateToJson(List<Directorate> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Directorate {
  int? id;
  int? provinceId;
  String? name;
  int? isActive;
  Null? createdAt;
  String? updatedAt;

  Directorate(
      {this.id,
      this.provinceId,
      this.name,
      this.isActive,
      this.createdAt,
      this.updatedAt});

  Directorate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    provinceId = json['province_id'];
    name = json['name'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['province_id'] = this.provinceId;
    data['name'] = this.name;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
