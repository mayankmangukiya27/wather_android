import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wather_app/appColors/app_color.dart';
import 'package:wather_app/controller/wather_controller.dart';
import 'package:wather_app/utils/constants/const_name.dart';
import 'package:wather_app/widgets/frosted_glass_effect.dart';
import 'package:wather_app/widgets/get_wather.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final WatherController watherController = Get.put(WatherController());
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColor.primeryColor,
      appBar: AppBar(
        backgroundColor: AppColor.lightBlueColor,
        centerTitle: true,
        title: const Text("Get Wather Info!!"),
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                textField(),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      watherController.wather?.current?.tempC.toString() ?? "",
                      style: const TextStyle(
                        fontSize: 45,
                        color: AppColor.whiteColor,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        watherController.wather?.current?.condition?.text
                                ?.toUpperCase() ??
                            "",
                        style: const TextStyle(
                          color: AppColor.whiteColor,
                          fontSize: 17,
                        ),
                      ),
                    )
                  ],
                ),
                Center(
                  child: Image.network(
                    watherController.wather?.current?.condition?.icon != null
                        ? "https:${watherController.wather?.current?.condition?.icon}"
                        : "https://img.freepik.com/free-photo/textured-background-white-tone_53876-128610.jpg",
                    width: width * .30,
                    height: width * .30,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  "Location Info",
                  style: titleStyle(),
                ),
                const SizedBox(
                  height: 10,
                ),
                FrostedGlassEffect(
                    widget: Column(
                  children: [
                    valueField("Name : ",
                        watherController.wather?.location?.name ?? ""),
                    valueField("Region : ",
                        watherController.wather?.location?.region ?? ""),
                    valueField("Country : ",
                        watherController.wather?.location?.country ?? ""),
                  ],
                )),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Temperature Info",
                  style: titleStyle(),
                ),
                const SizedBox(
                  height: 10,
                ),
                FrostedGlassEffect(
                    widget: Column(
                  children: [
                    valueField(
                        "Temp C : ",
                        watherController.wather?.current?.tempC.toString() ??
                            ""),
                    valueField(
                        "Temp F : ",
                        watherController.wather?.current?.tempF.toString() ??
                            ""),
                    valueField(
                        "Wind Kph : ",
                        watherController.wather?.current?.windKph.toString() ??
                            ""),
                  ],
                )),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                          onTap: () async {
                            if (watherController.cityController.text != "") {
                              await watherController.getCityLocation(
                                  watherController.cityController.text);

                              if (watherController.lat.value != "" &&
                                  watherController.long.value != "") {
                                watherController.lastLat.value =
                                    watherController.lat.value;
                                watherController.lastLong.value =
                                    watherController.long.value;

                                watherController
                                    .getWatherData(watherController.lat.value,
                                        watherController.long.value)
                                    .then((value) {
                                  watherController.clearValue();
                                });
                              } else {
                                // ignore: use_build_context_synchronously
                                getSnackBar(context, ConstName.validCityName);
                              }
                            } else {
                              watherController.clearValue();
                              getSnackBar(context, ConstName.cityName);
                            }
                          },
                          child: CommonButton(
                            height: height * .06,
                            widget: !watherController.isLoading.value
                                ? const Text(
                                    "Get Wather",
                                    style: TextStyle(
                                      color: AppColor.whiteColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                    ),
                                  )
                                : const CircularProgressIndicator(),
                          )),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: InkWell(
                          onTap: () async {
                            if (watherController.lastLat.value != "" &&
                                watherController.lastLong.value != "") {
                              watherController
                                  .refreshData(watherController.lastLat.value,
                                      watherController.lastLong.value)
                                  .then((value) {
                                watherController.clearValue();
                              });
                            } else {
                              // ignore: use_build_context_synchronously
                              getSnackBar(context, ConstName.refreshWather);
                            }
                          },
                          child: CommonButton(
                            height: height * .06,
                            widget: !watherController.isRefresh.value
                                ? const Text(
                                    "Refresh",
                                    style: TextStyle(
                                      color: AppColor.whiteColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                    ),
                                  )
                                : const CircularProgressIndicator(),
                          )),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextStyle titleStyle() =>
      const TextStyle(color: AppColor.whiteColor, fontSize: 15);

  valueField(name, value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            name,
            style: const TextStyle(fontSize: 18, color: AppColor.whiteColor),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColor.whiteColor,
            ),
          ),
        ],
      ),
    );
  }

  TextField textField() {
    return TextField(
      controller: watherController.cityController,
      decoration: InputDecoration(
        hintText: "Please Enter City Name",
        fillColor: AppColor.whiteColor,
        filled: true,
        focusedBorder: textFieldDecoration(),
        enabledBorder: textFieldDecoration(),
      ),
    );
  }

  OutlineInputBorder textFieldDecoration() {
    return OutlineInputBorder(borderRadius: BorderRadius.circular(12));
  }

  getSnackBar(context, constValue) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(constValue)));
  }
}
