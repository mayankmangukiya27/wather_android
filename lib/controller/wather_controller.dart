import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:wather_app/models/wather_model.dart';
import 'package:wather_app/utils/api/wather_api.dart';

class WatherController extends GetxController {
  WatherModel? wather;
  TextEditingController cityController = TextEditingController();
  RxString lat = "".obs;
  RxString long = "".obs;
  RxString lastLat = "".obs;
  RxString lastLong = "".obs;
  RxBool isLoading = false.obs;
  RxBool isRefresh = false.obs;
  RxList coordinateLust = [].obs;
  String cityName = "Please Enter City Name!!";
  String validCityName = "Please Enter Valid City Name!!";

  // getting let, long fron city
  Future<void> getCityLocation(city) async {
    try {
      await locationFromAddress(city).then((locations) {
        if (locations.isNotEmpty) {
          lat.value = locations[0].latitude.toString();
          long.value = locations[0].longitude.toString();
        }
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  // getting watherData
  Future<void> getWatherData(let, long) async {
    isLoading.value = true;
    wather = await watherData(let, long);
    isLoading.value = false;
  }

  // getting latest watherData
  Future<void> refreshData(let, long) async {
    isRefresh.value = true;
    wather = await watherData(let, long);
    isRefresh.value = false;
  }

  clearValue() {
    lat.value = "";
    long.value = "";
  }
}
