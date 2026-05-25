import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  static Future<void> init() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    await messaging.requestPermission();

    String? token = await messaging.getToken();

    print(token);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print(message.notification?.title);
    });
  }
}
