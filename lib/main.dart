import 'package:chuck_interceptor/chuck.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_backgroud_app_example/features/back_ground_service/data/repositories/currency_repository_impl.dart';
import 'package:flutter_backgroud_app_example/features/back_ground_service/domain/service/back_service.dart';
import 'package:flutter_backgroud_app_example/features/back_ground_service/presentation/pages/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import 'features/back_ground_service/presentation/manager/curreny_bloc/currency_bloc.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final Chuck chuck = Chuck(navigatorKey: navigatorKey);
final Dio dio = Dio();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });
  await initializeService();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    dio.interceptors.addAll([
      LogInterceptor(),
      chuck.getDioInterceptor(),
      InterceptorsWrapper(
        onRequest: (options, handler) {
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioError e, handler) {
          return handler.next(e);
        },
      ),
    ]);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CurrencyCubit(
            CurrencyRepositoryImpl(
              dio: dio,
            ),
          ),
        ),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
