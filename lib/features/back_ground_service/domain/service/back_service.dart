import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:chuck_interceptor/chuck.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../../../main.dart';
import '../../data/repositories/currency_repository_impl.dart';

@pragma('vm:entry-point')
final service = FlutterBackgroundService();

@pragma('vm:entry-point')
Future<void> initializeService() async {
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'my_foreground',
    'MY FOREGROUND SERVICE',
    description: 'This channel is used for important notifications.',
    importance: Importance.max,
    enableLights: true,
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  if (Platform.isIOS || Platform.isAndroid) {
    await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        iOS: DarwinInitializationSettings(),
        android: AndroidInitializationSettings('ic_bg_service_small'),
      ),
    );
  }
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      isForegroundMode: true,
      // ignore: avoid_redundant_argument_values
      autoStart: true,
      notificationChannelId: 'my_foreground',
      initialNotificationTitle: 'AWESOME SERVICE',
      initialNotificationContent: 'Initializing',
      foregroundServiceNotificationId: 888,
      foregroundServiceType: AndroidForegroundType.location,
      // ignore: avoid_redundant_argument_values
      autoStartOnBoot: true,
    ),
    iosConfiguration: IosConfiguration(
      autoStart: true,
      onForeground: onStart,
      onBackground: onIosBackground,
    ),
  );
}

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  print("iOS fon xizmati ishlamoqda");
  return true;
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });

    service.on('stopService').listen((event) {
      service.stopSelf();
    });

    dio.interceptors.addAll([
      LogInterceptor(),
      chuck.getDioInterceptor(),
    ]);

    final repository = CurrencyRepositoryImpl(dio: dio);

    Timer.periodic(
      const Duration(seconds: 5),
      (timer) async {
        print("Background service is running");
        try {
          final response = await repository.getCurrencyPrice();
          if (response.isRight()) {
            final currencyPrice = response.getOrElse(() => []);
            flutterLocalNotificationsPlugin.show(
              888,
              currencyPrice.last.code,
              currencyPrice.last.cbPrice,
              const NotificationDetails(
                android: AndroidNotificationDetails(
                    'my_foreground', 'MY FOREGROUND SERVICE',
                    icon: 'ic_bg_service_small',
                    playSound: false,
                    silent: true,
                    ongoing: true,
                    importance: Importance.max,
                    priority: Priority.max,
                    showWhen: false,
                    styleInformation: BigTextStyleInformation(''),
                    color: Colors.black,
                    colorized: true,
                    setAsGroupSummary: true),
                iOS: DarwinNotificationDetails(
                  presentAlert: true,
                  presentBadge: true,
                  presentSound: true,
                ),
              ),
            );
          } else {
            print('Failed to fetch currency data');
          }
        } catch (e) {
          print('Error fetching currency price: $e');
        }
      },
    );
  } else {
    print("Service is not running on Android");
  }
  service.invoke("update");
}
