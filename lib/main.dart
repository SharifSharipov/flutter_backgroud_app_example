import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_backgroud_app_example/features/back_ground_service/data/repositories/currency_repository_impl.dart';
import 'package:flutter_backgroud_app_example/features/back_ground_service/domain/service/back_service.dart';
import 'package:flutter_backgroud_app_example/features/back_ground_service/presentation/pages/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import 'features/back_ground_service/presentation/manager/curreny_bloc/currency_bloc.dart';

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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CurrencyCubit(
              CurrencyRepositoryImpl(
                dio: Dio(),
              ),
          ),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const HomeScreen()),
    );
  }
}
