import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:message_app/firebase_options.dart';
import 'package:message_app/local_services.dart';


Future<void> backgroundHandler(RemoteMessage message) async{
  print("$message.data");
} 

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  localNotificationService.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      
        primarySwatch: Colors.blue,
      ),
      home: const AppMessage()
    );
  }
}

class AppMessage extends StatefulWidget {
  const AppMessage({super.key});

  @override
  State<AppMessage> createState() => _AppMessageState();
}

class _AppMessageState extends State<AppMessage> {
  String? deviceKey ="";
  var serverKey ="AAAA4I6VBoY:APA91bEdFqdU7RStCRbF0VxKOrkYBM0yZSpw0OaDj_6sCpsIhyS_IGu9bZ4BQx5KRc5H7_jiykmrZEvtTn2mYdGJ2rzzJH1tCpeT6NW8fbvLNgKfGqd8j6deUp_zZ-7ShElWsfg2wAky";

   getDeviceKey() async{
     try {
       deviceKey = (await FirebaseMessaging.instance.getToken());
     } catch (e) {
        print("fail to get token");
       
     }
     if (deviceKey!.isNotEmpty) {
      print("object");
       print(deviceKey);
     }
   }

      @override
  void initState() {
   getDeviceKey();
    super.initState();
  }
     

  // @override
  // void initState() {
  //   FirebaseMessaging.instance.getInitialMessage().then((message) {
  //     print("app terminated");

  //     if(message != null){
  //       print("new notification");

  //               localNotificationService.createNotification(message);

  //     }
  //   });

  //   FirebaseMessaging.onMessage.listen((message) { 
  //    print("app is running foreground");

  //    if(message.notification != null){
  //       print(message.notification!.title);
  //       print(message.notification!.body);

  //       localNotificationService.createNotification(message);
  //    }
  //   });

  //   FirebaseMessaging.onMessageOpenedApp.listen((message) { 
  //     print("app is running in background");

  //     if(message.notification != null){
  //       print(message.notification!.title);
  //       print(message.notification!.body);
  //     }
  //   });

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Flutter notification'),
      ),
      body: const Center(
        child: Text('push notification'),
      ),
    );
  }
}