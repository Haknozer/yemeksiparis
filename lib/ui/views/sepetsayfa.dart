import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemeksiparis/data/entity/yemekler.dart';
import 'package:yemeksiparis/ui/cubit/sepetsayfa_cubit.dart';

class SepetSayfa extends StatefulWidget {
  const SepetSayfa({super.key});

  @override
  State<SepetSayfa> createState() => _SepetSayfaState();
}

class _SepetSayfaState extends State<SepetSayfa> {
  int tutar = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<SepetSayfaCubit>().sepetYemekleriGetir();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Column(
        children: [buildExpanded(), buildBottomExpanded(context)],
      ),
    );
  }

  Expanded buildBottomExpanded(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Column(
        children: [
          const Spacer(
            flex: 3,
          ),
          buildGonderimUcretRow(context),
          buildToplamRow(context),
          buildSepetOnayButtonRow(),
          const Spacer(
            flex: 1,
          ),
        ],
      ),
    );
  }

  Row buildSepetOnayButtonRow() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Spacer(),
      Expanded(
        flex: 5,
        child: TextButton(
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.yellow),
              shape: MaterialStatePropertyAll(RoundedRectangleBorder()),
            ),
            onPressed: () {},
            child: const Text(
              "Sepeti Onayla",
              style: TextStyle(color: Colors.black),
            )),
      ),
      const Spacer(),
    ]);
  }


  Row buildGonderimUcretRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Spacer(),
        Expanded(
          flex: 5,
          child: Text(
            "Gönderim Ücreti",
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: Colors.grey),
          ),
        ),
        Text(
          "₺0",
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: Colors.grey),
        ),
        const Spacer(),
      ],
    );
  }

  Expanded buildExpanded() {
    return Expanded(
      flex: 3,
      child: BlocBuilder<SepetSayfaCubit, List<SepetYemekler>>(
        builder: (context, yemekListe) {
          if (yemekListe.isNotEmpty) {
            tutar = 0;
            yemekListe.forEach((element) {
              tutar += int.parse(element.yemek_fiyat);
            });
            return ListView.builder(
              itemCount: yemekListe.length,
              itemBuilder: (context, index) {
                var yemek = yemekListe[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Row(
                    children: [
                      Image.network(
                        "http://kasimadalan.pe.hu/yemekler/resimler/${yemek.yemek_resim_adi}",
                        height: 150,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              yemek.yemek_adi,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: [
                                const Text("Fiyat : "),
                                Text(
                                  "₺${yemek.yemek_fiyat}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            Text("Adet : ${yemek.yemek_siparis_adet}")
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.favorite,
                            size: 32,
                            color: Colors.blue.shade900,
                          ),
                          IconButton(
                            onPressed: () {
                              context.read<SepetSayfaCubit>().sepetYemekSil(
                                  int.parse(yemek.sepet_yemek_id),
                                  yemek.kullanici_adi);
                            },
                            icon: Icon(
                              Icons.restore_from_trash,
                              size: 32,
                              color: Colors.blue.shade900,
                            ),
                          ),
                          Text(
                            "${yemek.yemek_fiyat}₺",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(color: Colors.blue.shade900),
                          )
                        ],
                      )
                    ],
                  ),
                );
              },
            );
          } else {
            return Center();
          }
        },
      ),
    );
  }

  Row buildToplamRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Spacer(),
        Expanded(
          flex: 5,
          child: Text(
            "Toplam:",
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Text(
          tutar.toString(),
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
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
      title: const Text("SEPETİM"),
      centerTitle: true,
    );
  }
}
