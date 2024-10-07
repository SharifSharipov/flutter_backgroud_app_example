/*
// this will be used as notification channel id
import 'dart:async';
import 'dart:convert';

import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

//import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';

import 'package:latlong2/latlong.dart';
import 'package:orientir/credential/supabase_cred.dart';

import 'package:orientir/data/data_handler.dart';
import 'package:orientir/main.dart';
import 'package:orientir/models/new_orientri_model.dart';
import 'package:orientir/models/orientir_model.dart';
import 'package:orientir/models/track_model.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

//const notificationChannelId = 'my_foreground';

// this will be used for notification id, So you can update your custom notification with this id.
//const notificationId = 888;

Future<void> initializeService(service) async {
  // const AndroidNotificationChannel channel = AndroidNotificationChannel(
  //   notificationChannelId, // id
  //   'Отряд 111.62', // title
  //   description:
  //       'This channel is used for important notifications.', // description
  //   importance: Importance.max,
  //   enableVibration: true,
  //   playSound: true,
  //   sound: RawResourceAndroidNotificationSound(
  //       'excuse'), // importance must be at low or higher level
  // );

  // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();

  //  await flutterLocalNotificationsPlugin
  //      .resolvePlatformSpecificImplementation<
  //          AndroidFlutterLocalNotificationsPlugin>()!
  //     .createNotificationChannel(channel);

  // // await flutterLocalNotificationsPlugin
  // //     .resolvePlatformSpecificImplementation<
  // //         AndroidFlutterLocalNotificationsPlugin>()
  // //     ?.requestNotificationsPermission();

  await service.configure(
      androidConfiguration: AndroidConfiguration(
        // this will be executed when app is in foreground or background in separated isolate
        onStart: onStart,

        //19_05_2024////////////
        autoStartOnBoot: true, //
        //19_05_2024////////////

        // auto start service
        autoStart: true,
        isForegroundMode: true,

        // notificationChannelId:
        //     notificationChannelId, // this must match with notification channel you created above.
        // initialNotificationTitle: 'Отряд 111.62',
        // initialNotificationContent: 'Initializing',
        ////////foregroundServiceNotificationId: notificationId,
      ),
      iosConfiguration: IosConfiguration(
        // auto start service
        autoStart: true,

        // this will be executed when app is in foreground in separated isolate
        onForeground: onStart,

        // you have to enable background fetch capability on xcode project
      ));
}

@pragma('vm:entry-point')
Future<void> onStart(ServiceInstance service) async {
  service.on('stopBgService').listen((event) async {
    await service.stopSelf();
  });

  await Supabase.initialize(
      url: 'https://lghihjzdbcxlxsgcaqau.supabase.co',
      anonKey:
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxnaGloanpkYmN4bHhzZ2NhcWF1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTMxNTk5NDcsImV4cCI6MjAyODczNTk0N30.nWqO13XaI8gL-JbvKYYqkMVh8qiS7QrVvcsjey5hwn8');

  // Only available for flutter 3.0.0 and later

  SharedPreferences prefs = await SharedPreferences.getInstance();
  var user = await supabase.auth.getUser();
  NewOrientriModel? omforRecord;
  List<LatLng> posList = [];

  Track? trackForRecord;

  Stream updateOmForRecord = service.on('updateOmForRecord');
  updateOmForRecord.listen((event) async {
    if (event!['om'] != null) {
      omforRecord = NewOrientriModel.fromJson(event['om']);
      //print('''object''');
    } else {
      if (omforRecord != null && omforRecord!.listTrack.isNotEmpty) {
        Track? curRecTrack = omforRecord!.listTrack
            .firstWhere((element) => element.isRecord == true);
        curRecTrack.listLatLng.clear();
        curRecTrack.listLatLng = posList;
        curRecTrack.isRecord = false;

        savePosition(omforRecord!, prefs);
        posList.clear();
      }

      omforRecord = null;
    }
    print('gopa1');
  });
  //Track job ////////////////////////////////////////////////////////////
  Stream trackJobStream = service.on('trackJob');
  trackJobStream.listen((data) async {
    var temp = data['track'];
    if (data['track'] != '') {
      trackForRecord = Track.fromJson(data['track']);
      trackForRecord!.isRecord = true;

      print(data);
    } else {
      if (trackForRecord != null && trackForRecord!.listLatLng.isNotEmpty) {
        trackForRecord!.isRecord = false;
        trackForRecord!.endDate = DateTime.now();
        await saveTrack(trackForRecord!, prefs);

        service.invoke('updateTrack', {'track': trackForRecord!.toJson()});
      }
      await stopAllTrack(prefs);

      trackForRecord = null;
    }

    print(data);
  });
  ////////////////////////////////////////////////////////////////////////

  //////////////////////////////////////final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //////////////////////////////////////////FlutterLocalNotificationsPlugin();

  RealtimeChannel? channel;

  try {
    channel = supabase.channel('Orientir');
    channel
        .onPostgresChanges(
      event: PostgresChangeEvent.all,
      schema: 'public',
      table: 'Orientirs',
      callback: (payload) {
        if (payload.eventType == PostgresChangeEvent.insert) {
          NewOrientriModel omFromDb =
          NewOrientriModel.fromMap(payload.newRecord['orientir_model']);
          // omFromDb.idBd = payload.newRecord['id'];
          // omFromDb.saveInBd = true;
          DataHandler.saveOrientir(omFromDb);
          DataHandler.getFileFromServer('${omFromDb.id}.jpg');
          // flutterLocalNotificationsPlugin.show(
          //     notificationId,
          //     'Новая ориентировка',
          //     '${omFromDb.surName} ${omFromDb.name} ${omFromDb.fathName}',
          //     const NotificationDetails(
          //         android: AndroidNotificationDetails(
          //             importance: Importance.max,
          //             enableVibration: true,
          //             playSound: true,
          //             sound: RawResourceAndroidNotificationSound('excuse'),
          //             //showWhen: false,
          //             notificationChannelId,
          //             'Отряд 111.62',
          //             icon: '@mipmap/ic_launcher',
          //             ongoing: true,
          //             priority: Priority.high)));
        }
        if (payload.eventType == PostgresChangeEvent.delete) {
          NewOrientriModel omFromDb =
          NewOrientriModel.fromMap(payload.oldRecord['orientir_model']);
          // omFromDb.idBd = payload.oldRecord['id'];
          // omFromDb.saveInBd = true;
          DataHandler.deleteOrientir(omFromDb, true);
        }
      },
    )
        .subscribe();
  } catch (e) {
    print(e);
  }

  StreamSubscription? positionStr = positionStream?.listen((position) async {
    print(position);
    posList.add(LatLng(position.latitude, position.longitude));
    omforRecord?.listTrack.last.listLatLng
        .add(LatLng(position.latitude, position.longitude));


    savePosition(omforRecord!, prefs);
    //var user = await supabase.auth.getUser();
    try {
      await supabase.from('cur_places_rescuers').upsert(onConflict: 'email', {
        'lat': position.latitude,
        'lon': position.longitude,
        'user': user.user?.id,
        'last_date_update': DateTime.now().toUtc().toIso8601String(),
        'user_info': user.user!.userMetadata,
        'email': user.user!.email
      })
      //.eq('user', user.user!.id)
          ;
    } catch (e) {
      // await supabase
      //     .from('cur_places_rescuers')
      //     .update({
      //       'lat': position.latitude,
      //       'lon': position.longitude,
      //       'user': user.user?.id,
      //       'last_date_update': DateTime.now().toUtc().toIso8601String(),
      //       'user_info': user.user!.userMetadata,
      //       'email': user.user!.email
      //     })
      //     .eq('user', user.user!.id)
      //     .timeout(const Duration(seconds: 10));

      print('error_insert_supabase');
    }

    // flutterLocalNotificationsPlugin.show(
    //     notificationId,
    //     'Get GPS',
    //     position.toString(),

    //     const NotificationDetails(
    //         android: AndroidNotificationDetails(
    //           enableLights: true,
    //           importance: Importance.max,
    //       enableVibration: true,
    //       playSound: true,
    //       sound: RawResourceAndroidNotificationSound('excuse'),
    //       //showWhen: false,
    //       notificationChannelId,
    //       'Отряд 111.62',
    //       icon: '@mipmap/ic_launcher',
    //       ongoing: true,
    //       priority: Priority.high
    //     )));

    try {
      if (omforRecord != null) {
        service.invoke(
          'update',
          {
            "current_date": DateTime.now().toIso8601String(),
            "position": position,
          },
        );
      }
    } catch (e) {
      print(e);
    }
    if (trackForRecord != null) {
      trackForRecord!.listLatLng
          .add(LatLng(position.latitude, position.longitude));
      saveTrack(trackForRecord!, prefs);

      service.invoke('updateTrack', {'track': trackForRecord!.toJson()});
    }
  });

   //bring to foreground
   Timer.periodic(const Duration(seconds: 10), (timer) async {
     flutterLocalNotificationsPlugin.show(
         notificationId,
         'Новая ориентировка',
         'ГыГы',

         const NotificationDetails(
             android: AndroidNotificationDetails(
               enableLights: true,
               importance: Importance.max,
           enableVibration: true,
           playSound: true,
           sound: RawResourceAndroidNotificationSound('excuse'),
           //showWhen: false,
           notificationChannelId,
           'Отряд 111.62',
           icon: '@mipmap/ic_launcher',
           ongoing: true,
           priority: Priority.high
         )));

  Stream onGeoLocation = service.on('onOfGeoLocation');
  onGeoLocation.listen((event) async {
    print('init');
    if (event!['on']) {
      positionStr = Geolocator.getPositionStream(
          locationSettings: const LocationSettings(
              accuracy: LocationAccuracy.best, distanceFilter: 3))
          .listen((position) async {
        try {
          if (omforRecord != null) {
            service.invoke(
              'update',
              {
                "current_date": DateTime.now().toIso8601String(),
                "position": position,
              },
            );

            posList.add(LatLng(position.latitude, position.longitude));
            omforRecord?.listTrack.last.listLatLng
                .add(LatLng(position.latitude, position.longitude));

            //DataHandler.saveOrientir(omforRecord!, false);
            savePosition(omforRecord!, prefs);
          }
        } catch (e) {
          print(e);
        }
        if (trackForRecord != null) {
          trackForRecord!.listLatLng
              .add(LatLng(position.latitude, position.longitude));
          saveTrack(trackForRecord!, prefs);
          service.invoke('updateTrack', {'track': trackForRecord!.toJson()});
        }
        print(position);

        //var user = await supabase.auth.getUser();
        try {
          await supabase
              .from('cur_places_rescuers')
              .upsert(onConflict: 'user', {
            'lat': position.latitude,
            'lon': position.longitude,
            'user': user.user?.id,
            'last_date_update': DateTime.now().toUtc().toIso8601String(),
            'user_info': user.user!.userMetadata,
            'email': user.user!.email
          })
          //.eq('user', user.user!.id)
              ;
          print('No_error_insert_supabase');
        } catch (e) {
          // await supabase.from('cur_places_rescuers').update({
          //   'lat': position.latitude,
          //   'lon': position.longitude,
          //   'user': user.user?.id,
          //   'last_date_update': DateTime.now().toUtc().toIso8601String(),
          //   'user_info': user.user!.userMetadata,
          //   'email': user.user!.email
          // }).eq('user', user.user!.id);

          print('error_insert_supabase');
        }
      });
    } else {
      positionStr?.cancel();
      await supabase
          .from('cur_places_rescuers')
          .delete()
          .eq('user', user.user!.id);
    }
  });
}

void savePosition(NewOrientriModel om, SharedPreferences prefs) async {
  Map orientirsMap = {};

  //SharedPreferences prefs = await SharedPreferences.getInstance();

  var result = prefs.getString('orientirsMap');

  if (result != null) {
    orientirsMap = jsonDecode(result);

    orientirsMap[om.id] = om.toJson();
  } else {
    orientirsMap[om.id] = om.toJson();
  }

  await prefs.setString('orientirsMap', jsonEncode(orientirsMap));

  prefs.reload();
}

Future saveTrack(Track track, SharedPreferences prefs) async {
  Map listrack = {};

  var result = prefs.getString('listTrack');

  if (result != null) {
    listrack = jsonDecode(result);

    listrack[track.id] = track.toJson();
  } else {
    listrack[track.id] = track.toJson();
  }

  await prefs.setString('listTrack', jsonEncode(listrack));
}

Future stopAllTrack(SharedPreferences prefs) async {
  Map listrack = {};

  var result = prefs.getString('listTrack');

  if (result != null) {
    listrack = jsonDecode(result);
    print(listrack);
    listrack.forEach((key, val) {
      Track curTrack = Track.fromJson(val);
      curTrack.isRecord = false;

      listrack[curTrack.id] = curTrack.toJson();
    });
    //listrack[track.id] = track.toJson();
  } else {
    //listrack[track.id] = track.toJson();
  }

  await prefs.setString('listTrack', jsonEncode(listrack));
}*/
