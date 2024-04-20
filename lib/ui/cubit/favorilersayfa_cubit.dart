import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemeksiparis/data/entity/yemekler.dart';
import 'package:yemeksiparis/data/repo/yemeklerDao_repository.dart';

class FavorilerSayfaCubit extends Cubit<List<SepetYemekler>>{
  FavorilerSayfaCubit():super(<SepetYemekler>[]);

  var krepo = YemeklerDaoRepository();

  Future<void> favorileriListele() async{
    var list = await krepo.favorileriListele();
    emit(list);
  }

  Future<void> favorilerdenSil(int sepet_yemek_id) async{
    krepo.favorilerdenSil(sepet_yemek_id, "hakan_ozer_favori");
    favorileriListele();
  }
}