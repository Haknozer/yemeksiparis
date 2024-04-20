import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:yemeksiparis/data/entity/yemekler.dart';
import 'package:yemeksiparis/data/entity/yemeklercevap.dart';

class YemeklerDaoRepository {
  int tutar = 0;

  List<Yemekler> parseYemekler(String cevap) {
    return YemeklerCevap.fromJson(jsonDecode(cevap)).yemekler;
  }

  List<SepetYemekler> parseSepetYemekler(String cevap) {
    return SepetYemeklerCevap.fromJson(jsonDecode(cevap)).yemekler;
  }

  Future<List<Yemekler>> yemekleriListele() async {
    var url = "http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php";
    var cevap = await Dio().get(url);
    return parseYemekler(cevap.data.toString());
  }

  Future<List<SepetYemekler>> sepettekiYemekleriListele() async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php";
    var veri = {"kullanici_adi": "hakan_ozer"};
    var cevap = await Dio().post(url, data: FormData.fromMap(veri));
    return parseSepetYemekler(cevap.data.toString());
  }


  Future<List<SepetYemekler>> favorileriListele() async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php";
    var veri = {"kullanici_adi": "hakan_ozer_favori"};
    var cevap = await Dio().post(url, data: FormData.fromMap(veri));
    return parseSepetYemekler(cevap.data.toString());
  }

  Future<void> sepeteEkle(String yemek_adi, String yemek_resim_adi,
      int yemek_fiyat, int yemek_siparis_adet) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php";
    var veri = {
      "yemek_adi": yemek_adi,
      "yemek_resim_adi": yemek_resim_adi,
      "yemek_fiyat": yemek_fiyat,
      "yemek_siparis_adet": yemek_siparis_adet,
      "kullanici_adi": "hakan_ozer",
    };
    var cevap = await Dio().post(url, data: FormData.fromMap(veri));
    print("Yemek eklendi : $cevap");
  }

  Future<void> favorilereEkle(String yemek_adi, String yemek_resim_adi, int yemek_fiyat, int yemek_siparis_adet) async {
    var favoriler = await favorileriListele();
    var yemek_adlari = <String>[];
    favoriler.forEach((element) {
      yemek_adlari.add(element.yemek_adi);
    });
    var url = "http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php";
      if (!(yemek_adlari.any((element) => (element) == yemek_adi))) {
        var veri = {
          "yemek_adi": yemek_adi,
          "yemek_resim_adi": yemek_resim_adi,
          "yemek_fiyat": yemek_fiyat,
          "yemek_siparis_adet": yemek_siparis_adet,
          "kullanici_adi": "hakan_ozer_favori",
        };
        var cevap = await Dio().post(url, data: FormData.fromMap(veri));
        print("favorilere eklendi : $cevap");
      }
  }

  Future<void> sepettenSil(int sepet_yemek_id, String kullanici_adi) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php";
    var veri = {
      "sepet_yemek_id": sepet_yemek_id,
      "kullanici_adi": kullanici_adi,
    };
    var cevap = await Dio().post(url, data: FormData.fromMap(veri));
    print(cevap);
  }

  Future<void> favorilerdenSil(int sepet_yemek_id, String kullanici_adi) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php";
    var veri = {
      "sepet_yemek_id": sepet_yemek_id,
      "kullanici_adi": kullanici_adi,
    };
    var cevap = await Dio().post(url, data: FormData.fromMap(veri));
    print(cevap);
  }
}
