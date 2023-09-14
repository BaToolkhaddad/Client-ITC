import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../model/select_type_model.dart';
class SelectTypeProvider with ChangeNotifier {
  List<SelectTypeModel> _categories = [];

  List<SelectTypeModel> get categories {
    return [..._categories];
  }
  
  Future<void> getCategories() async {
    final url =
        Uri.parse('https://soulaf.000webhostapp.com/categories/view.php');

    final request = http.MultipartRequest('POST', url);
    request.headers['Content-Type'] = 'application/json';

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseData = await response.stream.bytesToString();
      ;
      final decodedData = json.decode(responseData.toString());
      print('reeeeeeeesponse datttaaaaa$responseData');
      final List<SelectTypeModel> loadedItems = [];
      for (var unit in decodedData['data']) {
        loadedItems.add(SelectTypeModel.fromJson(unit));
      }
      _categories = loadedItems;
      print("Data fetched successfully");
      print("Data length is ${loadedItems.length}");
    } else {
      print("Error fetching data: ${response.statusCode}");
    }
  }

  Future<void> viewItems(String id) async {
    const url = 'https://soulaf.000webhostapp.com/items/view.php';
    Uri uri = Uri.parse(url);

    try {
      Map<String, String> requestBody = <String, String>{
        'id': id,
      };
      print("boooooooooodyyyyyy is$requestBody");
      var request = http.MultipartRequest('POST', uri)
        ..fields.addAll(requestBody);
      var response = await request.send();
      final respStr = await response.stream.bytesToString();
      response.statusCode;
      if (response.statusCode != 200) {
        throw const HttpException('حدثت مشكلة أثناء عملية التعديل');
      }
    } on SocketException {
      throw const HttpException('لا يوجد اتصال بالانترنت');
    } catch (e) {
      throw const HttpException('حدثت مشكلة مع السيرفر');
    }
  }
}
