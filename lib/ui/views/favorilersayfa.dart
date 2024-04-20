import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:yemeksiparis/data/entity/yemekler.dart';
import 'package:yemeksiparis/ui/cubit/favorilersayfa_cubit.dart';
import 'package:yemeksiparis/ui/views/anasayfa.dart';
import 'package:yemeksiparis/ui/views/detaysayfa.dart';
import 'package:yemeksiparis/ui/views/profilsayfa.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemeksiparis/ui/views/sepetsayfa.dart';

class FavorilerSayfa extends StatefulWidget {
  const FavorilerSayfa({super.key});

  @override
  State<FavorilerSayfa> createState() => _FavorilerSayfaState();
}

class _FavorilerSayfaState extends State<FavorilerSayfa> {
  Color selectedColor = Colors.blue.shade900;
  var selected = 1;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<FavorilerSayfaCubit>().favorileriListele();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
      bottomNavigationBar: buildStylishBottomBar(),
      floatingActionButton: buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }

  AppBar buildAppBar() {
    return AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("Favori Yemeklerim"),
      );
  }

  Padding buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            buildBlocBuilder()
          ],
        ),
      ),
    );
  }

  Expanded buildBlocBuilder() {
    return Expanded(
      flex: 1,
      child: BlocBuilder<FavorilerSayfaCubit, List<SepetYemekler>>(
        builder: (context, yemekListe) {
          if (yemekListe.isNotEmpty) {
            return GridView.builder(
              itemCount: yemekListe.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 1 / 1.6),
              itemBuilder: (context, index) {
                var yemek = yemekListe[index];
                return buildCard(yemek, context);
              },
            );
          } else {
            return Center();
          }
        },
      ),
    );
  }

  Card buildCard(SepetYemekler yemek, BuildContext context) {
    return Card(
      child: Column(
        children: [
          buildFavoriteButton(yemek),
          Image.network(
            "http://kasimadalan.pe.hu/yemekler/resimler/${yemek.yemek_resim_adi}",
          ),
          Text(yemek.yemek_adi,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(color: Colors.blue.shade900)),
        ],
      ),
    );
  }

  IconButton buildFavoriteButton(SepetYemekler yemek) {
    return IconButton(
      onPressed: () {
        context.read<FavorilerSayfaCubit>().favorilerdenSil(int.parse(yemek.sepet_yemek_id));
      },
      icon: Align(
          alignment: Alignment.topRight,
          child:
          Icon(Icons.favorite_border, color: Colors.blue.shade900)),
    );
  }

  StylishBottomBar buildStylishBottomBar() {
    List<Widget> pages = [
      const AnaSayfa(),
      const FavorilerSayfa(),
      const ProfilSayfa(),
    ];
    return StylishBottomBar(
      option: AnimatedBarOptions(
          padding: const EdgeInsets.symmetric(vertical: 20),
          iconSize: 32,
          barAnimation: BarAnimation.fade,
          iconStyle: IconStyle.animated
      ),
      items: [
        BottomBarItem(icon: const Icon(Icons.home,), selectedColor: selectedColor, title: const Text("Anasayfa")),
        BottomBarItem(icon: const Icon(Icons.favorite),selectedColor: selectedColor,title: const Text("Favoriler")),
        BottomBarItem(icon: const Icon(Icons.person),selectedColor: selectedColor, title: const Text("Profil"))
      ],
      fabLocation: StylishBarFabLocation.end,
      hasNotch: true,
      notchStyle: NotchStyle.circle,
      currentIndex: selected,
      onTap: (value) {
        setState(() {
          selected = value;
          Navigator.push(context, MaterialPageRoute(builder: (context) => pages[value],));
        });
      },
    );
  }

  SizedBox buildFloatingActionButton() {
    return SizedBox(
      height: 80,
      width: 80,
      child: FittedBox(
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SepetSayfa(),));
          },
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40)
          ),
          backgroundColor: Colors.blue.shade900,
          child: const Icon(
            size: 32,
            Icons.local_grocery_store,
            color: Colors.white,
          ),

        ),
      ),
    );
  }

}


