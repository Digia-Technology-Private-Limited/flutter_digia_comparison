import 'package:digia_ui/digia_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_digia_comparison/performance_landing.dart';

// import 'performance_landing.dart';
// // Stub imports for each benchmark screen
// import 'static_list_screen.dart';
// import 'animation_screen.dart';
// import 'form_api_screen.dart';
// import 'navigation_screen.dart';
// import 'cpu_memory_screen.dart';

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

  // Optional: style the status bar
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
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
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/': (context) => const PerformanceLanding(),
        // '/staticList': (context) => const StaticListScreen(),
        // '/animationScreen': (context) => const AnimationScreen(),
        // '/formApi': (context) => const FormApiScreen(),
        // '/navigation': (context) => const NavigationScreen(),
        // '/cpuMemory': (context) => const CpuMemoryScreen(),
      },
    );
  }
}
