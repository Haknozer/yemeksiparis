import 'package:yemeksiparis/data/entity/yemekler.dart';

class SepetYemeklerCevap {
  List<SepetYemekler> yemekler;
  int success;

  SepetYemeklerCevap({required this.yemekler, required this.success});

  factory SepetYemeklerCevap.fromJson(Map<String, dynamic> json) {
    var jsonArray = json["sepet_yemekler"] as List;
    var success = json["success"] as int;

    var sepet_yemekler = jsonArray.map((jsonArrayNesnesi) => SepetYemekler.fromJson(jsonArrayNesnesi)).toList();

    return SepetYemeklerCevap(yemekler: sepet_yemekler, success: success);
  }
}
