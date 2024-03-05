class Yemekler{
  int yemek_id;
  String yemek_adi;
  String yemek_resim;
  int yemek_fiyat;

  Yemekler({required this.yemek_id,required this.yemek_adi,required this.yemek_resim,required this.yemek_fiyat});

  factory Yemekler.fromJson(Map<String,dynamic> json){
    return Yemekler(
        yemek_id: json["yemek_id"],
        yemek_adi: json["yemek_adi"],
        yemek_resim: json["yemek_resim"],
        yemek_fiyat: json["yemek_fiyat"]
    );
  }
}