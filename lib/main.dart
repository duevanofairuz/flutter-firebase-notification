// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_learn/firebase_options.dart';
// import 'package:flutter/material.dart';
//
// import 'pages/home_page.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: HomePage(),
//     );
//   }
// }


// import 'package:firebase_learn/screens/home.dart';
// import 'package:firebase_learn/screens/login.dart';
// import 'package:firebase_learn/screens/register.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(initialRoute: 'login', routes: {
//       'home': (context) => const HomeScreen(),
//       'login': (context) => const LoginScreen(),
//       'register': (context) => const RegisterScreen(),
//     });
//   }
// }


import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_learn/screens/home_screen.dart';
import 'package:firebase_learn/screens/second_screen.dart';
import 'package:firebase_learn/services/notification_service.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initializeNotification();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // get token android
  final fcmToken = await FirebaseMessaging.instance.getToken();
  if(fcmToken!=null){
    //do something
    print("token: ${fcmToken}");
  }

  // Background message handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

// Handler untuk notifikasi saat app di background/terminated
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: message.hashCode,
      channelKey: 'basic_channel',
      title: message.notification?.title,
      body: message.notification?.body,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notification Demo',
      routes: {
        'home': (context) => const HomeScreen(),
        'second': (context) => const SecondScreen(),
      },
      initialRoute: 'home',
      navigatorKey: navigatorKey,
    );
  }
}
