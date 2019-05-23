// import 'dart:async';
// import 'dart:convert';

// import 'package:flutter_load_local_json/eng.dart';

// language() async {
//   String data =
//       await DefaultAssetBundle.of(context).loadString("assets/data.json");
//   final jsonResult = json.decode(data);
// }

// class Country {
//   final String name;
//   final String flag;
//   final String capital;

//   Country({this.name, this.flag, this.capital});

//   factory Country.fromJson(Map<String, dynamic> json) {
//     return new Country(
//       name: json['name'] as String,
//       flag: json['flag'] as String,
//       capital: json['capital'] as String,
//     );
//   }
// }
