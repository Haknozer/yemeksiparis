import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yemeksiparis/data/entity/yemekler.dart';
import 'package:yemeksiparis/ui/cubit/detaysayfa_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetaySayfa extends StatefulWidget {
  Yemekler yemek;
  DetaySayfa({required this.yemek});

  @override
  State<DetaySayfa> createState() => _DetaySayfaState();
}

class _DetaySayfaState extends State<DetaySayfa> {
  int miktar = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: buildCenter(context),
    );
  }

  Center buildCenter(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.network(
              "http://kasimadalan.pe.hu/yemekler/resimler/${widget.yemek.yemek_resim}"),
          Text(
            widget.yemek.yemek_fiyat,
            style: Theme.of(context)
                .textTheme
                .headlineLarge
                ?.copyWith(color: Colors.blue.shade900),
          ),
          Text(
            widget.yemek.yemek_adi,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: Colors.black87, fontWeight: FontWeight.bold),
          ),
          buildMiktarRow(context),
          buildEtiketRow(),
          buildSepetEkleRow(context)
        ],
      ),
    );
  }

  Row buildSepetEkleRow(BuildContext context) {
    return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Spacer(),
              Text(widget.yemek.yemek_fiyat,style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: Colors.blue.shade900,fontWeight: FontWeight.bold),),
              const Spacer(),
              SizedBox(
                height: 75,
                width: 200,
                child: FloatingActionButton(
                  onPressed: () {
                    context.read<DetaySayfaCubit>().sepeteEkle(widget.yemek.yemek_adi, widget.yemek.yemek_resim, int.parse(widget.yemek.yemek_fiyat), miktar);
                    Navigator.pop(context);
                    },
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  backgroundColor: Colors.blue.shade900,
                  child: Text("SEPETE EKLE",style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white,fontWeight: FontWeight.bold),),
                ),
              ),
            ],
          );
  }

  Row buildEtiketRow() {
    return Row(
            children: [
              const Spacer(flex: 1,),
              Expanded(
                flex: 4,
                child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey.shade400,
                    ),
                    child: const Text("25-35 dk",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black87))),
              ),
              const Spacer(flex: 1,),
              Expanded(
                flex: 7,
                child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey.shade400,
                    ),
                    child: const Text("Ücretsiz Teslimat",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black87))),
              ),
              const Spacer(flex: 1,),
              Expanded(
                flex: 5,
                child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey.shade400,
                    ),
                    child: const Text("İndirim %10",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black87))),
              ),
              const Spacer(flex: 1,),
            ],
          );
  }

  Row buildMiktarRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Spacer(flex: 2),
        TextButton(
          onPressed: () {
            miktar > 1 ? miktar-- : miktar = 1;
            setState(() {
              miktar;
            });
          },
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.blue.shade900),
            shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
            padding: const MaterialStatePropertyAll(EdgeInsets.all(20)),
          ),
          child: const Icon(
            Icons.remove,
            color: Colors.white,
          ),
        ),
        const Spacer(),
        Text(
          miktar.toString(),
          style: Theme.of(context)
              .textTheme
              .headlineLarge
              ?.copyWith(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        TextButton(
          onPressed: () {
            setState(() {
              miktar++;
            });
          },
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.blue.shade900),
            shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
            padding: const MaterialStatePropertyAll(EdgeInsets.all(20)),
          ),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        const Spacer(
          flex: 2,
        ),
      ],
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      systemOverlayStyle:
          SystemUiOverlayStyle(statusBarColor: Colors.blue.shade900),
      leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(
            Icons.close,
            size: 40,
          )),
      title: const Text("Ürün Detayı"),
      centerTitle: true,
      actions: [
        IconButton(
            onPressed: () {
              context.read<DetaySayfaCubit>().favorilereEkle(widget.yemek.yemek_adi, widget.yemek.yemek_resim, int.parse(widget.yemek.yemek_fiyat), 1);
            },
            icon: const Icon(
              Icons.favorite,
              size: 40,
            ))
      ],
    );
  }
}
