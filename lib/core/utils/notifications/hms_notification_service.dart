// // ignore_for_file: avoid_print
// import 'dart:convert';
// import 'dart:developer';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:hatif_mobile/di/data_layer_injector.dart';
// import 'package:hatif_mobile/domain/usecase/save_firebase_notification_token_use_case.dart';
// import 'package:huawei_push/huawei_push.dart';
// import 'package:rxdart/rxdart.dart';
// import 'notification_services.dart';
//
// class HMSNotificationServices extends NotificationServices {
//   String _token = "";
//
//   static BehaviorSubject<String>? onNotificationClick;
//
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//
//   @override
//   Future<void> initializeNotificationService() async {
//     await Push.setAutoInitEnabled(true);
//     await Push.turnOnPush();
//     Push.enableLogger();
//
//     bool isEnabled = await Push.isAutoInitEnabled();
//
//     Push.getToken("");
//     Push.getTokenStream.listen(
//       _onTokenEvent,
//       onError: (error) {
//         log("HMS Error getting token: $error");
//       },
//     );
//
//     onNotificationClick = BehaviorSubject<String>();
//
//     Push.onNotificationOpenedApp.listen(_onNotificationOpenedApp);
//     var initialNotification = await Push.getInitialNotification();
//     _onNotificationOpenedApp(initialNotification);
//
//     Push.onMessageReceivedStream.listen(_onMessageReceived);
//     await Push.registerBackgroundMessageHandler(backgroundMessageCallback);
//
//     // Initialize local notifications
//     await flutterLocalNotificationsPlugin.initialize(
//       _initializationSettings,
//       onDidReceiveNotificationResponse: (notificationResponse) {
//         onNotificationClick?.add(notificationResponse.payload ?? "");
//       },
//     );
//   }
//
//   void _onNotificationOpenedApp(dynamic remoteMessage) {
//     print("onNotificationOpenedApp: $remoteMessage");
//     if (remoteMessage != null) {
//       Map<String, dynamic> remoteNotification = {
//         "id": remoteMessage["extras"]?['id'],
//         "title": remoteMessage["extras"]?['title'],
//         "view": remoteMessage["extras"]?['view'],
//         "sectionid": remoteMessage["extras"]?['sectionid'],
//       };
//       onNotificationClick?.add(json.encode(remoteNotification));
//     }
//   }
//
//   static void backgroundMessageCallback(RemoteMessage remoteMessage) async {
//     print("backgroundMessageCallback: $remoteMessage");
//
//     final notificationData = remoteMessage.dataOfMap ?? {};
//
//     Map<String, dynamic> data = {
//       "id": notificationData['id'],
//       "title": notificationData['title'],
//       "view": notificationData['view'],
//       "sectionid": notificationData['sectionid'],
//     };
//
//     final plugin = FlutterLocalNotificationsPlugin();
//     await plugin.initialize(
//       const InitializationSettings(
//         android: AndroidInitializationSettings('@mipmap/ic_notification'),
//         iOS: DarwinInitializationSettings(),
//       ),
//     );
//
//     await plugin.show(
//       0,
//       notificationData['title'],
//       remoteMessage.data,
//       const NotificationDetails(
//         android: AndroidNotificationDetails(
//           'Notification',
//           'Notification',
//           priority: Priority.high,
//           icon: '@mipmap/ic_notification',
//         ),
//         iOS: DarwinNotificationDetails(),
//       ),
//       payload: json.encode(data),
//     );
//
//     onNotificationClick?.add(json.encode(data));
//   }
//
//   void _onMessageReceived(RemoteMessage remoteMessage) {
//     print("onMessageReceived: $remoteMessage");
//
//     final notificationData = remoteMessage.dataOfMap ?? {};
//     final message = remoteMessage.data;
//
//     Map<String, dynamic> data = {
//       "id": notificationData['id'],
//       "title": notificationData['title'],
//       "view": notificationData['view'],
//       "sectionid": notificationData['sectionid'],
//     };
//
//     _showNotificationAsLocal(
//       title: notificationData['title'],
//       message: message,
//       data: data,
//     );
//
//     if (message != null) {
//       onNotificationClick?.add(json.encode(data));
//     }
//   }
//
//   void _onTokenEvent(Object event) async {
//     _token = event.toString();
//     if (kDebugMode) {
//       log("Huawei MyToken: $_token");
//     }
//     await SveFirebaseNotificationTokenUseCase(injector())(
//       token: _token,
//     );
//   }
//
//   Future<void> _showNotificationAsLocal({
//     String? title,
//     String? message,
//     Map<String, dynamic>? data,
//   }) async {
//     await flutterLocalNotificationsPlugin.show(
//       0,
//       title,
//       message,
//       _notificationDetails,
//       payload: json.encode(data),
//     );
//   }
//
//   // Initialization Settings
//   AndroidInitializationSettings get _androidInitializationSettings =>
//       const AndroidInitializationSettings('@mipmap/ic_notification');
//
//   final DarwinInitializationSettings _iosInitializationSettings =
//       const DarwinInitializationSettings(
//     requestAlertPermission: true,
//     requestBadgePermission: true,
//     requestSoundPermission: true,
//   );
//
//   InitializationSettings get _initializationSettings => InitializationSettings(
//         android: _androidInitializationSettings,
//         iOS: _iosInitializationSettings,
//       );
//
//   // Notification Details
//   NotificationDetails get _notificationDetails => const NotificationDetails(
//         android: AndroidNotificationDetails(
//           'Notification',
//           'Notification',
//           priority: Priority.max,
//           playSound: true,
//           icon: '@mipmap/ic_notification',
//         ),
//         iOS: DarwinNotificationDetails(
//           presentAlert: true,
//           presentBadge: true,
//           presentSound: true,
//         ),
//       );
// }
