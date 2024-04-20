import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemeksiparis/data/entity/yemekler.dart';
import 'package:yemeksiparis/data/repo/yemeklerDao_repository.dart';
class SepetSayfaCubit extends Cubit<List<SepetYemekler>>{
  SepetSayfaCubit():super(<SepetYemekler>[]);

  var krepo = YemeklerDaoRepository();

  Future<void> sepetYemekleriGetir() async{
    var list = await krepo.sepettekiYemekleriListele();
    emit(list);
  }

  Future<void> sepetYemekSil(int sepet_yemek_id,String kullanici_adi) async {
    krepo.sepettenSil(sepet_yemek_id, kullanici_adi);
    sepetYemekleriGetir();
  }

}