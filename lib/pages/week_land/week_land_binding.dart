import 'package:get/get.dart';

import 'week_land_logic.dart';

class WeekLandBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      PageLogic(),
      permanent: true,
    );
  }
}
