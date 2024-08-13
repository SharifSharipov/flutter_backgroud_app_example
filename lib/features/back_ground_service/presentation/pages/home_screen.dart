import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/curreny_bloc/currency_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String text = "Stop Service";
  @override
  void initState() {
    context.read<CurrencyCubit>().getCurrencyPrice();
    FlutterBackgroundService().invoke("setAsForeground");
    super.initState();
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<CurrencyCubit, CurrencyState>(
        builder: (BuildContext context, CurrencyState state) {
          return Scaffold(
              appBar: AppBar(
                title: const Text("Flutter Background Service Example"),
                backgroundColor: Colors.grey.shade300.withOpacity(0.5),
              ),
              body: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) => Card(
                  child: Column(
                    children: [
                      Text(state.currencyPrice[index].code),
                      Text(state.currencyPrice[index].nbuBuyPrice),
                      Text(state.currencyPrice[index].cbPrice.toString()),
                    ],
                  ),
                ),
                separatorBuilder: (BuildContext context, int index) => const SizedBox(
                  width: 10,
                ),
                itemCount: state.currencyPrice.length,
              ));
        },
      );
}
/* Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              FlutterBackgroundService().invoke("ic_bg_service_small");
            },
            child: const Text("Foreground Service"),
          ),
          ElevatedButton(
            onPressed: () {
              FlutterBackgroundService().invoke("setAsBackground");
              print("Background Service---->ishladi");
            },
            child: const Text("Background Service"),
          ),
          ElevatedButton(
            onPressed: () async {
              final service = FlutterBackgroundService();
              bool isRunning = await service.isRunning();

              if (isRunning) {
                service.invoke("stopService");
                setState(() {
                  text = "Start Service";
                });
              } else {
                await service.startService();
                setState(() {
                  text = "Stop Service";
                });
              }
            },
            child: Text(text),
          ),
        ],
      ),
    ),*/
