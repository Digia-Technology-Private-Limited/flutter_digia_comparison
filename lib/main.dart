import 'package:digia_ui/digia_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_digia_comparison/performance_landing.dart';

final Stopwatch startupStopwatch = Stopwatch()..start(); // ✅ Start stopwatch early

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DigiaUIClient.init(
    accessKey: "680b92c50cbe7e3316c4dbc3",
    flavorInfo: Debug("main"),
    environment: Environment.development.name,
    baseUrl: "https://app.digia.tech/api/v1",
    networkConfiguration: NetworkConfiguration(
      defaultHeaders: {},
      timeout: 30,
    ),
  );

  DUIFactory().initialize();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.black,
    statusBarIconBrightness: Brightness.light,
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Digia vs Flutter Performance',
      debugShowCheckedModeBanner: true,
      theme: ThemeData.dark(),
      builder: (context, child) => child!,
      initialRoute: '/',
      routes: {
        '/': (context) => const PerformanceLanding(),
      },
    );
  }
}
