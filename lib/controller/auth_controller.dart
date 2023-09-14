import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:client_itc/view/screen/auth/login.dart';
import 'package:client_itc/view/screen/auth/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../core/constant/color.dart';
import '../helper/app_config.dart';

class Auth with ChangeNotifier {
  String? token;
  String? id;

  String? get tokenList {
    return token;
  }

  String? get ownerId {
    return id;
  }

  bool get isAuth {
    return token != null;
  }

//___________________________________________________________________________________

  Future<void> signup(
      String name, String phone, String idNumber, String password,
      {required BuildContext context}) async {
    try {
      const url = '${APP_BASE_URL}/register';
      Uri uri = Uri.parse(url);

      Map<String, String> requestBody = <String, String>{
        'name': name,
        'user_phone': phone,
        'user_ident': idNumber,
        'password': password,
        'city_id': '1',
        'id': '11',
        "updated_at": "2023-07-05T08:38:44.000000Z",
        "created_at": "2023-07-05T08:38:44.000000Z",
      };
      var request = http.MultipartRequest('POST', uri)
        ..fields.addAll(requestBody);
      print('requestBody is : $requestBody');

      var response = await request.send();
      final respStr = await response.stream.bytesToString();
      response.statusCode;
      print('status code: ${response.statusCode}');
      print('response body: $respStr');

      if (response.statusCode != 200) {
        Fluttertoast.showToast(
          msg: 'فشل في إنشاء الحساب',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 9,
          backgroundColor: Colors.red,
          textColor: AppColor.white,
        );
      } else {
        // ignore: use_build_context_synchronously
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.leftSlide,
          desc: 'تم إنشاء الحساب بنجاح',
          btnOkIcon: Icons.check_circle,
          btnOkOnPress: () =>
              Navigator.of(context).pushReplacementNamed(LoginPage.routeName),
          // ignore: use_build_context_synchronously
          btnOkColor: Theme.of(context).primaryColor,
          onDismissCallback: (_) =>
              Navigator.of(context).pushReplacementNamed(LoginPage.routeName),
        ).show();
      }
    } catch (error) {
      print(error);
    }
  }

//____________________________________________________________________________
  Future<void> login(
    String idNumber,
    String password,
  ) async {
    const url = '${APP_BASE_URL}/login';
    Uri uri = Uri.parse(url);

    Map<String, String> requestBody = <String, String>{
      'user_ident': idNumber,
      'password': password,
    };
    print("requestbooooodyyy is$requestBody");
    var request = http.MultipartRequest('POST', uri)
      ..fields.addAll(requestBody);

    var response = await request.send();
    final respStr = await response.stream.bytesToString();
    print("This is the Status Cooooode${response.statusCode}");
    print("This is the Status Cooooode$respStr");
    // print('iiiidddddddddauuuuthe $id');
    var responseData = jsonDecode(respStr);
    token = responseData["data"]['token'];
    // id = responseData["data"]['user']['id'];
    print("sdafjlkasjfdldjfsa ${ownerId}");
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    final userAuthData = json.encode({
      'token': token,
      // 'id': id,
    });

    await prefs.setString('userAuthData', userAuthData);
  }

//_________________________________________________________________________________
  Future<void> logout() async {
    try {
      print("tjsfdljalfsdakj ${token}");
      const url = '${APP_BASE_URL}/logout';
      Uri uri = Uri.parse(url);
      var response =
          await http.post(uri, headers: {'Authorization': 'Bearer $token'});
      print("logout ${response.statusCode}");
      print("logout ${response.body}");
      if (response.statusCode != 200) {
        throw "some thing get wrong";
      } else {
        token = null;
        // notifyListeners();
      }
    } catch (error) {
      debugPrint("logout $error");
    }
  }

  //_______________________________________________________________________________

  Future<void> deleteAccount(
    String id,
    BuildContext context,
  ) async {
    try {
      final url = '${APP_BASE_URL}/delete/$id';
      final uri = Uri.parse(url);
      final response = await http.delete(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      print("delete ${response.statusCode}");
      print("delete ${response.body}");
      if (response.statusCode != 200) {
        print('فشل حذف الحساب');
        Fluttertoast.showToast(
          msg: 'فشل في إنشاء الحساب',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 9,
          backgroundColor: Colors.red,
          textColor: AppColor.white,
        );
      } else {
        // ignore: use_build_context_synchronously
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.leftSlide,
          desc: 'تم حذف الحساب ',
          btnOkIcon: Icons.check_circle,
          btnOkOnPress: () =>
              Navigator.of(context).pushReplacementNamed(SignUpPage.routeName),
          // ignore: use_build_context_synchronously
          btnOkColor: Theme.of(context).primaryColor,
          onDismissCallback: (_) =>
              Navigator.of(context).pushReplacementNamed(SignUpPage.routeName),
        ).show();
        print('تم حذف الحساب');
      }
    } catch (error) {
      debugPrint("delete $error");
    }
  }

//_________________________________________________________________________________
  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    print("fsadfssdaffsd ${prefs.containsKey('userAuthData')}");
    if (!prefs.containsKey('userAuthData')) {
      return false;
    }
    final extractedUserData = json.decode(prefs.getString('userAuthData')!);
    print("sadfjkjfsadlkjfsdla ${extractedUserData}");
    token = extractedUserData['token'];
    // id = extractedUserData["data"]['user']['id'];
    notifyListeners();
    return true;
  }
}
