import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:wather_app/models/wather_model.dart';
import 'package:wather_app/utils/constants/api_end_points.dart';
import 'package:http/http.dart' as http;

// api call for wather
Future<WatherModel?> watherData(let, long) async {
  try {
    var url = Uri.parse(APIEndPoints.watherUri(let, long));
    var response = await http.post(url);
    var responceData = jsonDecode(response.body);
    return WatherModel.fromJson(responceData);
  } catch (e) {
    if (kDebugMode) {
      print(e.toString());
    }
  }
  return null;
}
