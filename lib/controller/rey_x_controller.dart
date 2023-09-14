import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../helper/app_config.dart';
import '../model/radial_info.dart';

class InfoRayXProvider with ChangeNotifier {
  List<RadialInfoModel> listInfoRayx = [];

  List<RadialInfoModel> get infoRayx {
    return [...listInfoRayx];
  }

  String? _token;

  Future<void> getInfoRayx() async {
    await setToken();
    final url =
        Uri.parse('${APP_BASE_URL}/items/Radiation');
    print("fdsajhkjhafsdkj ${_token}");
    final response =
        await http.get(url, headers: {'Authorization': 'Bearer $_token'});

    print("rejklsadjkflksfda ${response.statusCode}");
    print("rejklsadjkflksfda ${response.body}");
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);
      final List<RadialInfoModel> loadedItems = [];

      for (var unit in decodedData['data']) {
        print("sfdjakjfsaldjldfs ${decodedData['data']}");
        loadedItems.add(RadialInfoModel.fromJson(unit));
      }

      listInfoRayx = loadedItems;
      print("Data fetched successfully");
      print("Data length is ${loadedItems.length}");
    } else {
      print("Error fetching data: ${response.statusCode}");
    }

    notifyListeners();
  }

  Future<void> setToken() async {
    final prefs = await SharedPreferences.getInstance();
    final extractedUserData = json.decode(prefs.getString('userAuthData')!);
    print("sadfjkjfsadlkjfsdla ${extractedUserData}");
    _token = extractedUserData['token'];
  }
}
