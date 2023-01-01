import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

Future fetchdata({int pincode = 600001}) async {
  final uri = await Uri.https("api.postalpincode.in", "pincode/$pincode");
  final response = await http.get(uri);
  final decoded = jsonDecode(response.body);
  List<dataModel> finalvalues = [];
  if (decoded[0]['Status'] == 'Success') {
    finalvalues = await fromJson(decoded);
  }

  dataStatusModel data =
      dataStatusModel(statuscode: decoded[0]['Status'], datalist: finalvalues);
  return data;
}

List<dataModel> fromJson(List jsno) {
  List<dataModel> objectlist = [];
  for (var i in jsno[0]['PostOffice']) {
    objectlist.add(dataModel(
        cityname: i['Name'],
        district: i['District'],
        block: i['Block'],
        state: i['State'],
        pincode: i['Pincode']));
  }
  return objectlist;
}

class dataStatusModel {
  String statuscode; // status whether success or error
  List datalist = <dataModel>[];
  dataStatusModel({required this.statuscode, required this.datalist});
}

class dataModel {
  String cityname;
  String district;
  String block;
  String state;
  String pincode;

  dataModel({
    required this.cityname,
    required this.district,
    required this.block,
    required this.state,
    required this.pincode,
  });

  void sampleprinter() {
    print(cityname);
    print(district);
    print(block);
    print(state);
    print(pincode);
  }
}
