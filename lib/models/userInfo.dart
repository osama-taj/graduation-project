class userInfo {
  int? userId;
  String? name;
  String? phone;
  String? image;
  String? depName;
  String? dirName;
  String? proName;
  String? total;
  int? count;

  userInfo(
      {this.userId,
      this.name,
      this.phone,
      this.image,
      this.depName,
      this.dirName,
      this.proName,
      this.total,
      this.count});

  userInfo.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    name = json['name'];
    phone = json['phone'];
    image = json['image'];
    depName = json['depName'];
    dirName = json['dirName'];
    proName = json['proName'];
    total = json['total'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['image'] = this.image;
    data['depName'] = this.depName;
    data['dirName'] = this.dirName;
    data['proName'] = this.proName;
    data['total'] = this.total;
    data['count'] = this.count;
    return data;
  }
}
