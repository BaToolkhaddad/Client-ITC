import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../helper/app_config.dart';

class Profile with ChangeNotifier {
  int? id;
  String? name;
  String? userIdent;
  String? userPhone;
  String?userPassword;
  String? createdAt;
  String? updatedAt;
  get idG => id;
  set idS(int? value) {
    id = value;
  }

  Profile? get currentUser {
    return Profile(
        id: user!.id,
        name: user!.name,
        userIdent: user!.userIdent,
         userPassword: user!.userPassword,
        userPhone: user!.userPhone,
        createdAt: user!.createdAt,
        updatedAt: user!.updatedAt);
  }

  Profile? user;
  Profile(
      {this.id,
      this.name,
      this.userIdent,
      this.userPhone,
      this.userPassword,
      this.createdAt,
      this.updatedAt});

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    userIdent = json['user_ident'];
    userPhone = json['user_phone'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['user_ident'] = userIdent;
    data['user_phone'] = userPhone;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  List<Profile> listInfoProfile = [];

  List<Profile> get infoAnalyis {
    return [...listInfoProfile];
  }

  Future<void> getOwnerInfo() async {
    await setToken();
    final Uri url = Uri.parse('${APP_BASE_URL}/profile');

    // try {
    print("fdsajhkjhafsdkj ${_token}");
    final response =
        await http.get(url, headers: {'Authorization': 'Bearer $_token'});

    print("booooooooody is${response.statusCode}");
    print("booooooooody is${response.body}");
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      print("fsadffsdafda ${responseData["data"]}");
      user = Profile.fromJson(responseData["data"]);
    } else {
      throw const HttpException('حدثت مشكلة مع السيرفر');
    }
  }

  String? _token;

  Future<void> updateOwnerInfo({
    String? id,
    String? userName,
    String? userIdent,
    String? userPassword,
    String? userPhone,
    String? cityIduser ,
  }) async {
    if (kDebugMode) {
      print(id);
      print(userName);
      print(userIdent);
      print(userPhone);
      print(userPassword);
    }
    await setToken();
    final url = Uri.parse('${APP_BASE_URL}/users/:id');
    print("fdsajhkjhafsdkj ${_token}");
    final response =
        await http.get(url, headers: {'Authorization': 'Bearer $_token'});

    try {
      Map<String, String> requestBody = <String, String>{
        'id': id!,
        'name': userName!,
        'user_phone': userPhone!,
        'user_ident': userIdent!,
        'password': userPassword!,
        // 'city_iduser': '6',
        // 'user_id': '88',
      };
      print("boooooooooodyyyyyy is$requestBody");

      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body);
        final List<Profile> loadedItems = [];

        for (var unit in decodedData['data']) {
          print("sfdjakjfsaldjldfs ${decodedData['data']}");
          loadedItems.add(Profile.fromJson(unit));
        }

        listInfoProfile = loadedItems;
        print("Data fetched successfully");
        print("Data length is ${loadedItems.length}");
      } else {
        throw const HttpException('حدثت مشكلة أثناء عملية التعديل');
      }
    } on SocketException {
      throw const HttpException('لا يوجد اتصال بالانترنت');
    } catch (e) {
      throw const HttpException('حدثت مشكلة مع السيرفر');
    }
  }

  Future<void> setToken() async {
    final prefs = await SharedPreferences.getInstance();
    final extractedUserData = json.decode(prefs.getString('userAuthData')!);
    print("sadfjkjfsadlkjfsdla ${extractedUserData}");
    _token = extractedUserData['token'];
  }
}
