import 'package:get/get.dart';

import 'week_setting_logic.dart';

class WeekSettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WeekSettingLogic());
  }
}
