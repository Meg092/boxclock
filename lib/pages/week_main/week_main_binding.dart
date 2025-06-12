import 'package:get/get.dart';

import 'week_main_logic.dart';

class WeekMainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WeekMainLogic());
  }
}
