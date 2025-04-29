import 'package:digia_ui/digia_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_digia_comparison/performance_landing.dart';

final Stopwatch startupStopwatch = Stopwatch();
const String initMode = String.fromEnvironment('init_mode');

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  startupStopwatch.start();
  print('Cold Start Stopwatch Started: ${startupStopwatch.elapsedMilliseconds} ms');

  if (initMode != 'noDigia') {
    final Stopwatch digiaInitStopwatch = Stopwatch();
    digiaInitStopwatch..start();

    await DigiaUIClient.init(
      accessKey: "...",
      flavorInfo: initMode == 'networkInit'
          ? Release(PrioritizeNetwork(500), 'assets/digia/appConfig.json', 'assets/digia/function.js')
          : Release(PrioritizeCache(), 'assets/digia/appConfig.json', 'assets/digia/function.js'),
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
  }

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
