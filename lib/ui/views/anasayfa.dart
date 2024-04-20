import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yemeksiparis/data/entity/yemekler.dart';
import 'package:yemeksiparis/ui/cubit/anasayfa_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:yemeksiparis/ui/views/detaysayfa.dart';
import 'package:yemeksiparis/ui/views/favorilersayfa.dart';
import 'package:yemeksiparis/ui/views/profilsayfa.dart';
import 'package:yemeksiparis/ui/views/sepetsayfa.dart';

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({super.key});

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  TextEditingController yemekArama = TextEditingController();
  PageController controller = PageController();
  Color selectedColor = Colors.blue.shade900;
  bool aramaYapiyormu = false;
  var selected = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AnaSayfaCubit>().yemekleriListele();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      appBar: buildAppBar(),
      body: buildBody(),
      bottomNavigationBar: buildStylishBottomBar(),
      floatingActionButton: buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
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
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => pages[value],));
          Navigator.popUntil(context, (route) => true);
        });
      },
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
            buildSearchTextField(),
            buildBlocBuilder()
          ],
        ),
      ),
    );
  }

  Expanded buildBlocBuilder() {
    return Expanded(
      flex: 9,
      child: BlocBuilder<AnaSayfaCubit, List<Yemekler>>(
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

  GestureDetector buildCard(Yemekler yemek, BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetaySayfa(yemek: yemek),)),
      child: Card(
        child: Column(
          children: [
            Expanded(
              child: buildFavoriteButton(),
            ),
            Image.network(
              "http://kasimadalan.pe.hu/yemekler/resimler/${yemek.yemek_resim}",
            ),
            Text(yemek.yemek_adi,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(color: Colors.blue.shade900)),
            buildRowGonderim(),
            buildRowSepetEkleme(yemek, context)
          ],
        ),
      ),
    );
  }

  Row buildRowSepetEkleme(Yemekler yemek, BuildContext context) {
    return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              width: 20,
            ),
            Text(
              "${yemek.yemek_fiyat}₺",
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(color: Colors.blue.shade900),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                context.read<AnaSayfaCubit>().sepeteEkle(yemek.yemek_adi,yemek.yemek_resim, int.parse(yemek.yemek_fiyat), 1);
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero),
              child: const Icon(
                Icons.add,
                size: 35,
              ),
            ),
          ],
        );
  }

  Row buildRowGonderim() {
    return const Row(
          children: [
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.directions_bike_outlined,
              color: Colors.green,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "Ücretsiz Gönderim",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        );
  }

  IconButton buildFavoriteButton() {
    return IconButton(
            onPressed: () {},
            icon: Align(
                alignment: Alignment.topRight,
                child:
                    Icon(Icons.favorite_border, color: Colors.blue.shade900)),
          );
  }

  Expanded buildSearchTextField() {
    return Expanded(
      flex: 1,
      child: TextField(
        onChanged: (value) {
          aramaYapiyormu = true;
          iconBuild();
        },
        controller: yemekArama,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 4.0),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 4.0),
          ),
          suffixIcon: iconBuild(),
          hintText: "Ara",
        ),
      ),
    );
  }

  IconButton iconBuild() {
    return aramaYapiyormu
        ? IconButton(
            onPressed: () {
              setState(() {
                aramaYapiyormu = false;
                print(aramaYapiyormu);
              });
              yemekArama.clear();
            },
            icon: const Icon(Icons.clear),
          )
        : IconButton(
            onPressed: () {
              setState(() {
                aramaYapiyormu = true;
                print(aramaYapiyormu);
              });
            },
            icon: const Icon(Icons.search));
  }

  AppBar buildAppBar() {
    return AppBar(
      flexibleSpace: buildClipPath(),
      title: buildAdres(),
    );
  }

  ClipPath buildClipPath() {
    return ClipPath(
      clipper: WaveClipperTwo(),
      child: Container(
        color: Colors.blue.shade900,
        child: Align(
            alignment: const Alignment(-0.75, 0.7),
            child: Text(
              "Merhaba",
              style: GoogleFonts.styleScript(color: Colors.white, fontSize: 25),
            )),
      ),
    );
  }

  Align buildAdres() {
    return Align(
      alignment: const Alignment(0.75, 0.7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Teslimat Adresi",
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(color: Colors.blueGrey),
              ),
              Text(
                "Evim",
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(color: Colors.grey),
              ),
            ],
          ),
          const Icon(Icons.home, size: 40),
        ],
      ),
    );
  }
}
