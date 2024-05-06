// import 'dart:developer';
// import 'dart:ui';
// import 'dart:io';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;

// class NotificationService {
//   final FlutterLocalNotificationsPlugin notificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   Future<void> initNotification() async {
//     AndroidInitializationSettings initializationSettingsAndroid =
//         const AndroidInitializationSettings('@mipmap/ic_launcher');


//     var initializationSettings = InitializationSettings(
//         android: initializationSettingsAndroid);

//     tz.initializeTimeZones();

//     await notificationsPlugin.initialize(initializationSettings,
    
//         onDidReceiveNotificationResponse: (payload) async {});
//   }

//   checkActive()async{
//     var x = await notificationsPlugin.getActiveNotifications();
//     print(x);
//   }

//   notificationDetails() {
//     return const NotificationDetails(
      
//         android: AndroidNotificationDetails('channelId', 'channelName',
//             importance: Importance.max,
            
//             ),
//         );
//   }

//   Future showNotification(
//       {int id = 0, String? title, String? body, String? payLoad}) async {
//     return notificationsPlugin.show(
//         id, title, body, await notificationDetails());
//   }

//   Future cancelAllNotifs(){
//     log("Cancelling notifications");
//     return notificationsPlugin.cancelAll();
//   }

//   Future scheduleNotification(
//       {int id = 0,
//       String? title,
//       String? body,
//       String? payLoad,}) async {
//         log("scheduling notification");
//     return notificationsPlugin.periodicallyShow(
//         id,
//         title,
//         body,
//         RepeatInterval.everyMinute,
//         await notificationDetails(),
//         androidAllowWhileIdle: true,);
//   }

// }