import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WeekSettingLogic extends GetxController {

  var redValue = 0.obs;
  var greenValue = 0.obs;
  var blueValue = 0.obs;
  var mode = 0;

  var appVersionStr = ''.obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final textColor = prefs.getStringList('color') ?? ['0', '0', '0'];
    redValue.value = int.parse(textColor[0]);
    greenValue.value = int.parse(textColor[1]);
    blueValue.value = int.parse(textColor[2]);
    mode = prefs.getInt('mode') ?? 0;
    update();
    var info = await PackageInfo.fromPlatform();
    appVersionStr.value = info.version;
    super.onInit();
  }

}
