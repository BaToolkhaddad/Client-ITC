  import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../helper/app_config.dart';
import '../view/screen/pending.dart';
class MakeAppointmentProvider with ChangeNotifier {
Future<void> makeAppointment(
      String name,String old , String phone, String gender , String bookingStatus,
      {required BuildContext context}) async {
    try {
      const url = '${APP_BASE_URL}/';
      Uri uri = Uri.parse(url);

      Map<String, String> requestBody = <String, String>{
        'use_name': name,
        'user_old': old,
        'user_phone': phone,
        'user_gender': gender,
        'booking_status': bookingStatus,
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
         // ignore: use_build_context_synchronously
         AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.leftSlide,
          desc: 'فشل في إرسال الطلب , الرجاء التحقق من الاتصال بالانترنت و إعادة المحاولة ',
          btnOkIcon: Icons.check_circle,
          btnOkOnPress: () =>
              Navigator.of(context).pop(),
          // ignore: use_build_context_synchronously
          btnOkColor: Theme.of(context).primaryColor,
          onDismissCallback: (_) =>
              Navigator.of(context).pop(),
        ).show();
      } else {
        // ignore: use_build_context_synchronously
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.leftSlide,
          desc: 'تم إرسال طلبك بنجاح',
          btnOkIcon: Icons.check_circle,
          btnOkOnPress: () =>
              Navigator.of(context).pushReplacementNamed(OrdersPending.routeName),
          // ignore: use_build_context_synchronously
          btnOkColor: Theme.of(context).primaryColor,
          onDismissCallback: (_) =>
              Navigator.of(context).pushReplacementNamed(OrdersPending.routeName),
        ).show();
      }
    } catch (error) {
      print(error);
    }
  }
}