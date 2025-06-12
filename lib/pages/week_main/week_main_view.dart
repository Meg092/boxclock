import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:week_clock/main.dart';

import 'week_main_logic.dart';

class WeekMainPage extends StatefulWidget {
  const WeekMainPage({Key? key}) : super(key: key);

  @override
  State<WeekMainPage> createState() => _WeekMainPageState();
}

class _WeekMainPageState extends State<WeekMainPage> {
  WeekMainLogic controller = Get.find();

  void checkNetwork() async {
    final hadNetwork = await InternetConnectionChecker.instance.hasConnection;
    if (!hadNetwork) {
      Get.toNamed('/failed');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    checkNetwork();
    super.initState();
  }

  Widget _weekItem(int week) {
    final weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return Text(
      weekDays[week],
      style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: controller.weekDay.value-1 == week
              ? controller.textColor.value
              : Colors.white.withOpacity(0.3)),
    ).marginOnly(right: 20);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<WeekMainLogic>(builder: (_) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          decoration:controller.mode.value == 0 ? null : BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    'assets/bg${controller.mode.value}.webp',
                  ),
                  fit: BoxFit.fill)),
          child: SafeArea(
              child: <Widget>[
            <Widget>[
              <Widget>[
                Obx(() {
                  return Image.asset(
                    'assets/icon${controller.type.value}.webp',
                    colorBlendMode: BlendMode.srcIn,
                    color: controller.textColor.value,
                    fit: BoxFit.cover,
                  );
                }),
                const SizedBox(
                  width: 10,
                ),
                Obx(() {
                  return Text(
                    '${controller.c.value}°',
                    style: TextStyle(
                        color: controller.textColor.value,
                        fontSize: 47,
                        fontWeight: FontWeight.bold),
                  );
                }),
                const SizedBox(
                  width: 10,
                ),
                Obx(() {
                  return Text(
                    controller.typeStr.value,
                    style: TextStyle(
                        color: controller.textColor.value,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  );
                })
              ].toRow(),
              const SizedBox(
                width: 170,
              ),
              Obx(() {
                return Icon(
                  Icons.settings,
                  size: 35,
                  color: controller.textColor.value,
                ).gestures(onTap: (){
                  Get.toNamed('/weekSetting')?.then((_) {
                    controller.onRefreshData();
                  });
                });
              })
            ].toRow(mainAxisAlignment: MainAxisAlignment.center),
            <Widget>[
              Obx(() {
                return Text(
                  controller.hourMinutesStr.value,
                  style: TextStyle(
                      color: controller.textColor.value,
                      fontSize: 119,
                      height: 0.8,
                      fontFamily: generalFamily,
                      fontWeight: FontWeight.bold),
                );
              }),
              <Widget>[
                Obx(() {
                  return Text(
                    controller.apmStr.value,
                    style: TextStyle(
                        color: controller.textColor.value,
                        fontSize: 19,
                        fontWeight: FontWeight.bold),
                  );
                }),
                Obx(() {
                  return Text(
                    controller.secondStr.value,
                    style: TextStyle(
                        color: controller.textColor.value,
                        fontSize: 61,
                        height: 0.8,
                        fontFamily: generalFamily,
                        fontWeight: FontWeight.bold),
                  );
                }),
              ].toColumn(crossAxisAlignment: CrossAxisAlignment.start)
            ].toRow(mainAxisAlignment: MainAxisAlignment.center),
            <Widget>[
              _weekItem(0),
              _weekItem(1),
              _weekItem(2),
              _weekItem(3),
              _weekItem(4),
              _weekItem(5),
              _weekItem(6),
            ].toRow(mainAxisAlignment: MainAxisAlignment.center)
          ].toColumn(mainAxisAlignment: MainAxisAlignment.center)),
        );
      }),
    );
  }
}
