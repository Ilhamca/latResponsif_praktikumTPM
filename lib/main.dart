import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'controllers/auth_controller.dart';
import 'screens/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox<String>('users');
  runApp(const InfoHubApp());
}

class InfoHubApp extends StatelessWidget {
  const InfoHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Info Hub',
      initialBinding: BindingsBuilder(() {
        Get.put(AuthController(), permanent: true);
      }),
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1F6F8B)),
        scaffoldBackgroundColor: const Color(0xFFF4F7FB),
      ),
      home: const LoginPage(),
    );
  }
}
