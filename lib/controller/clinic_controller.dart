import 'dart:convert';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../helper/app_config.dart';
import '../model/clinic_model.dart';

class ClinicProvider with ChangeNotifier {
  List<ClinicModel> listClinic = [];

  List<ClinicModel> get clinic {
    return [...listClinic];
  }

  String? _token;

  Future<void> getLabs() async {
    await setToken();
    final url = Uri.parse('${APP_BASE_URL}/clinc');
    
    final response =
        await http.get(url, headers: {'Authorization': 'Bearer $_token'});

    print("statusCooode ${response.statusCode}");
    print("booody ${response.body}");
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);
      final List<ClinicModel> loadedItems = [];

      for (var unit in decodedData['data']) {
        print("sfdjakjfsaldjldfs ${decodedData['data']}");
        loadedItems.add(ClinicModel.fromJson(unit));
      }

      listClinic = loadedItems;
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
