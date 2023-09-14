class SignUpModel {
  String? token;
  String? name;
  User? user;

  SignUpModel({this.token, this.name, this.user});

  SignUpModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    name = json['name'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['name'] = name;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  String? name;
  String? userIdent;
  String? userPhone;
  String? cityId;
  String? updatedAt;
  String? createdAt;
  int? id;

  User(
      {this.name,
      this.userIdent,
      this.userPhone,
      this.cityId,
      this.updatedAt,
      this.createdAt,
      this.id});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    userIdent = json['user_ident'];
    userPhone = json['user_phone'];
    cityId =    json['city_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id =        json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['user_ident'] = userIdent;
    data['user_phone'] = userPhone;
    data['city_id'] = cityId;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}