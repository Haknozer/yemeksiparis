import 'package:yemeksiparis/data/entity/yemekler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemeksiparis/data/repo/yemeklerDao_repository.dart';
class AnaSayfaCubit extends Cubit<List<Yemekler>> {
    AnaSayfaCubit():super(<Yemekler>[]);

    var krepo = YemeklerDaoRepository();

    Future<void> yemekleriListele() async{
      var list = await krepo.yemekleriListele();
      emit(list);
    }

    Future<void> sepeteEkle(String yemek_adi,String yemek_resim_adi,int yemek_fiyat,int yemek_siparis_adet) async {
      krepo.sepeteEkle(yemek_adi, yemek_resim_adi, yemek_fiyat, yemek_siparis_adet);
    }


}