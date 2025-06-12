import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:week_clock/pages/week_setting/week_slider.dart';

import 'week_setting_logic.dart';

class WeekSettingPage extends GetView<WeekSettingLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Setting',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        foregroundColor: Colors.white,
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
            child: GetBuilder<WeekSettingLogic>(builder: (_) {
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: <Widget>[
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    child: <Widget>[
                      const Text(
                        'Adjust the color',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      <Widget>[
                        const SizedBox(
                          width: 50,
                          child: Text(
                            'Red',
                            style: TextStyle(color: Color(0xffafafaf)),
                          ),
                        ),
                        Expanded(
                            child:
                            WeekSlider(0, controller.redValue.value, (v) async {
                              controller.redValue.value = v;
                              controller.update();
                              final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                              await prefs.setStringList('color', [
                                controller.redValue.value.toString(),
                                controller.greenValue.value.toString(),
                                controller.blueValue.value.toString()
                              ]);
                            })),
                        const SizedBox(
                          width: 8,
                        ),
                        Obx(() {
                          return Text(
                            controller.redValue.value.toString(),
                            style: const TextStyle(color: Colors.white),
                          );
                        })
                      ].toRow(),
                      <Widget>[
                        const SizedBox(
                          width: 50,
                          child: Text(
                            'Green',
                            style: TextStyle(color: Color(0xffafafaf)),
                          ),
                        ),
                        Expanded(
                            child: WeekSlider(1, controller.greenValue.value,
                                    (v) async {
                                  controller.greenValue.value = v;
                                  controller.update();
                                  final SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                                  await prefs.setStringList('color', [
                                    controller.redValue.value.toString(),
                                    controller.greenValue.value.toString(),
                                    controller.blueValue.value.toString()
                                  ]);
                                })),
                        const SizedBox(
                          width: 8,
                        ),
                        Obx(() {
                          return Text(
                            controller.greenValue.value.toString(),
                            style: const TextStyle(color: Colors.white),
                          );
                        })
                      ].toRow(),
                      <Widget>[
                        const SizedBox(
                          width: 50,
                          child: Text(
                            'Blue',
                            style: TextStyle(color: Color(0xffafafaf)),
                          ),
                        ),
                        Expanded(
                            child: WeekSlider(2, controller.blueValue.value,
                                    (v) async {
                                  controller.blueValue.value = v;
                                  controller.update();
                                  final SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                                  await prefs.setStringList('color', [
                                    controller.redValue.value.toString(),
                                    controller.greenValue.value.toString(),
                                    controller.blueValue.value.toString()
                                  ]);
                                })),
                        const SizedBox(
                          width: 8,
                        ),
                        Obx(() {
                          return Text(
                            controller.blueValue.value.toString(),
                            style: const TextStyle(color: Colors.white),
                          );
                        })
                      ].toRow()
                    ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
                  ).decorated(
                      color: const Color(0xff1f1f1f),
                      borderRadius: BorderRadius.circular(15)),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    child: <Widget>[
                      const Text(
                        'Select the dial',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              childAspectRatio: 91 / 56),
                          itemCount: 6,
                          itemBuilder: (_, index) {
                            return Container(
                              padding: const EdgeInsets.all(10),
                              child: <Widget>[
                                Image.asset(
                                  'assets/img$index.webp',
                                  fit: BoxFit.cover,
                                )
                              ].toColumn(
                                  mainAxisAlignment: MainAxisAlignment.center),
                            )
                                .decorated(
                                borderRadius: BorderRadius.circular(15),
                                color: index == controller.mode
                                    ? const Color(0xff484c50)
                                    : Colors.transparent)
                                .gestures(onTap: () async {
                              controller.mode = index;
                              controller.update();
                              final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                              await prefs.setInt('mode', index);
                            });
                          })
                    ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
                  ).decorated(
                      color: const Color(0xff1f1f1f),
                      borderRadius: BorderRadius.circular(15)),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: <Widget>[
                      const Text(
                        'App version',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Obx(() {
                        return Text(
                          controller.appVersionStr.value,
                          style: const TextStyle(color: Color(0xff9d9d9d)),
                        );
                      })
                    ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
                  ).decorated(
                      color: const Color(0xff1f1f1f),
                      borderRadius: BorderRadius.circular(15))
                ].toColumn(),
              );
            }).marginAll(15)),
      ),
    );
  }
}
