import 'package:client_itc/main.dart';
import 'package:client_itc/view/screen/pending.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> handelBackgroundMessage(RemoteMessage? message) async {
  // ignore: unnecessary_null_comparison
  if (message == null) return;

  navigatorKey.currentState
      ?.pushNamed(OrdersPending.routeName, arguments: message);
}

void handelMessage(RemoteMessage? message) async {
  // ignore: unnecessary_null_comparison
  if (message == null) return;
  navigatorKey.currentState
      ?.pushNamed(OrdersPending.routeName, arguments: message);
}

Future initPushNotification() async {
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  FirebaseMessaging.instance.getInitialMessage().then(handelMessage);
  FirebaseMessaging.onMessageOpenedApp.listen(handelMessage);
  FirebaseMessaging.onBackgroundMessage(handelBackgroundMessage);
  FirebaseMessaging.onMessage.listen((message) {
    final notification = message.notification;
    if (notification == null) return;
  });
}

class FirebaseApi {
  final firebaseMessaging = FirebaseMessaging.instance;
  final androidChannel = const AndroidNotificationChannel(
    'High importanc channel',
    'High importanc notification',
    description: 'This channel is used important notificatin',
    importance: Importance.defaultImportance,
  );
  final localnotification = FlutterLocalNotificationsPlugin();
  Future<void> initNotification() async {
    await firebaseMessaging.requestPermission();
    final fCmToken = await firebaseMessaging.getToken();
    print('fcm Token $fCmToken');
    initPushNotification();
  }
}
