import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:google_fonts/google_fonts.dart';

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({super.key});

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  TextEditingController yemekArama = TextEditingController();
  bool aramaYapiyormu = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 15,),
              buildSearchTextField(),
            ],
          ),
        ),
      ),
    );
  }

  Expanded buildSearchTextField() {
    return Expanded(
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

  IconButton iconBuild(){
    return aramaYapiyormu ?
    IconButton(onPressed: (){
      setState(() {
        aramaYapiyormu= false;
        print(aramaYapiyormu);
      });
      yemekArama.clear();
    }, icon: const Icon(Icons.clear), ) :
    IconButton(onPressed: (){
      setState(() {
        aramaYapiyormu = true;
        print(aramaYapiyormu);
      });
    }, icon: const Icon(Icons.search));
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
        color: Colors.deepPurpleAccent,
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
