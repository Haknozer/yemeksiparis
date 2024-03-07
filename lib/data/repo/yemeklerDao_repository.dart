import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:yemeksiparis/data/entity/yemekler.dart';
import 'package:yemeksiparis/data/entity/yemeklercevap.dart';

class YemeklerDaoRepository {

  List<Yemekler> parseYemekler(String cevap){
    return YemeklerCevap.fromJson(jsonDecode(cevap)).yemekler;
  }

  Future<List<Yemekler>> yemekleriListele() async{
    var url = "http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php";
    var cevap = await Dio().get(url);
    return parseYemekler(cevap.data.toString());
  }
}