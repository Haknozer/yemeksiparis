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

}