import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:google_fonts/google_fonts.dart';
class AnaSayfa extends StatefulWidget {
  const AnaSayfa({super.key});

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(title: Text("Merhaba",style: GoogleFonts.styleScript(fontSize: 30,color: Colors.white)))
    );
  }
}


class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Text title;
  final double barHeight = 50.0;

  MainAppBar({Key? key,required this.title}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 50.0);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 100),
        child: ClipPath(
          clipper: WaveClipperTwo(),
          child: Container(
            color: Colors.blue,
            child: Align(
              alignment: const Alignment(-0.75, 0.7),
                child: title),
          ),
        ));
  }
}
