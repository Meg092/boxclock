import 'package:get/get.dart';

import 'week_failed_logic.dart';

class WeekFailedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WeekFailedLogic());
  }
}
