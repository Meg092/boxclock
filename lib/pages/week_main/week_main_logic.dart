import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WeekMainLogic extends GetxController {
  Timer? _timer;

  var textColor = Colors.white.obs;
  var mode = 0.obs;

  var weekDay = 1.obs;
  var hourMinutesStr = '00:00'.obs;
  var secondStr = '00'.obs;
  var apmStr = 'AM'.obs;

  var c = 30.0.obs;

  var type = 1.obs;
  var typeStr = 'Sunny'.obs;

  void getData() {
    final now = DateTime.now();
    weekDay.value = now.weekday;
    hourMinutesStr.value = DateFormat('hh:mm').format(now);
    secondStr.value = DateFormat('ss').format(now);
    apmStr.value = DateFormat('a').format(now).toUpperCase();
  }

  void startTimer() {
    getData();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      getData();
    });
  }

  Map<int, String> weatherCodeMap = {
    0: 'Sunny',
    1: 'Cloudy',
    2: 'Cloudy',
    3: 'Cloudy',
    51: 'Rain',
    61: 'Rain',
    80: 'Rain',
    95:  'Thunderstorm',
    96: 'Thunderstorm',
    99: 'Thunderstorm',
  };

  Future<Map<String, dynamic>> fetchWeatherFor(
      double latitude, double longitude) async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://api.open-meteo.com/v1/forecast?'
                'latitude=$latitude&longitude=$longitude'
                '&hourly=temperature_2m,weathercode'
                '&timezone=auto'
                '&forecast_days=1'
        ),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load weather: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<void> _checkLocationPermission() async {
    final status = await Permission.locationWhenInUse.request();
    if (status.isGranted) {
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.low,
          distanceFilter: 1000,
        ),
      );

      final weatherData = await fetchWeatherFor(position.latitude, position.longitude);
      final data = weatherData;
      final hourly = data['hourly'];
      final temps = (hourly['temperature_2m'] as List).cast<double>();
      final codes = (hourly['weathercode'] as List).cast<int>();
      final nowHour = DateTime.now().hour;
      final hereWeatherCode = weatherCodeMap[codes[nowHour]];
      c.value = temps[nowHour];
      if (hereWeatherCode == 'Cloudy') {
        type.value = 0;
        typeStr.value = 'Cloudy';
      } else if (hereWeatherCode == 'Sunny') {
        type.value = 1;
        typeStr.value = 'Sunny';
      } else if (hereWeatherCode == 'Thunderstorm') {
        type.value = 2;
        typeStr.value = 'Thunderstorm';
      } else if (hereWeatherCode == 'Rain') {
        type.value = 3;
        typeStr.value = 'Rain';
      }
    } else {
      _showPermissionDialog();
    }
  }

  void _showPermissionDialog() {
    showDialog(
      context: Get.context!,
      builder: (ctx) => AlertDialog(
        title: const Text('Location permissions required'),
        content: const Text('Please grant location permission to get distance'),
        actions: [
          TextButton(
            onPressed: () => openAppSettings(),
            child: const Text('Setting'),
          ),
        ],
      ),
    );
  }

  void onRefreshData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final colors = prefs.getStringList('color');
    mode.value = prefs.getInt('mode') ?? 0;
    if (colors != null) {
      textColor.value = Color.fromRGBO(
          int.parse(colors[0]), int.parse(colors[1]), int.parse(colors[2]), 1);
    }
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    onRefreshData();
    startTimer();
    _checkLocationPermission();
    super.onInit();
  }
}
