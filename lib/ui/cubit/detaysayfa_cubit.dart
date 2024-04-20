import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemeksiparis/data/repo/yemeklerDao_repository.dart';

class DetaySayfaCubit extends Cubit {
  DetaySayfaCubit():super(0);

  var krepo = YemeklerDaoRepository();
  Future<void> sepeteEkle(String yemek_adi,String yemek_resim_adi,int yemek_fiyat,int yemek_siparis_adet) async {
    krepo.sepeteEkle(yemek_adi, yemek_resim_adi, yemek_fiyat, yemek_siparis_adet);
  }

  Future<void> favorilereEkle(String yemek_adi,String yemek_resim_adi,int yemek_fiyat,int yemek_siparis_adet) async {
    krepo.favorilereEkle(yemek_adi, yemek_resim_adi, yemek_fiyat, yemek_siparis_adet);
  }
}