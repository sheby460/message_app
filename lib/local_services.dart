import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:ffi';

class  localNotificationService {

  static final FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();

  static void initialize(){
    const InitializationSettings initializationSettings =InitializationSettings( 
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
    );

    notificationsPlugin.initialize(
     initializationSettings,
    //  onDidReceiveBackgroundNotificationResponse: (details)
    );
  }

static void createNotification(RemoteMessage message) async{
  try {
    final id = DateTime.now().microsecondsSinceEpoch ~/ 1000;
    const NotificationDetails notificationDetails = NotificationDetails(
     android: AndroidNotificationDetails("pushnotification", "pushnotificationchennel",importance: Importance.max,priority: Priority.high),

    );

    await notificationsPlugin.show(id, message.notification!.title, message.notification!.body, notificationDetails) ;   
  }on Exception catch (e) {
    print(e);
  }
}

}