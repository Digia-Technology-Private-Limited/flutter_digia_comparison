import 'package:digia_ui/digia_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_digia_comparison/performance_landing.dart';

final Stopwatch startupStopwatch = Stopwatch();

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  startupStopwatch.start();
  print('⏳ Started Stopwatch: ${startupStopwatch.elapsedMilliseconds} ms');

  final Stopwatch digiaInitStopwatch = Stopwatch()..start();
  await DigiaUIClient.init(
    accessKey: "667301a6b6c3bd6fb255ec0d",
    flavorInfo: Release(PrioritizeNetwork(500), 'assets/digia/appConfig.json', 'assets/digia/function.js'),
    environment: Environment.development.name,
    baseUrl: "https://app.digia.tech/api/v1",
    networkConfiguration: NetworkConfiguration(
      defaultHeaders: {},
      timeout: 30,
    ),
  );
  DUIFactory().initialize();
  digiaInitStopwatch.stop();
  print('⏳ Digia SDK Init Time: ${digiaInitStopwatch.elapsedMilliseconds} ms');

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
