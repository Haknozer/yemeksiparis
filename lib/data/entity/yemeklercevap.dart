import 'package:yemeksiparis/data/entity/yemekler.dart';

class YemeklerCevap{
  List<Yemekler> yemekler;
  int success;

  YemeklerCevap({required this.yemekler,required this.success});


  factory YemeklerCevap.fromJson(Map<String,dynamic> json){
    var jsonArray = json["yemekler"] as List;
    var success = json["success"] as int;

    var yemekler = jsonArray.map((jsonArrayNesnesi) => Yemekler.fromJson(jsonArrayNesnesi)).toList();

    return YemeklerCevap(yemekler: yemekler, success: success);
  }
}


class SepetYemeklerCevap{
  List<SepetYemekler> yemekler;
  int success;

  SepetYemeklerCevap({required this.yemekler,required this.success});


  factory SepetYemeklerCevap.fromJson(Map<String,dynamic> json){
    var jsonArray = json["sepet_yemekler"] as List;
    var success = json["success"] as int;

    var yemekler = jsonArray.map((jsonArrayNesnesi) => SepetYemekler.fromJson(jsonArrayNesnesi)).toList();

    return SepetYemeklerCevap(yemekler: yemekler, success: success);
  }
}