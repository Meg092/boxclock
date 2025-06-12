import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:week_clock/pages/week_failed/check_init.dart';
import 'package:week_clock/pages/week_failed/week_failed_binding.dart';
import 'package:week_clock/pages/week_failed/week_failed_view.dart';
import 'package:week_clock/pages/week_land/week_land_binding.dart';
import 'package:week_clock/pages/week_land/week_land_view.dart';
import 'package:week_clock/pages/week_main/week_main_binding.dart';
import 'package:week_clock/pages/week_main/week_main_view.dart';
import 'package:week_clock/pages/week_setting/week_setting_binding.dart';
import 'package:week_clock/pages/week_setting/week_setting_view.dart';

Color primaryColor = Colors.black;
Color bgColor = Colors.black;

const String generalFamily = 'General';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final colors = prefs.getStringList('color');
  if (colors == null) {
    await prefs.setStringList('color', ['255', '255', '255']);
    await prefs.setInt('mode', 0);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: BoxClock,
      initialRoute: '/weekMain',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: primaryColor,
        scaffoldBackgroundColor: bgColor,
        colorScheme: ColorScheme.light(
          primary: primaryColor,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: primaryColor,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        cardTheme: const CardTheme(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        dialogTheme: const DialogTheme(
          actionsPadding: EdgeInsets.only(right: 10, bottom: 5),
        ),
        dividerTheme: DividerThemeData(
          thickness: 1,
          color: Colors.grey[200],
        ),
      ),
    );
  }
}

List<GetPage<dynamic>> BoxClock = [
  GetPage(name: '/', page: () => const WeekLandView(), binding: WeekLandBinding()),
  GetPage(name: '/failed', page: () => const WeekFailedView(), binding: WeekFailedBinding()),
  GetPage(name: '/weekMain', page: () => const WeekMainPage(),  binding: WeekMainBinding()),
  GetPage(name: '/weekTab', page: () => const CheckInit()),
  GetPage(name: '/weekSetting', page: () => WeekSettingPage(),  binding: WeekSettingBinding()),
];
