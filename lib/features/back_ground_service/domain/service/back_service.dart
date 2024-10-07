import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../../../main.dart';
import '../../data/repositories/currency_repository_impl.dart';
import 'battery_optimization.dart';

Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'my_foreground',
    'MY FOREGROUND SERVICE',
    description: 'This channel is used for important notifications.',
    importance: Importance.low,
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  if (Platform.isIOS || Platform.isAndroid) {
    await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        iOS: DarwinInitializationSettings(),
        android: AndroidInitializationSettings('ic_bg_service_small'),
      ),
    );
  }

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      isForegroundMode: true, // Foreground mode-ni yoqish
      notificationChannelId: 'my_foreground',
      initialNotificationTitle: 'AWESOME SERVICE',
      initialNotificationContent: 'Initializing',
      foregroundServiceNotificationId: 888,
      foregroundServiceType: AndroidForegroundType.dataSync, // Foreground xizmat turi
    ),
    iosConfiguration: IosConfiguration(
      autoStart: true,
      onForeground: onStart,
      onBackground: onIosBackground,
    ),
  );
  if (Platform.isAndroid && Platform.version.compareTo('12') >= 0) {
    final batteryOptimizationService = BatteryOptimizationService();
    final isIgnoringBatteryOptimizations = await batteryOptimizationService.isIgnoringBatteryOptimizations();
    if (!isIgnoringBatteryOptimizations) {
      await batteryOptimizationService.requestIgnoreBatteryOptimizations();
    }
  }

  service.startService();
}

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  print("iOS background service is running");
  return true;
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();

  if (service is AndroidServiceInstance) {
    // Foreground xizmat sifatida ishlashni boshlash
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });

    service.on('stopService').listen((event) {
      service.stopSelf();
    });

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    dio.interceptors.addAll([
      LogInterceptor(),
      chuck.getDioInterceptor(),
    ]);

    final repository = CurrencyRepositoryImpl(dio: dio);

    Timer.periodic(
      const Duration(seconds: 4),
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
                  'my_foreground',
                  'MY FOREGROUND SERVICE',
                  icon: 'ic_bg_service_small',
                  playSound: false,
                  silent: true,
                  ongoing: true,
                  importance: Importance.low,
                  priority: Priority.low,
                  showWhen: false,
                ),
                iOS: DarwinNotificationDetails(
                  presentAlert: true,
                  presentBadge: true,
                  presentSound: true,
                ),
              ),
            );
          }
        } catch (e) {
          print('Error fetching currency price: $e');
        }
      },
    );
  }

  print("Foreground service is running");
  service.invoke("update");
}

/*
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

Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'my_foreground',
    'MY FOREGROUND SERVICE',
    description: 'This channel is used for important notifications.',
    importance: Importance.low,
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  if (Platform.isIOS || Platform.isAndroid) {
    await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        iOS: DarwinInitializationSettings(),
        android: AndroidInitializationSettings('ic_bg_service_small'),
      ),
    );
  }

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      isForegroundMode: false,
      notificationChannelId: 'my_foreground',
      initialNotificationTitle: 'AWESOME SERVICE',
      initialNotificationContent: 'Initializing',
      foregroundServiceNotificationId: 888,
      foregroundServiceType: AndroidForegroundType.location,
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

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsBackgroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });

    service.on('stopService').listen((event) {
      service.stopSelf();
    });

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    dio.interceptors.addAll([
      LogInterceptor(),
      chuck.getDioInterceptor(),
    ]);

    final repository = CurrencyRepositoryImpl(dio: dio);

    Timer.periodic(
      const Duration(seconds: 1),
      (timer) async {
        print("Background xizmati ishlamoqda");
        try {
          final response = await repository.getCurrencyPrice();
          if (response.isRight()) {
            final currencyPrice = response.getOrElse(() => []);
            flutterLocalNotificationsPlugin.show(
              888,
              currencyPrice.last.code,
              currencyPrice.last.cbPrice,
              const NotificationDetails(
                android: AndroidNotificationDetails('my_foreground', 'MY FOREGROUND SERVICE',
                    icon: 'ic_bg_service_small',
                    playSound: false,
                    silent: true,
                    ongoing: true,
                    importance: Importance.low,
                    priority: Priority.low,
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
          }
        } catch (e) {
          print('Error fetching currency price: $e');
        }
      },
    );
  }

  print("Fon xizmati ishlamoqda");
  service.invoke("update");
}
*/
